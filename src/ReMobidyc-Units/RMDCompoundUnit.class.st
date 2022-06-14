Class {
	#name : #RMDCompoundUnit,
	#superclass : #RMDUnit,
	#instVars : [
		'unitSymbolsAndOrders'
	],
	#category : #'ReMobidyc-Units'
}

{ #category : #'instance creation' }
RMDCompoundUnit class >> from: aDictionary [
	^ self new
		setUnitSymbolsAndOrders: aDictionary;
		yourself
]

{ #category : #'instance creation' }
RMDCompoundUnit class >> noDimension [
	^ self from: OrderedDictionary new
]

{ #category : #'instance creation' }
RMDCompoundUnit class >> with: aRMDUnitSymbol [
	^ self
		from:
			(OrderedDictionary new
				at: aRMDUnitSymbol put: 1;
				yourself)
]

{ #category : #arithmetics }
RMDCompoundUnit >> * aRMDUnit [
	| syms |
	syms := unitSymbolsAndOrders copy.
	aRMDUnit
		symbolsAndOrdersDo: [ :symbol :order | 
			| newOrder |
			newOrder := (syms at: symbol ifAbsent: [ 0 ]) + order.
			newOrder = 0
				ifTrue: [ syms removeKey: symbol ifAbsent: [  ] ]
				ifFalse: [ syms at: symbol put: newOrder ] ].
	(syms size = 1 and: [ syms values anyOne = 1 ])
		ifTrue: [ ^ syms keys anyOne ].
	^ self class from: syms
]

{ #category : #arithmetics }
RMDCompoundUnit >> ** anInteger [
	| syms |
	syms := OrderedDictionary new: unitSymbolsAndOrders size.
	unitSymbolsAndOrders
		keysAndValuesDo: [ :symbol :order | syms at: symbol put: order * anInteger ].
	(syms size = 1 and: [ syms values anyOne = 1 ])
		ifTrue: [ ^ syms keys anyOne ].
	^ self class from: syms
]

{ #category : #arithmetics }
RMDCompoundUnit >> / aRMDUnit [
	| syms |
	syms := unitSymbolsAndOrders copy.
	aRMDUnit
		symbolsAndOrdersDo: [ :symbol :order | 
			| newOrder |
			newOrder := (syms at: symbol ifAbsent: [ 0 ]) - order.
			newOrder = 0
				ifTrue: [ syms removeKey: symbol ifAbsent: [  ] ]
				ifFalse: [ syms at: symbol put: newOrder ] ].
	(syms size = 1 and: [ syms values anyOne = 1 ])
		ifTrue: [ ^ syms keys anyOne ].
	^ self class from: syms
]

{ #category : #comparing }
RMDCompoundUnit >> = anObject [
	^ self == anObject
		or: [ self class = anObject class
				and: [ unitSymbolsAndOrders = anObject unitSymbolsAndOrders ] ]
]

{ #category : #conversions }
RMDCompoundUnit >> fromSI: aNumber [
	| value |
	value := aNumber.
	unitSymbolsAndOrders
		keysAndValuesDo: [ :unit :order | 
			unit isProportional
				ifFalse:
					[ ^ self conversionError: unit printString , ' can not be converted.' ].
			order >= 0
				ifTrue: [ order timesRepeat: [ value := unit fromSI: value ] ]
				ifFalse: [ order abs timesRepeat: [ value := unit toSI: value ] ] ].
	^ value
]

{ #category : #testing }
RMDCompoundUnit >> hasDimension [
	^ unitSymbolsAndOrders notEmpty
]

{ #category : #comparing }
RMDCompoundUnit >> hash [
	^ self class hash bitXor: unitSymbolsAndOrders hash
]

{ #category : #testing }
RMDCompoundUnit >> isCompound [
	^ true
]

{ #category : #testing }
RMDCompoundUnit >> isProportional [
	unitSymbolsAndOrders
		keysDo: [ :unit | 
			unit isProportional
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #printing }
RMDCompoundUnit >> printOn: aStream [

	(unitSymbolsAndOrders associations select: [ :assoc | 
		 assoc value > 0 ])
		ifEmpty: [ aStream nextPutAll: '1' ]
		ifNotEmpty: [ :numerators | 
			numerators
				do: [ :assoc | 
					assoc key printOn: aStream.
					assoc value ~= 1 ifTrue: [ 
						aStream nextPut: $^.
						assoc value printOn: aStream ] ]
				separatedBy: [ aStream nextPut: $  ] ].
	(unitSymbolsAndOrders associations select: [ :assoc | 
		 assoc value < 0 ]) ifNotEmpty: [ :denominators | 
		aStream nextPutAll: '/'.
		denominators
			do: [ :assoc | 
				assoc key printOn: aStream.
				assoc value ~= -1 ifTrue: [ 
					aStream nextPut: $^.
					assoc value abs printOn: aStream ] ]
			separatedBy: [ aStream nextPut: $  ] ]
]

{ #category : #private }
RMDCompoundUnit >> setUnitSymbolsAndOrders: aDictionary [
	unitSymbolsAndOrders := aDictionary
]

{ #category : #accessing }
RMDCompoundUnit >> siUnit [
	^ unitSymbolsAndOrders associations
		inject: self class noDimension
		into: [ :unit :assoc | unit siUnit * (assoc key siUnit ** assoc value) ]
]

{ #category : #enumerating }
RMDCompoundUnit >> symbolsAndOrdersDo: aBlock [
	unitSymbolsAndOrders keysAndValuesDo: aBlock
]

{ #category : #conversions }
RMDCompoundUnit >> toSI: aNumber [
	| value |
	value := aNumber.
	unitSymbolsAndOrders
		keysAndValuesDo: [ :unit :order | 
			unit isProportional
				ifFalse:
					[ ^ self conversionError: unit printString , ' can not be converted.' ].
			order >= 0
				ifTrue: [ order timesRepeat: [ value := unit toSI: value ] ]
				ifFalse: [ order abs timesRepeat: [ value := unit fromSI: value ] ] ].
	^ value
]

{ #category : #private }
RMDCompoundUnit >> unitSymbolsAndOrders [
	^ unitSymbolsAndOrders
]
