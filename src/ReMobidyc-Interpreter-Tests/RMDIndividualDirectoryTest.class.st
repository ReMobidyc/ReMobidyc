Class {
	#name : #RMDIndividualDirectoryTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'individualDirectory'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDIndividualDirectoryTest >> setUp [
	individualDirectory := RMDIndividualDirectory new.
	parser := RMDGrammar new.
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testAllocateAnimat [
	| animat individual |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	blood_sugar [kcal]
	speed [km/h].'.
	individual := individualDirectory allocateAnimat: animat.
	self
		assert: individual + animat totalNumberOfProperties
		equals:
			(individualDirectory
				allocateAnimat:
					(parser animatDefinition end
						parse:
							'Goat is Animat.'))
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testAllocateCellsXY [
	| cell individual |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	individual := individualDirectory allocateCells: cell x: 2 y: 3.
	self
		assert: individual + (cell totalNumberOfProperties * 2 * 3)
		equals:
			(individualDirectory
				allocateAnimat: (parser animatDefinition end parse: 'Goat is Animat.'))
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testAllocateWorld [
	| world individual |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [C]
	humidity [].'.
	individual := individualDirectory allocateWorld: world.
	self
		assert: individual + world totalNumberOfProperties
		equals:
			(individualDirectory
				allocateAnimat: (parser animatDefinition end parse: 'Goat is Animat.'))
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testAnimatNamesDo [
	individualDirectory
		allocateAnimat:
			(parser animatDefinition end
				parse:
					'Goat is Animat with
	blood_sugar [kcal]
	speed [km/h].').
	individualDirectory
		allocateAnimat:
			(parser animatDefinition end
				parse:
					'Wolf is Animat with
	blood_sugar [kcal]
	speed [km/h]
	sprint_speed [km/h]
	sprint_time [s]
	max_sprint_time [s].').
	self
		assert:
			(Array
				streamContents:
					[ :stream | individualDirectory animatNamesDo: [ :name | stream nextPut: name ] ])
				asSet
		equals: (Set with: 'Goat' with: 'Wolf')
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testAnimatsOfDo [
	| animat individuals |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	blood_sugar [kcal]
	speed [km/h].'.
	individuals := Array
		streamContents: [ :stream | 
			10
				timesRepeat: [ stream nextPut: (individualDirectory allocateAnimat: animat) ] ].
	self
		assert: individuals
		equals:
			(individuals first to: individuals first + (animat totalNumberOfProperties * 9)
			by: animat totalNumberOfProperties) asArray
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testCell [
	| cell individual |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	individual := individualDirectory allocateCells: cell x: 2 y: 3.
	self assert: individualDirectory cell equals: individual
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testCellAtXIndexYIndex [
	| cell |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	individualDirectory allocateCells: cell x: 2 y: 3.
	self
		assert:
			(Array
				streamContents: [ :stream | 
					1 to: 2 do: [ :x | 
						1 to: 3 do:
							[ :y | stream nextPut: (individualDirectory cellAtXIndex: x yIndex: y) ] ] ])
				asSortedCollection asArray
		equals:
			(individualDirectory cell to: individualDirectory cell + (cell totalNumberOfProperties * 5)
			by: cell totalNumberOfProperties) asArray
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testCellSize [
	| cell |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	individualDirectory allocateCells: cell x: 2 y: 3.
	self
		assert: individualDirectory cellSize
		equals: cell totalNumberOfProperties
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testCellsDo [
	| cell |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	individualDirectory allocateCells: cell x: 2 y: 3.
	self
		assert:
			(Array
				streamContents: [ :stream | 
					individualDirectory
						cellsDo: [ :individual | stream nextPut: individual ] ])
		equals:
			(individualDirectory cell to: individualDirectory cell + (cell totalNumberOfProperties * 5)
			by: cell totalNumberOfProperties) asArray
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testEastOfDo [
	individualDirectory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	individualDirectory
		eastOf: (individualDirectory cellAtXIndex: 2 yIndex: 2)
		do: [ :cell | self fail ].
	self
		should: [ individualDirectory
				eastOf: (individualDirectory cellAtXIndex: 1 yIndex: 2)
				do: [ :cell | 
					self
						assert: cell
						equals: (individualDirectory cellAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testNorthOfDo [
	individualDirectory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	individualDirectory
		northOf: (individualDirectory cellAtXIndex: 2 yIndex: 3)
		do: [ :cell | self fail ].
	self
		should: [ individualDirectory
				northOf: (individualDirectory cellAtXIndex: 2 yIndex: 2)
				do: [ :cell | 
					self
						assert: cell
						equals: (individualDirectory cellAtXIndex: 2 yIndex: 3).
					Error signal ] ]
		raise: Error.
	self
		should: [ individualDirectory
				northOf: (individualDirectory cellAtXIndex: 2 yIndex: 1)
				do: [ :cell | 
					self
						assert: cell
						equals: (individualDirectory cellAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testRemoveAnimatIfAbsent [
	| animat goat1 goat2 |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	blood_sugar [kcal]
	speed [km/h].'.
	goat1 := individualDirectory allocateAnimat: animat.
	goat2 := individualDirectory allocateAnimat: animat.
	individualDirectory
		remove: goat1
		animat: animat
		ifAbsent: [ self fail ].
	self
		assert:
			(Array
				streamContents: [ :stream | 
					individualDirectory
						animatsOf: 'Goat'
						do: [ :goat | stream nextPut: goat ] ]) asSet
		equals: (Set with: goat2)
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testSouthOfDo [
	individualDirectory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	individualDirectory
		southOf: (individualDirectory cellAtXIndex: 2 yIndex: 1)
		do: [ :cell | self fail ].
	self
		should: [ individualDirectory
				southOf: (individualDirectory cellAtXIndex: 2 yIndex: 2)
				do: [ :cell | 
					self
						assert: cell
						equals: (individualDirectory cellAtXIndex: 2 yIndex: 1).
					Error signal ] ]
		raise: Error.
	self
		should: [ individualDirectory
				southOf: (individualDirectory cellAtXIndex: 2 yIndex: 3)
				do: [ :cell | 
					self
						assert: cell
						equals: (individualDirectory cellAtXIndex: 2 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testWestOfDo [
	individualDirectory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	individualDirectory
		westOf: (individualDirectory cellAtXIndex: 1 yIndex: 2)
		do: [ :cell | self fail ].
	self
		should: [ individualDirectory
				westOf: (individualDirectory cellAtXIndex: 2 yIndex: 2)
				do: [ :cell | 
					self
						assert: cell
						equals: (individualDirectory cellAtXIndex: 1 yIndex: 2).
					Error signal ] ]
		raise: Error
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testWorld [
	| world individual |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [C]
	humidity [].'.
	individual := individualDirectory allocateWorld: world.
	self assert: individualDirectory world equals: individual
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testWorldDo [
	| world individual |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [C]
	humidity [].'.
	individual := individualDirectory allocateWorld: world.
	self
		assert:
			(Array
				streamContents: [ :stream | individualDirectory worldDo: [ :w | stream nextPut: w ] ])
		equals: {individual}
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testXCellOf [
	individualDirectory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	self
		assert:
			(individualDirectory
				xCellOf: (individualDirectory cellAtXIndex: 1 yIndex: 1))
		equals: 1.
	self
		assert:
			(individualDirectory
				xCellOf: (individualDirectory cellAtXIndex: 2 yIndex: 1))
		equals: 2.
	self
		assert:
			(individualDirectory
				xCellOf: (individualDirectory cellAtXIndex: 1 yIndex: 2))
		equals: 1.
	self
		assert:
			(individualDirectory
				xCellOf: (individualDirectory cellAtXIndex: 2 yIndex: 2))
		equals: 2
]

{ #category : #tests }
RMDIndividualDirectoryTest >> testYCellOf [
	individualDirectory
		allocateCells:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].')
		x: 2
		y: 3.
	self
		assert:
			(individualDirectory
				yCellOf: (individualDirectory cellAtXIndex: 1 yIndex: 1))
		equals: 1.
	self
		assert:
			(individualDirectory
				yCellOf: (individualDirectory cellAtXIndex: 2 yIndex: 1))
		equals: 1.
	self
		assert:
			(individualDirectory
				yCellOf: (individualDirectory cellAtXIndex: 1 yIndex: 2))
		equals: 2.
	self
		assert:
			(individualDirectory
				yCellOf: (individualDirectory cellAtXIndex: 2 yIndex: 2))
		equals: 2
]
