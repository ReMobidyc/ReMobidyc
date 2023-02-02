Class {
	#name : #RMDMemory,
	#superclass : #Object,
	#instVars : [
		'time',
		'latestTime',
		'nextValues',
		'nextDeltas',
		'values',
		'nextAvailableSlot',
		'stageLinks',
		'reproductionLinks',
		'world',
		'animats',
		'seeds',
		'ins',
		'outs',
		'patch',
		'patchSize',
		'xPatches',
		'yPatches',
		'runId',
		'randomSeed',
		'metaparameters'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #allocating }
RMDMemory >> allocateAnimat: aRMDAnimatDefinitionNode [

	| individual animat |
	self nextAvailableSlot: (individual := self nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfAttributes.
	animat := aRMDAnimatDefinitionNode identifier.
	(animats at: animat ifAbsentPut: [ Set new: 1024 ]) add: individual.
	^ individual
]

{ #category : #allocating }
RMDMemory >> allocatePatches: aRMDPatchDefinitionNode x: anInteger1 y: anInteger2 [
	self
		nextAvailableSlot:
			(self
				patchSize: (aRMDPatchDefinitionNode totalNumberOfAttributes max: 1);
				patchSize)
				*
					(self
						xPatches: anInteger1;
						xPatches)
				*
					(self
						yPatches: anInteger2;
						yPatches)
				+
					(self
						patch: self nextAvailableSlot;
						patch).
	^ self patch
]

{ #category : #allocating }
RMDMemory >> allocateWorld: aRMDWorldDefinitionNode [
	self
		nextAvailableSlot:
			aRMDWorldDefinitionNode totalNumberOfAttributes
				+ (world := self nextAvailableSlot).
	^ world
]

{ #category : #'accessing-individuals' }
RMDMemory >> animatOfIndividual: anInteger ifAbsent: errorBlock [

	animats keysAndValuesDo: [ :animat :inds | 
		(inds includes: anInteger) ifTrue: [ ^ animat ] ].
	^ errorBlock value
]

{ #category : #'accessing-individuals' }
RMDMemory >> animatsOf: aString do: aBlock [

	(animats at: aString ifAbsent: [ ^ self ]) asArray do: [ :individual | 
		aBlock cull: individual ]
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

	^ values at: anInteger put: aNumber
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
			(outs includes: individual) ifTrue: [ 
				individuals remove: individual ifAbsent: [  ].
				seeds removeKey: individual ifAbsent: [  ].
				stageLinks removeKey: individual ifAbsent: [  ].
				reproductionLinks removeKey: individual ifAbsent: [  ] ] ].
		individuals size * 10 < individuals capacity ifTrue: [ 
			individuals compact ] ].
	outs size * 10 < outs capacity
		ifTrue: [ outs := Set new: outs size * 4 // 3 + 2 ]
		ifFalse: [ outs removeAll ].
	seeds size * 10 < seeds capacity ifTrue: [ seeds compact ].
	stageLinks size * 10 < stageLinks capacity ifTrue: [ 
		stageLinks compact ].
	reproductionLinks size * 10 < reproductionLinks capacity ifTrue: [ 
		reproductionLinks compact ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> eastOf: anInteger do: aBlock [
	(self xPatchOf: anInteger) < self xPatches
		ifTrue: [ aBlock value: anInteger + self patchSize ]
]

{ #category : #timing }
RMDMemory >> fastSunrise [

	nextValues size * 10 < nextValues capacity ifTrue: [ 
		nextValues compact ].
	values := nextValues copy.
	nextDeltas := Dictionary new
]

{ #category : #timing }
RMDMemory >> fastSunset [
	^ self sunset
]

{ #category : #'accessing-links' }
RMDMemory >> findCurrentOf: anInteger ifPresent: aBlock ifAbsent: errorBlock [

	| individual |
	individual := anInteger.
	(self animatOfIndividual: individual ifAbsent: [ nil ]) ifNotNil: [ 
		:animat | ^ aBlock cull: individual cull: animat ].
	[ 
	individual := self previousStageOf: individual.
	individual notNil ] whileTrue: [ 
		(self animatOfIndividual: individual ifAbsent: [ nil ]) ifNotNil: [ 
			:animat | ^ aBlock cull: individual cull: animat ] ].
	individual := anInteger.
	[ 
	individual := stageLinks keyAtValue: individual ifAbsent: [ nil ].
	individual notNil ] whileTrue: [ 
		(self animatOfIndividual: individual ifAbsent: [ nil ]) ifNotNil: [ 
			:animat | ^ aBlock cull: individual cull: animat ] ].
	^ errorBlock value
]

{ #category : #'accessing-links' }
RMDMemory >> firstStageOf: anInteger [

	| stage prevStage |
	stage := anInteger.
	[ 
	prevStage := self previousStageOf: stage.
	prevStage notNil ] whileTrue: [ stage := prevStage ].
	^ stage
]

{ #category : #initialization }
RMDMemory >> initialize [

	super initialize.
	time := -1.
	latestTime := -1.
	nextValues := Dictionary new.
	values := Dictionary new.
	nextDeltas := Dictionary new.
	nextAvailableSlot := 1.
	xPatches := 0.
	yPatches := 0.
	patchSize := 0.
	world := nil.
	patch := nil.
	stageLinks := Dictionary new.
	reproductionLinks := Dictionary new.
	animats := Dictionary new.
	seeds := Dictionary new.
	ins := Dictionary new.
	outs := Set new: 1024
]

{ #category : #testing }
RMDMemory >> isRewindable [

	^ true
]

{ #category : #accessing }
RMDMemory >> latestTime [
	^ latestTime
]

{ #category : #accessing }
RMDMemory >> latestTime: anInteger [
	latestTime := anInteger
]

{ #category : #'accessing-meta parameters' }
RMDMemory >> metaparameters [

	^ metaparameters
]

{ #category : #'accessing-meta parameters' }
RMDMemory >> metaparametersString [

	^ String streamContents: [ :stream | 
		  metaparameters keys
			  do: [ :placeholder | 
				  stream
					  nextPutAll: placeholder identifier;
					  nextPutAll: '='.
				  (metaparameters at: placeholder) printOn: stream ]
			  separatedBy: [ stream nextPutAll: ', ' ] ]
]

{ #category : #accessing }
RMDMemory >> name [

	^ self subclassResponsibility
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
	(self yPatchOf: anInteger) < self yPatches
		ifTrue: [ aBlock value: anInteger + (self patchSize * self xPatches) ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> numberOfAnimats: aString [
	^ (animats at: aString ifAbsent: [ ^ 0 ]) size
]

{ #category : #'accessing-individuals' }
RMDMemory >> parentOf: anInteger [

	^ reproductionLinks at: anInteger ifAbsent: [ nil ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> patch [
	^ patch
]

{ #category : #'accessing-individuals' }
RMDMemory >> patch: anInteger [
	patch := anInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> patchAtXIndex: anInteger yIndex: anotherInteger [
	^ ((anotherInteger - 1) * self xPatches + anInteger - 1)
		* self patchSize + self patch
]

{ #category : #'accessing-individuals' }
RMDMemory >> patchSize [
	^ patchSize
]

{ #category : #'accessing-individuals' }
RMDMemory >> patchSize: anInteger [
	patchSize := anInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> patchesDo: aBlock [

	self patchSize > 0 ifTrue: [ 
		self patch to:
		self patchSize * self xPatches * self yPatches + self patch - 1 by:
		self patchSize do: [ :c | aBlock cull: c ] ]
]

{ #category : #'accessing-links' }
RMDMemory >> previousStageOf: anInteger [

	^ stageLinks at: anInteger ifAbsent: [ nil ]
]

{ #category : #'accessing-meta parameters' }
RMDMemory >> randomSeed [

	^ randomSeed ifNil: [ 1 ]
]

{ #category : #'accessing-storage' }
RMDMemory >> readAnimatsForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> readReproductionLinksForTime: anInteger [

	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> readSeedsForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> readStageLinksForTime: anInteger [

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
		  ifAbsent: []
]

{ #category : #allocating }
RMDMemory >> reproduceAnimat: aRMDAnimatDefinitionNode with: anInteger [

	| individual animat |
	self nextAvailableSlot: (individual := self nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfAttributes.
	animat := aRMDAnimatDefinitionNode identifier.
	(ins at: animat ifAbsentPut: [ Set new ]) add: individual.
	reproductionLinks at: individual put: anInteger.
	^ individual
]

{ #category : #'accessing-meta parameters' }
RMDMemory >> runId [

	^ runId ifNil: [ 1 ]
]

{ #category : #'accessing-meta parameters' }
RMDMemory >> runId: anInteger metaparameters: aDictionary randomSeed: anotherInteger [

	runId := anInteger.
	metaparameters := aDictionary.
	randomSeed := anotherInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> seedAt: anInteger [

	^ seeds at: anInteger ifAbsent: [ anInteger ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> seedAt: anInteger put: anotherInteger [

	^ seeds at: anInteger put: anotherInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> southOf: anInteger do: aBlock [
	(self yPatchOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - (self patchSize * self xPatches) ]
]

{ #category : #allocating }
RMDMemory >> stageAnimat: aRMDAnimatDefinitionNode with: anInteger [

	| individual animat |
	self nextAvailableSlot: (individual := self nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfAttributes.
	animat := aRMDAnimatDefinitionNode identifier.
	(ins at: animat ifAbsentPut: [ Set new ]) add: individual.
	stageLinks at: individual put: anInteger.
	^ individual
]

{ #category : #'accessing-links' }
RMDMemory >> stageHistoryOf: anInteger [

	| stage |
	stage := anInteger.
	^ (Array streamContents: [ :stream | 
		   | prevStage |
		   [ 
		   stream nextPut: stage.
		   prevStage := self previousStageOf: stage.
		   prevStage notNil ] whileTrue: [ stage := prevStage ] ]) reverse
]

{ #category : #timing }
RMDMemory >> sunrise [

	values := self readValuesForTime: time.
	nextValues := values copy.
	nextDeltas := Dictionary new.
	animats := self readAnimatsForTime: time.
	seeds := self readSeedsForTime: time.
	stageLinks := self readStageLinksForTime: time.
	reproductionLinks := self readReproductionLinksForTime: time
]

{ #category : #timing }
RMDMemory >> sunset [

	self
		commitOuts;
		commitIns.
	nextDeltas ifNotEmpty: [ 
		nextDeltas keysAndValuesDo: [ :id :delta | 
			| nextValue |
			nextValue := nextValues at: id ifAbsent: [ values at: id ].
			nextValue ifNotNil: [ nextValues at: id put: nextValue + delta ] ] ].
	nextValues keysAndValuesRemove: [ :id :value | 
		value isNil and: [ 
			nextDeltas removeKey: id ifAbsent: [  ].
			true ] ].
	latestTime = time ifTrue: [ 
		self writeValues: nextValues forTime: time + 1.
		self writeAnimats: animats forTime: time + 1.
		self writeSeeds: seeds forTime: time + 1.
		self writeReproductionLinks: reproductionLinks forTime: time + 1.
		self writeStageLinks: stageLinks forTime: time + 1 ]
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

	time = anInteger ifTrue: [ ^ self ].
	(anInteger isInteger and: [ 
		 anInteger between: 0 and: self latestTime + 1 ]) ifFalse: [ 
		^ SubscriptOutOfBounds signal ].
	self sunset.
	time := anInteger.
	self latestTime: (latestTime max: time).
	self sunrise
]

{ #category : #'accessing-individuals' }
RMDMemory >> westOf: anInteger do: aBlock [
	(self xPatchOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - self patchSize ]
]

{ #category : #'accessing-individuals' }
RMDMemory >> world [
	^ world
]

{ #category : #'accessing-individuals' }
RMDMemory >> worldDo: aBlock [

	aBlock cull: world
]

{ #category : #'accessing-storage' }
RMDMemory >> writeAnimats: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> writeReproductionLinks: aDictionary forTime: anInteger [

	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> writeSeeds: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> writeStageLinks: aDictionary forTime: anInteger [

	^ self subclassResponsibility
]

{ #category : #'accessing-storage' }
RMDMemory >> writeValues: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #'accessing-individuals' }
RMDMemory >> xPatchOf: anInteger [
	^ (anInteger - self patch) // self patchSize \\ self xPatches + 1
]

{ #category : #'accessing-individuals' }
RMDMemory >> xPatches [
	^ xPatches
]

{ #category : #'accessing-individuals' }
RMDMemory >> xPatches: anInteger [
	xPatches := anInteger
]

{ #category : #'accessing-individuals' }
RMDMemory >> yPatchOf: anInteger [
	^ (anInteger - self patch) // self patchSize // self xPatches + 1
]

{ #category : #'accessing-individuals' }
RMDMemory >> yPatches [
	^ yPatches
]

{ #category : #'accessing-individuals' }
RMDMemory >> yPatches: anInteger [
	yPatches := anInteger
]
