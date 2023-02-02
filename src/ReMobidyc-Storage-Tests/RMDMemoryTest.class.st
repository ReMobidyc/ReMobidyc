Class {
	#name : #RMDMemoryTest,
	#superclass : #TestCase,
	#instVars : [
		'memory',
		'parser'
	],
	#category : #'ReMobidyc-Storage-Tests'
}

{ #category : #testing }
RMDMemoryTest class >> isAbstract [
	^ self name = #RMDMemoryTest
]

{ #category : #private }
RMDMemoryTest >> createMemory [
	^ self subclassResponsibility
]

{ #category : #private }
RMDMemoryTest >> destroyMemory [
	^ self subclassResponsibility
]

{ #category : #running }
RMDMemoryTest >> setUp [
	memory := self createMemory.
	parser := RMDGrammar new
]

{ #category : #running }
RMDMemoryTest >> tearDown [
	self destroyMemory
]

{ #category : #tests }
RMDMemoryTest >> testAllocateAnimat [
	| animat individual |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	blood_sugar [kcal]
	speed [km/h].'.
	individual := memory allocateAnimat: animat.
	self
		assert: individual + animat totalNumberOfAttributes
		equals:
			(memory
				allocateAnimat:
					(parser animatDefinition end
						parse:
							'Goat is Animat.'))
]

{ #category : #tests }
RMDMemoryTest >> testAllocatePatchesXY [
	| patch individual |
	patch := parser patchDefinition end
		parse:
			'Patch with
	grass [kcal]
	fertility [kcal].'.
	individual := memory allocatePatches: patch x: 2 y: 3.
	self
		assert: individual + (patch totalNumberOfAttributes * 2 * 3)
		equals:
			(memory
				allocateAnimat: (parser animatDefinition end parse: 'Goat is Animat.'))
]

{ #category : #tests }
RMDMemoryTest >> testAllocateWorld [
	| world individual |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [DegreeC]
	humidity [].'.
	individual := memory allocateWorld: world.
	self
		assert: individual + world totalNumberOfAttributes
		equals:
			(memory
				allocateAnimat: (parser animatDefinition end parse: 'Goat is Animat.'))
]

{ #category : #tests }
RMDMemoryTest >> testAnimatsOfDo [
	| animat individuals |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	blood_sugar [kcal]
	speed [km/h].'.
	individuals := Array
		streamContents: [ :stream | 
			10
				timesRepeat: [ stream nextPut: (memory allocateAnimat: animat) ] ].
	self
		assert: individuals
		equals:
			(individuals first to: individuals first + (animat totalNumberOfAttributes * 9)
			by: animat totalNumberOfAttributes) asArray
]

{ #category : #tests }
RMDMemoryTest >> testAt [
	memory at: 1 put: 2.
	self assert: (memory at: 1) equals: 2.
	self should: [ memory at: 3 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testAtIfAbsent [
	memory at: 1 put: 2.
	self assert: (memory at: 1 ifAbsent: [ 3 ]) equals: 2.
	self assert: (memory at: 2 ifAbsent: [ 3 ]) equals: 3.
	memory at: 2 put: 4.
	self deny: (memory at: 2 ifAbsent: [ 3 ]) equals: 3.
	self assert: (memory at: 2 ifAbsent: [ 3 ]) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testAtIfAbsentPut [
	memory at: 1 ifAbsentPut: [ 2 ].
	self assert: (memory at: 1) equals: 2.
	memory at: 1 ifAbsentPut: [ 3 ].
	self deny: (memory at: 1) equals: 3.
	self assert: (memory at: 1) equals: 2.
	memory at: 2 ifAbsentPut: [ 4 ].
	self assert: (memory at: 2) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testAtPut [
	memory at: 1 put: 2.
	memory at: 3 put: 4.
	self assert: (memory at: 1) equals: 2.
	self assert: (memory at: 3) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testEastOfDo [
	memory
		allocatePatches:
			(parser patchDefinition end
				parse:
					'Patch with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		eastOf: (memory patchAtXIndex: 2 yIndex: 2)
		do: [ :patch | self fail ].
	self
		should: [ memory
				eastOf: (memory patchAtXIndex: 1 yIndex: 2)
				do: [ :patch | 
					self assert: patch equals: (memory patchAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDMemoryTest >> testNextAt [
	memory nextAt: 1 put: 2.
	self assert: (memory nextAt: 1) equals: 2.
	self should: [ memory nextAt: 3 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testNextAtIfAbsent [
	memory nextAt: 1 put: 2.
	self assert: (memory nextAt: 1 ifAbsent: [ 3 ]) equals: 2.
	self assert: (memory nextAt: 2 ifAbsent: [ 3 ]) equals: 3.
	memory nextAt: 2 put: 4.
	self deny: (memory nextAt: 2 ifAbsent: [ 3 ]) equals: 3.
	self assert: (memory nextAt: 2 ifAbsent: [ 3 ]) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testNextAtIfAbsentPut [
	memory nextAt: 1 put: 2.
	self assert: (memory nextAt: 1 ifAbsentPut: [ 3 ]) equals: 2.
	memory nextAt: 1 ifAbsentPut: [ 4 ].
	self deny: (memory nextAt: 1) equals: 4.
	self assert: (memory nextAt: 1) equals: 2.
	memory nextAt: 2 ifAbsentPut: [ 4 ].
	self assert: (memory nextAt: 2) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testNextAtPut [
	memory nextAt: 1 put: 2.
	memory nextAt: 3 put: 4.
	self assert: (memory nextAt: 1) equals: 2.
	self assert: (memory nextAt: 3) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testNorthOfDo [
	memory
		allocatePatches:
			(parser patchDefinition end
				parse:
					'Patch with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		northOf: (memory patchAtXIndex: 2 yIndex: 3)
		do: [ :patch | self fail ].
	self
		should: [ memory
				northOf: (memory patchAtXIndex: 2 yIndex: 2)
				do: [ :patch | 
					self assert: patch equals: (memory patchAtXIndex: 2 yIndex: 3).
					Error signal ] ]
		raise: Error.
	self
		should: [ memory
				northOf: (memory patchAtXIndex: 2 yIndex: 1)
				do: [ :patch | 
					self assert: patch equals: (memory patchAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDMemoryTest >> testPatch [
	| patch individual |
	patch := parser patchDefinition end
		parse:
			'Patch with
	grass [kcal]
	fertility [kcal].'.
	individual := memory allocatePatches: patch x: 2 y: 3.
	self assert: memory patch equals: individual
]

{ #category : #tests }
RMDMemoryTest >> testPatchAtXIndexYIndex [
	| patch |
	patch := parser patchDefinition end
		parse:
			'Patch with
	grass [kcal]
	fertility [kcal].'.
	memory allocatePatches: patch x: 2 y: 3.
	self
		assert:
			(Array
				streamContents: [ :stream | 
					1 to: 2 do: [ :x | 
						1 to: 3 do:
							[ :y | stream nextPut: (memory patchAtXIndex: x yIndex: y) ] ] ])
				asSortedCollection asArray
		equals:
			(memory patch to: memory patch + (patch totalNumberOfAttributes * 5)
			by: patch totalNumberOfAttributes) asArray
]

{ #category : #tests }
RMDMemoryTest >> testPatchSize [
	| patch |
	patch := parser patchDefinition end
		parse:
			'Patch with
	grass [kcal]
	fertility [kcal].'.
	memory allocatePatches: patch x: 2 y: 3.
	self
		assert: memory patchSize
		equals: patch totalNumberOfAttributes
]

{ #category : #tests }
RMDMemoryTest >> testPatchesDo [
	| patch |
	patch := parser patchDefinition end
		parse:
			'Patch with
	grass [kcal]
	fertility [kcal].'.
	memory allocatePatches: patch x: 2 y: 3.
	self
		assert:
			(Array
				streamContents:
					[ :stream | memory patchesDo: [ :individual | stream nextPut: individual ] ])
		equals:
			(memory patch to: memory patch + (patch totalNumberOfAttributes * 5) by: patch totalNumberOfAttributes)
				asArray
]

{ #category : #tests }
RMDMemoryTest >> testRemoveAnimat [

	| animat goat1 goat2 |
	animat := parser animatDefinition end parse: 'Goat is Animat with
	blood_sugar [kcal]
	speed [km/h].'.
	goat1 := memory allocateAnimat: animat.
	goat2 := memory allocateAnimat: animat.
	memory removeAnimat: goat1.
	memory commitOuts.
	self
		assert: (Array streamContents: [ :stream | 
				 memory animatsOf: 'Goat' do: [ :goat | stream nextPut: goat ] ])
				asSet
		equals: (Set with: goat2)
]

{ #category : #tests }
RMDMemoryTest >> testRemoveSeedAt [

	self assert: memory time equals: -1.
	memory seedAt: 1 put: 10.
	memory seedAt: 2 put: 20.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20.
	memory tick.
	memory removeSeedAt: 1.
	self assert: (memory seedAt: 1) equals: 1.
	self assert: (memory seedAt: 2) equals: 20.
	memory tick.
	memory time: 0.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20
]

{ #category : #tests }
RMDMemoryTest >> testSeedAt [
	memory tick.
	memory seedAt: 1 put: 10.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 2.
	memory tick.
	memory time: 0.
	self assert: (memory seedAt: 1) equals: 1.
	self assert: (memory seedAt: 2) equals: 2.
	memory time: 1.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 2
]

{ #category : #tests }
RMDMemoryTest >> testSeedAtPut [
	memory seedAt: 1 put: 10.
	memory seedAt: 2 put: 20.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20.
	memory tick.
	memory seedAt: 1 put: 30.
	self assert: (memory seedAt: 1) equals: 30.
	self assert: (memory seedAt: 2) equals: 20.
	memory tick.
	memory time: 0.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20
]

{ #category : #tests }
RMDMemoryTest >> testSouthOfDo [

	memory
		allocatePatches: (parser patchDefinition end parse: 'Patch with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		southOf: (memory patchAtXIndex: 2 yIndex: 1)
		do: [ :patch | self fail ].
	self
		should: [ 
			memory
				southOf: (memory patchAtXIndex: 2 yIndex: 2)
				do: [ :patch | 
					self assert: patch equals: (memory patchAtXIndex: 2 yIndex: 1).
					Error signal ] ]
		raise: Error.
	self
		should: [ 
			memory
				southOf: (memory patchAtXIndex: 2 yIndex: 3)
				do: [ :patch | 
					self assert: patch equals: (memory patchAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDMemoryTest >> testTick [

	memory nextAt: 1 put: 2.0.
	memory nextAt: 3 put: 4.0.
	memory nextAt: 5 put: 6.0.
	memory nextAt: 3 put: 7.0.
	self should: [memory at: 1] raise: KeyNotFound.
	self should: [memory at: 3] raise: KeyNotFound.
	self should: [ memory at: 5 ] raise: KeyNotFound.
	memory tick.
	self assert: (memory at: 1) equals: 2.0.
	self assert: (memory at: 3) equals: 7.0.
	self assert: (memory at: 5) equals: 6.0
]

{ #category : #tests }
RMDMemoryTest >> testTime [
	memory tick.
	memory nextAt: 3 put: 4.0.
	memory nextAt: 1 put: 5.0.
	memory tick.
	memory nextAt: 3 put: 6.0.
	memory nextAt: 1 put: 7.0.
	memory tick.
	memory nextAt: 8 put: 9.0.
	memory time: 1.
	self assert: (memory at: 1) equals: 5.0.
	self assert: (memory at: 3) equals: 4.0.
	memory time: 3.
	self assert: (memory at: 1) equals: 7.0.
	self assert: (memory at: 3 ifAbsent: [ 10.0 ]) equals: 6.0.
	self assert: (memory at: 8) equals: 9.0
]

{ #category : #tests }
RMDMemoryTest >> testWestOfDo [
	memory
		allocatePatches:
			(parser patchDefinition end
				parse:
					'Patch with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		westOf: (memory patchAtXIndex: 1 yIndex: 2)
		do: [ :patch | self fail ].
	self
		should: [ memory
				westOf: (memory patchAtXIndex: 2 yIndex: 2)
				do: [ :patch | 
					self assert: patch equals: (memory patchAtXIndex: 1 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDMemoryTest >> testWorld [
	| world individual |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [DegreeC]
	humidity [].'.
	individual := memory allocateWorld: world.
	self assert: memory world equals: individual
]

{ #category : #tests }
RMDMemoryTest >> testWorldDo [
	| world individual |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [DegreeC]
	humidity [].'.
	individual := memory allocateWorld: world.
	self
		assert:
			(Array
				streamContents: [ :stream | memory worldDo: [ :w | stream nextPut: w ] ])
		equals: {individual}
]

{ #category : #tests }
RMDMemoryTest >> testXPatchOf [
	memory
		allocatePatches:
			(parser patchDefinition end
				parse:
					'Patch with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	self
		assert: (memory xPatchOf: (memory patchAtXIndex: 1 yIndex: 1))
		equals: 1.
	self
		assert: (memory xPatchOf: (memory patchAtXIndex: 2 yIndex: 1))
		equals: 2.
	self
		assert: (memory xPatchOf: (memory patchAtXIndex: 1 yIndex: 2))
		equals: 1.
	self
		assert: (memory xPatchOf: (memory patchAtXIndex: 2 yIndex: 2))
		equals: 2
]

{ #category : #tests }
RMDMemoryTest >> testYPatchOf [
	memory
		allocatePatches:
			(parser patchDefinition end
				parse:
					'Patch with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	self
		assert: (memory yPatchOf: (memory patchAtXIndex: 1 yIndex: 1))
		equals: 1.
	self
		assert: (memory yPatchOf: (memory patchAtXIndex: 2 yIndex: 1))
		equals: 1.
	self
		assert: (memory yPatchOf: (memory patchAtXIndex: 1 yIndex: 2))
		equals: 2.
	self
		assert: (memory yPatchOf: (memory patchAtXIndex: 2 yIndex: 2))
		equals: 2
]
