Class {
	#name : #RMDCompoundUnit,
	#superclass : #RMDUnit,
	#instVars : [
		'unitSymbolsAndOrders'
	],
	#category : #'ReMobidyc-Language-Units'
}

{ #category : #'instance creation' }
RMDCompoundUnit class >> from: aDictionary [
	^ self new
		setUnitSymbolsAndOrders: aDictionary;
		yourself
]

{ #category : #'instance creation' }
RMDCompoundUnit class >> with: aRMDUnitSymbol [
	^ self
		from:
			(Dictionary new
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
	syms := Dictionary new: unitSymbolsAndOrders size.
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
	^ self class = anObject class
		and: [ unitSymbolsAndOrders = anObject unitSymbolsAndOrders ]
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
	| hasPositiveOrder hasNegativeOrder |
	hasPositiveOrder := false.
	hasNegativeOrder := false.
	unitSymbolsAndOrders
		keysAndValuesDo: [ :unit :order | 
			order > 0
				ifTrue: [ hasPositiveOrder := true.
					unit printOn: aStream.
					order > 1
						ifTrue: [ aStream nextPut: $^.
							order printOn: aStream ].
					aStream nextPut: Character space ].
			order < 0
				ifTrue: [ hasNegativeOrder := true ] ].
	hasPositiveOrder
		ifFalse: [ aStream nextPutAll: '1' ].
	hasNegativeOrder
		ifTrue: [ aStream nextPutAll: '/ ' ].
	unitSymbolsAndOrders
		keysAndValuesDo: [ :unit :order | 
			order < 0
				ifTrue: [ unit printOn: aStream.
					order < -1
						ifTrue: [ aStream nextPut: $^.
							order abs printOn: aStream ].
					aStream nextPut: Character space ] ]
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
