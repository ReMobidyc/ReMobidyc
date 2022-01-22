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
		'seeds',
		'ins',
		'outs'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #allocating }
RMDMemory >> addAnimat: aRMDAnimatDefinitionNode lifehistory: anArrayOfInteger [

	| individual animat |
	self nextAvailableSlot: (individual := self nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfProperties.
	animat := aRMDAnimatDefinitionNode identifier.
	(ins at: animat ifAbsentPut: [ Set new ]) add:
		(anArrayOfInteger copyWith: individual).
	^ individual
]

{ #category : #allocating }
RMDMemory >> allocateAnimat: aRMDAnimatDefinitionNode [

	| individual animat |
	self nextAvailableSlot: (individual := self nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfProperties.
	animat := aRMDAnimatDefinitionNode identifier.
	(animats at: animat ifAbsentPut: [ Set new: 1024 ]) add:
		(Array with: individual).
	^ individual
]

{ #category : #allocating }
RMDMemory >> allocateCells: aRMDCellDefinitionNode x: anInteger1 y: anInteger2 [
	self
		nextAvailableSlot:
			(self
				cellSize: (aRMDCellDefinitionNode totalNumberOfProperties max: 1);
				cellSize)
				*
					(self
						xCells: anInteger1;
						xCells)
				*
					(self
						yCells: anInteger2;
						yCells)
				+
					(self
						cell: self nextAvailableSlot;
						cell).
	^ self cell
]

{ #category : #allocating }
RMDMemory >> allocateWorld: aRMDWorldDefinitionNode [
	self
		nextAvailableSlot:
			aRMDWorldDefinitionNode totalNumberOfProperties
				+ (world := self nextAvailableSlot).
	^ world
]

{ #category : #'accessing-individuals' }
RMDMemory >> animatsOf: aString do: aBlock [

	(animats at: aString ifAbsent: [ ^ self ]) asArray do: [ :ids | 
		aBlock cull: ids last cull: ids]
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
RMDMemory >> cell: anInteger [
	cell := anInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> cellAtXIndex: anInteger yIndex: anotherInteger [
	^ ((anotherInteger - 1) * self xCells + anInteger - 1)
		* self cellSize + self cell
]

{ #category : #'accessing-individuals' }
RMDMemory >> cellSize [
	^ cellSize
]

{ #category : #'accessing-individuals' }
RMDMemory >> cellSize: anInteger [
	cellSize := anInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> cellsDo: aBlock [

	self cellSize > 0 ifTrue: [ 
		self cell to:
		self cellSize * self xCells * self yCells + self cell - 1 by:
		self cellSize do: [ :c | aBlock cull: c cull: (Array with: c) ] ]
]

{ #category : #allocating }
RMDMemory >> commitIns [

	ins keysAndValuesDo: [ :animatName :individuals | 
		(animats at: animatName ifAbsentPut: [ Set new: 1024 ]) addAll:
			individuals ].
	ins removeAll
]

{ #category : #allocating }
RMDMemory >> commitOuts [

	animats keysAndValuesDo: [ :animatName :individuals | 
		individuals asArray do: [ :individual | 
			(outs includes: individual last) ifTrue: [ 
				individuals remove: individual ifAbsent: [  ] ] ] ].
	outs removeAll
]

{ #category : #'accessing-individuals' }
RMDMemory >> eastOf: anInteger do: aBlock [
	(self xCellOf: anInteger) < self xCells
		ifTrue: [ aBlock value: anInteger + self cellSize ]
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
	seeds := Dictionary new.
	ins := Dictionary new.
	outs := Set new: 1024
]

{ #category : #accessing }
RMDMemory >> latestTime [
	^ latestTime
]

{ #category : #accessing }
RMDMemory >> latestTime: anInteger [
	latestTime := anInteger
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
RMDMemory >> nextAvailableSlot [
	^ nextAvailableSlot
]

{ #category : #accessing }
RMDMemory >> nextAvailableSlot: anInteger [
	nextAvailableSlot := anInteger
]

{ #category : #accessing }
RMDMemory >> nextDeltaAt: anInteger add: aNumber [
	^ nextDeltas
		at: anInteger
		put: (nextDeltas at: anInteger ifAbsent: [ 0 ]) + aNumber
]

{ #category : #'accessing-individuals' }
RMDMemory >> northOf: anInteger do: aBlock [
	(self yCellOf: anInteger) < self yCells
		ifTrue: [ aBlock value: anInteger + (self cellSize * self xCells) ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> numberOfAnimats: aString [
	^ (animats at: aString ifAbsent: [ ^ 0 ]) size
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
RMDMemory >> readSeedsForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> readValuesForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #allocating }
RMDMemory >> removeAnimat: anInteger [

	^ outs add: anInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> removeSeedAt: anInteger [

	^ seeds
		  removeKey: anInteger
		  ifAbsent: [ KeyNotFound signal: anInteger ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> seedAt: anInteger [

	^ seeds at: anInteger ifAbsent: [ KeyNotFound signal: anInteger ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> seedAt: anInteger put: anotherInteger [

	^ seeds at: anInteger put: anotherInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> southOf: anInteger do: aBlock [
	(self yCellOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - (self cellSize * self xCells) ]
]

{ #category : #timing }
RMDMemory >> sunrise [
	oldValues := time >= 1
		ifTrue: [ self readValuesForTime: time - 1 ]
		ifFalse: [ Dictionary new ].
	values := self readValuesForTime: time.
	nextValues := values copy.
	nextDeltas := Dictionary new.
	animats := self readAnimatsForTime: time.
	seeds := self readSeedsForTime: time
]

{ #category : #timing }
RMDMemory >> sunset [

	self commitOuts.
	values keysAndValuesDo: [ :id :value | 
		nextValues at: id ifAbsentPut: [ value ] ].
	nextDeltas ifNotEmpty: [ 
		nextValuesDirty := true.
		nextDeltas keysAndValuesDo: [ :id :delta | 
			| nextValue |
			nextValue := nextValues at: id ifAbsent: [ values at: id ].
			nextValue ifNotNil: [ nextValues at: id put: nextValue + delta ] ] ].
	nextValues keysAndValuesRemove: [ :id :value | 
		value isNil and: [ 
			nextDeltas removeKey: id ifAbsent: [  ].
			nextValuesDirty := true.
			true ] ].
	valuesDirty ifTrue: [ self writeValues: values forTime: time ].
	nextValuesDirty ifTrue: [ 
		self writeValues: nextValues forTime: time + 1 ].
	self writeAnimats: animats forTime: time.
	self writeSeeds: seeds forTime: time.
	self commitIns
]

{ #category : #timing }
RMDMemory >> tick [

	self fastSunset.
	time := time + 1.
	self latestTime: (latestTime max: time).
	self fastSunrise
]

{ #category : #timing }
RMDMemory >> time [
	^ time
]

{ #category : #timing }
RMDMemory >> time: anInteger [

	(anInteger isInteger and: [ 
		 anInteger between: 0 and: self latestTime ]) ifFalse: [ 
		^ SubscriptOutOfBounds signal ].
	self sunset.
	time := anInteger.
	self latestTime: (latestTime max: time).
	self sunrise
]

{ #category : #'accessing-individuals' }
RMDMemory >> westOf: anInteger do: aBlock [
	(self xCellOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - self cellSize ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> world [
	^ world
]

{ #category : #'accessing-individuals' }
RMDMemory >> worldDo: aBlock [

	aBlock cull: world cull: { world }
]

{ #category : #'accessing-storage' }
RMDMemory >> writeAnimats: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> writeSeeds: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> writeValues: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-individuals' }
RMDMemory >> xCellOf: anInteger [
	^ (anInteger - self cell) // self cellSize \\ self xCells + 1
]

{ #category : #'accessing-individuals' }
RMDMemory >> xCells [
	^ xCells
]

{ #category : #'accessing-individuals' }
RMDMemory >> xCells: anInteger [
	xCells := anInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> yCellOf: anInteger [
	^ (anInteger - self cell) // self cellSize // self xCells + 1
]

{ #category : #'accessing-individuals' }
RMDMemory >> yCells [
	^ yCells
]

{ #category : #'accessing-individuals' }
RMDMemory >> yCells: anInteger [
	yCells := anInteger
]
