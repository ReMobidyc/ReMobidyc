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
RMDMemoryTest >> testAllocateCellsXY [
	| cell individual |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	individual := memory allocateCells: cell x: 2 y: 3.
	self
		assert: individual + (cell totalNumberOfAttributes * 2 * 3)
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
RMDMemoryTest >> testCell [
	| cell individual |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	individual := memory allocateCells: cell x: 2 y: 3.
	self assert: memory cell equals: individual
]

{ #category : #tests }
RMDMemoryTest >> testCellAtXIndexYIndex [
	| cell |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	memory allocateCells: cell x: 2 y: 3.
	self
		assert:
			(Array
				streamContents: [ :stream | 
					1 to: 2 do: [ :x | 
						1 to: 3 do:
							[ :y | stream nextPut: (memory cellAtXIndex: x yIndex: y) ] ] ])
				asSortedCollection asArray
		equals:
			(memory cell to: memory cell + (cell totalNumberOfAttributes * 5)
			by: cell totalNumberOfAttributes) asArray
]

{ #category : #tests }
RMDMemoryTest >> testCellSize [
	| cell |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	memory allocateCells: cell x: 2 y: 3.
	self
		assert: memory cellSize
		equals: cell totalNumberOfAttributes
]

{ #category : #tests }
RMDMemoryTest >> testCellsDo [
	| cell |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	memory allocateCells: cell x: 2 y: 3.
	self
		assert:
			(Array
				streamContents:
					[ :stream | memory cellsDo: [ :individual | stream nextPut: individual ] ])
		equals:
			(memory cell to: memory cell + (cell totalNumberOfAttributes * 5) by: cell totalNumberOfAttributes)
				asArray
]

{ #category : #tests }
RMDMemoryTest >> testEastOfDo [
	memory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		eastOf: (memory cellAtXIndex: 2 yIndex: 2)
		do: [ :cell | self fail ].
	self
		should: [ memory
				eastOf: (memory cellAtXIndex: 1 yIndex: 2)
				do: [ :cell | 
					self assert: cell equals: (memory cellAtXIndex: 2 yIndex: 2).
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
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		northOf: (memory cellAtXIndex: 2 yIndex: 3)
		do: [ :cell | self fail ].
	self
		should: [ memory
				northOf: (memory cellAtXIndex: 2 yIndex: 2)
				do: [ :cell | 
					self assert: cell equals: (memory cellAtXIndex: 2 yIndex: 3).
					Error signal ] ]
		raise: Error.
	self
		should: [ memory
				northOf: (memory cellAtXIndex: 2 yIndex: 1)
				do: [ :cell | 
					self assert: cell equals: (memory cellAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDMemoryTest >> testOldAt [
	memory
		at: 1 put: 2;
		at: 3 put: 4;
		tick;
		at: 1 put: 5;
		at: 3 put: 6.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self should: [ memory oldAt: 7 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testOldAtIfAbsent [
	memory
		at: 1 put: 2;
		at: 3 put: 4;
		tick;
		at: 1 put: 5;
		at: 6 put: 7.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 1 ifAbsent: [ 8 ]) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self assert: (memory oldAt: 3 ifAbsent: [ 9 ]) equals: 4.
	self should: [ memory oldAt: 6 ] raise: KeyNotFound.
	self assert: (memory oldAt: 6 ifAbsent: [ 10 ]) equals: 10
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

	| t |
	t := memory time.
	memory seedAt: 1 put: 10.
	memory seedAt: 2 put: 20.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20.
	memory tick.
	memory removeSeedAt: 1.
	self assert: (memory seedAt: 1) equals: 1.
	self assert: (memory seedAt: 2) equals: 20.
	memory time: t.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20
]

{ #category : #tests }
RMDMemoryTest >> testSeedAt [

	memory tick.
	memory seedAt: 1 put: 10.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 2.
	memory time: 0.
	self assert: (memory seedAt: 1) equals: 1.
	self assert: (memory seedAt: 2) equals: 2.
	memory time: 1.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 2
]

{ #category : #tests }
RMDMemoryTest >> testSeedAtPut [

	| t |
	t := memory time.
	memory seedAt: 1 put: 10.
	memory seedAt: 2 put: 20.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20.
	memory tick.
	memory seedAt: 1 put: 30.
	self assert: (memory seedAt: 1) equals: 30.
	self assert: (memory seedAt: 2) equals: 20.
	memory time: t.
	self assert: (memory seedAt: 1) equals: 10.
	self assert: (memory seedAt: 2) equals: 20
]

{ #category : #tests }
RMDMemoryTest >> testSouthOfDo [
	memory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		southOf: (memory cellAtXIndex: 2 yIndex: 1)
		do: [ :cell | self fail ].
	self
		should: [ memory
				southOf: (memory cellAtXIndex: 2 yIndex: 2)
				do: [ :cell | 
					self assert: cell equals: (memory cellAtXIndex: 2 yIndex: 1).
					Error signal ] ]
		raise: Error.
	self
		should: [ memory
				southOf: (memory cellAtXIndex: 2 yIndex: 3)
				do: [ :cell | 
					self assert: cell equals: (memory cellAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDMemoryTest >> testTick [
	memory at: 1 put: 2.
	memory at: 3 put: 4.
	memory nextAt: 5 put: 6.
	memory nextAt: 3 put: 7.
	self assert: (memory at: 1) equals: 2.
	self assert: (memory at: 3) equals: 4.
	self assert: (memory nextAt: 5) equals: 6.
	self should: [ memory at: 5 ] raise: KeyNotFound.
	memory tick.
	self assert: (memory at: 1) equals: 2.
	self assert: (memory at: 3) equals: 7.
	self assert: (memory at: 5) equals: 6.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self should: [ memory oldAt: 5 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testTime [
	memory at: 1 put: 2.
	memory at: 3 put: 4.
	memory nextAt: 1 put: 5.
	memory tick.
	memory at: 3 put: 6.
	memory nextAt: 1 put: 7.
	memory tick.
	memory at: 8 put: 9.
	memory time: 1.
	self assert: (memory at: 1) equals: 5.
	self assert: (memory at: 3) equals: 6.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	memory time: 2.
	self assert: (memory at: 1) equals: 7.
	self assert: (memory at: 3 ifAbsent: [ 10 ]) equals: 4.
	self assert: (memory at: 8) equals: 9.
	self assert: (memory oldAt: 1) equals: 5.
	self assert: (memory oldAt: 3) equals: 6.
	self assert: (memory oldAt: 8 ifAbsent: [ 11 ]) equals: 11
]

{ #category : #tests }
RMDMemoryTest >> testWestOfDo [
	memory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	memory
		westOf: (memory cellAtXIndex: 1 yIndex: 2)
		do: [ :cell | self fail ].
	self
		should: [ memory
				westOf: (memory cellAtXIndex: 2 yIndex: 2)
				do: [ :cell | 
					self assert: cell equals: (memory cellAtXIndex: 1 yIndex: 2).
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
RMDMemoryTest >> testXCellOf [
	memory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	self
		assert: (memory xCellOf: (memory cellAtXIndex: 1 yIndex: 1))
		equals: 1.
	self
		assert: (memory xCellOf: (memory cellAtXIndex: 2 yIndex: 1))
		equals: 2.
	self
		assert: (memory xCellOf: (memory cellAtXIndex: 1 yIndex: 2))
		equals: 1.
	self
		assert: (memory xCellOf: (memory cellAtXIndex: 2 yIndex: 2))
		equals: 2
]

{ #category : #tests }
RMDMemoryTest >> testYCellOf [
	memory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	self
		assert: (memory yCellOf: (memory cellAtXIndex: 1 yIndex: 1))
		equals: 1.
	self
		assert: (memory yCellOf: (memory cellAtXIndex: 2 yIndex: 1))
		equals: 1.
	self
		assert: (memory yCellOf: (memory cellAtXIndex: 1 yIndex: 2))
		equals: 2.
	self
		assert: (memory yCellOf: (memory cellAtXIndex: 2 yIndex: 2))
		equals: 2
]
