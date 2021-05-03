Class {
	#name : #RMDMemory,
	#superclass : #Object,
	#instVars : [
		'time',
		'latestTime',
		'nextValues',
		'nextDeltas',
		'values',
		'oldValues',
		'old2Values',
		'valuesDirty',
		'nextValuesDirty',
		'nextAvailableSlot',
		'world',
		'cell',
		'xCells',
		'yCells',
		'cellSize',
		'animats',
		'stages'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #allocating }
RMDMemory >> allocateAnimat: aRMDAnimatDefinitionNode [
	| individual animat |
	nextAvailableSlot := (individual := nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfProperties.
	animat := aRMDAnimatDefinitionNode identifier.
	(animats at: animat ifAbsentPut: [ Set new: 1024 ]) add: individual.
	stages
		at: individual
		put: (OrderedCollection with: animat -> individual).
	^ individual
]

{ #category : #allocating }
RMDMemory >> allocateCells: aRMDCellDefinitionNode x: anInteger1 y: anInteger2 [
	nextAvailableSlot := (cellSize := aRMDCellDefinitionNode
		totalNumberOfProperties max: 1) * (xCells := anInteger1)
		* (yCells := anInteger2) + (cell := nextAvailableSlot).
	^ cell
]

{ #category : #allocating }
RMDMemory >> allocateWorld: aRMDWorldDefinitionNode [
	nextAvailableSlot := aRMDWorldDefinitionNode totalNumberOfProperties
		+ (world := nextAvailableSlot).
	^ world
]

{ #category : #'accessing-individuals' }
RMDMemory >> animatsOf: aString do: aBlock [
	(animats at: aString ifAbsent: [ ^ self ]) asArray
		do: [ :id | aBlock value: id ]
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

{ #category : #'accessing-individuals' }
RMDMemory >> cell [
	^ cell
]

{ #category : #'accessing-individuals' }
RMDMemory >> cellAtXIndex: anInteger yIndex: anotherInteger [
	^ ((anotherInteger - 1) * xCells + anInteger - 1) * cellSize + cell
]

{ #category : #'accessing-individuals' }
RMDMemory >> cellSize [
	^ cellSize
]

{ #category : #'accessing-individuals' }
RMDMemory >> cellsDo: aBlock [
	cellSize > 0
		ifTrue:
			[ cell to: cellSize * xCells * yCells + cell - 1 by: cellSize do: aBlock ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> eastOf: anInteger do: aBlock [
	(self xCellOf: anInteger) < xCells
		ifTrue: [ aBlock value: anInteger + cellSize ]
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

{ #category : #initialization }
RMDMemory >> initialize [
	super initialize.
	time := 0.
	latestTime := 0.
	nextValues := Dictionary new.
	values := Dictionary new.
	oldValues := Dictionary new.
	old2Values := Dictionary new.
	nextDeltas := Dictionary new.
	valuesDirty := false.
	nextValuesDirty := false.
	nextAvailableSlot := 1.
	xCells := 0.
	yCells := 0.
	cellSize := 0.
	world := 1.
	cell := nil.
	animats := Dictionary new.
	stages := Dictionary new
]

{ #category : #accessing }
RMDMemory >> latestTime [
	^ latestTime
]

{ #category : #'accessing-individuals' }
RMDMemory >> migrate: anInteger animat: aString to: anotherInteger animat: anotherString [
	stages
		at: anotherInteger
		put:
			((stages at: anInteger)
				add: anotherString -> anotherInteger;
				yourself)
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
RMDMemory >> nextDeltaAt: anInteger add: aNumber [
	^ nextDeltas
		at: anInteger
		put: (nextDeltas at: anInteger ifAbsent: [ 0 ]) + aNumber
]

{ #category : #'accessing-individuals' }
RMDMemory >> northOf: anInteger do: aBlock [
	(self yCellOf: anInteger) < yCells
		ifTrue: [ aBlock value: anInteger + (cellSize * xCells) ]
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
RMDMemory >> readAnimatsForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> readValuesForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #allocating }
RMDMemory >> remove: anInteger animat: aRMDAnimatDefinitionNode ifAbsent: errorBlock [
	^ (animats
		at: aRMDAnimatDefinitionNode identifier
		ifAbsent: [ ^ errorBlock value ])
		remove: anInteger
		ifAbsent: errorBlock
]

{ #category : #'accessing-individuals' }
RMDMemory >> southOf: anInteger do: aBlock [
	(self yCellOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - (cellSize * xCells) ]
]

{ #category : #timing }
RMDMemory >> sunrise [
	oldValues := time >= 1
		ifTrue: [ self readValuesForTime: time - 1 ]
		ifFalse: [ Dictionary new ].
	values := self readValuesForTime: time.
	nextValues := values copy.
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
				and: [ nextDeltas removeKey: id ifAbsent: [].
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
	latestTime := latestTime max: time.
	self fastSunrise
]

{ #category : #timing }
RMDMemory >> time [
	^ time
]

{ #category : #timing }
RMDMemory >> time: anInteger [
	(anInteger isInteger
		and: [ anInteger between: 0 and: self latestTime ])
		ifFalse: [ ^ SubscriptOutOfBounds signal ].
	self sunset.
	time := anInteger.
	latestTime := latestTime max: time.
	self sunrise
]

{ #category : #'accessing-individuals' }
RMDMemory >> westOf: anInteger do: aBlock [
	(self xCellOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - cellSize ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> world [
	^ world
]

{ #category : #'accessing-individuals' }
RMDMemory >> worldDo: aBlock [
	aBlock value: world
]

{ #category : #'accessing-storage' }
RMDMemory >> writeAnimats: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> writeValues: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-individuals' }
RMDMemory >> xCellOf: anInteger [
	^ (anInteger - cell) // cellSize \\ xCells + 1
]

{ #category : #'accessing-individuals' }
RMDMemory >> yCellOf: anInteger [
	^ (anInteger - cell) // cellSize // xCells + 1
]
