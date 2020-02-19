Class {
	#name : #RMDMemory,
	#superclass : #Object,
	#instVars : [
		'time',
		'nextValues',
		'nextDeltas',
		'values',
		'oldValues',
		'old2Values',
		'valuesDirty',
		'nextValuesDirty',
		'nextAvailableSlot',
		'individuals'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #'accessing-agents' }
RMDMemory >> allocateIndividualOf: aRMDAnimatDefinitionNode [
	| individual |
	nextAvailableSlot := (individual := nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfProperties.
	(individuals
		at: aRMDAnimatDefinitionNode
		ifAbsentPut: [ Set new: 1024 ]) add: individual.
	^ individual
]

{ #category : #accessing }
RMDMemory >> at: anInteger [
	^ self at: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> at: anInteger ifAbsent: aBlock [
	^ values at: anInteger ifAbsent: aBlock
]

{ #category : #accessing }
RMDMemory >> at: anInteger ifAbsentPut: aBlock [
	^ self
		at: anInteger
		ifAbsent: [ self at: anInteger put: aBlock value ]
]

{ #category : #accessing }
RMDMemory >> at: anInteger put: aNumber [
	valuesDirty := true.
	^ values at: anInteger put: aNumber
]

{ #category : #accessing }
RMDMemory >> delta2At: anInteger ifAbsent: errorBlock [
	^ (self oldAt: anInteger ifAbsent: [ ^ errorBlock value ]) * -2
		+ (self at: anInteger ifAbsent: [ ^ errorBlock value ])
		+ (self old2At: anInteger ifAbsent: [ ^ errorBlock value ])
]

{ #category : #accessing }
RMDMemory >> deltaAt: anInteger [
	^ self deltaAt: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> deltaAt: anInteger ifAbsent: errorBlock [
	^ (self at: anInteger ifAbsent: [ ^ errorBlock value ])
		- (self oldAt: anInteger ifAbsent: [ ^ errorBlock value ])
]

{ #category : #timing }
RMDMemory >> fastSunrise [
	old2Values := oldValues.
	oldValues := values.
	values := nextValues copy.
	nextDeltas := Dictionary new.
	valuesDirty := false.
	nextValuesDirty := false
]

{ #category : #timing }
RMDMemory >> fastSunset [
	^ self sunset
]

{ #category : #'accessing-agents' }
RMDMemory >> individualsOf: aRMDAnimatDefinitionNode do: aBlock [
	(individuals at: aRMDAnimatDefinitionNode ifAbsent: [ #() ])
		do: [ :id | aBlock value: id ]
]

{ #category : #'accessing-agents' }
RMDMemory >> individualsOf: aRMDSpeciesNode doWithSpecies: aBlock [
	(individuals at: aRMDSpeciesNode ifAbsent: [ #() ])
		do: [ :id | aBlock value: id value: aRMDSpeciesNode ]
]

{ #category : #initialization }
RMDMemory >> initialize [
	super initialize.
	time := 0.
	nextValues := Dictionary new.
	values := Dictionary new.
	oldValues := Dictionary new.
	old2Values := Dictionary new.
	nextDeltas := Dictionary new.
	valuesDirty := false.
	nextValuesDirty := false.
	nextAvailableSlot := 1.
	individuals := Dictionary new
]

{ #category : #accessing }
RMDMemory >> nextAt: anInteger [
	^ self nextAt: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> nextAt: anInteger ifAbsent: aBlock [
	^ nextValues at: anInteger ifAbsent: aBlock
]

{ #category : #accessing }
RMDMemory >> nextAt: anInteger ifAbsentPut: aBlock [
	^ self
		nextAt: anInteger
		ifAbsent: [ self nextAt: anInteger put: aBlock value ]
]

{ #category : #accessing }
RMDMemory >> nextAt: anInteger put: aNumber [
	nextValuesDirty := true.
	^ nextValues at: anInteger put: aNumber
]

{ #category : #accessing }
RMDMemory >> nextDeltaAt: anInteger [
	^ self nextDeltaAt: anInteger ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> nextDeltaAt: anInteger add: aNumber [
	^ nextDeltas
		at: anInteger
		put: (nextDeltas at: anInteger ifAbsent: [ 0 ]) + aNumber
]

{ #category : #accessing }
RMDMemory >> nextDeltaAt: anInteger ifAbsent: errorBlock [
	^ nextDeltas at: anInteger ifAbsent: errorBlock
]

{ #category : #accessing }
RMDMemory >> nextDeltaAt: anInteger ifAbsentPut: errorBlock [
	^ nextDeltas
		at: anInteger
		ifAbsent: [ self nextDeltaAt: anInteger add: errorBlock value ]
]

{ #category : #accessing }
RMDMemory >> old2At: anInteger [
	^ self old2At: anInteger ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> old2At: anInteger ifAbsent: errorBlock [
	^ old2Values at: anInteger ifAbsent: errorBlock
]

{ #category : #accessing }
RMDMemory >> oldAt: anInteger [
	^ self oldAt: anInteger ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> oldAt: anInteger ifAbsent: errorBlock [
	^ oldValues at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-storage' }
RMDMemory >> readValuesForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #timing }
RMDMemory >> sunrise [
	oldValues := time >= 2
		ifTrue: [ self readValuesForTime: time - 2 ]
		ifFalse: [ Dictionary new ].
	oldValues := time >= 1
		ifTrue: [ self readValuesForTime: time - 1 ]
		ifFalse: [ Dictionary new ].
	values := self readValuesForTime: time.
	nextValues := self readValuesForTime: time + 1.
	nextDeltas := Dictionary new
]

{ #category : #timing }
RMDMemory >> sunset [
	values
		keysAndValuesDo: [ :id :value | nextValues at: id ifAbsentPut: [ value ] ].
	nextDeltas
		ifNotEmpty: [ nextValuesDirty := true.
			nextDeltas
				keysAndValuesDo: [ :id :delta | 
					| nextValue |
					nextValue := nextValues at: id ifAbsent: [ values at: id ].
					nextValue ifNotNil: [ nextValues at: id put: nextValue + delta ] ] ].
	nextValues
		keysAndValuesRemove: [ :id :value | 
			value isNil
				and: [ nextDeltas removeKey: id.
					nextValuesDirty := true.
					true ] ].
	valuesDirty
		ifTrue: [ self writeValues: values forTime: time ].
	nextValuesDirty
		ifTrue: [ self writeValues: nextValues forTime: time + 1 ]
]

{ #category : #timing }
RMDMemory >> tick [
	self fastSunset.
	time := time + 1.
	self fastSunrise
]

{ #category : #timing }
RMDMemory >> time [
	^ time
]

{ #category : #timing }
RMDMemory >> time: anInteger [
	(anInteger isInteger and: [ anInteger >= 0 ])
		ifFalse: [ ^ SubscriptOutOfBounds signal ].
	self sunset.
	time := anInteger.
	self sunrise
]

{ #category : #'accessing-storage' }
RMDMemory >> writeValues: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]
