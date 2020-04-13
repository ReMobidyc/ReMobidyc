Class {
	#name : #RMDIndividualDirectory,
	#superclass : #Object,
	#instVars : [
		'nextAvailableSlot',
		'world',
		'cell',
		'xCells',
		'yCells',
		'animats',
		'cellSize'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #allocating }
RMDIndividualDirectory >> allocateAnimat: aRMDAnimatDefinitionNode [
	| individual |
	nextAvailableSlot := (individual := nextAvailableSlot)
		+ aRMDAnimatDefinitionNode totalNumberOfProperties.
	(animats
		at: aRMDAnimatDefinitionNode identifier
		ifAbsentPut: [ Set new: 1024 ]) add: individual.
	^ individual
]

{ #category : #allocating }
RMDIndividualDirectory >> allocateCells: aRMDCellDefinitionNode x: anInteger1 y: anInteger2 [
	nextAvailableSlot := (cellSize := aRMDCellDefinitionNode
		totalNumberOfProperties) * (xCells := anInteger1)
		* (yCells := anInteger2) + (cell := nextAvailableSlot).
	^ cell
]

{ #category : #allocating }
RMDIndividualDirectory >> allocateWorld: aRMDWorldDefinitionNode [
	nextAvailableSlot := aRMDWorldDefinitionNode totalNumberOfProperties
		+ (world := nextAvailableSlot).
	^ world
]

{ #category : #enumerating }
RMDIndividualDirectory >> animatsOf: aString do: aBlock [
	(animats at: aString ifAbsent: [ ^ self ])
		do: [ :id | aBlock value: id ]
]

{ #category : #accessing }
RMDIndividualDirectory >> cell [
	^ cell
]

{ #category : #accessing }
RMDIndividualDirectory >> cell: anInteger [
	cell := anInteger
]

{ #category : #accessing }
RMDIndividualDirectory >> cellSize [
	^ cellSize
]

{ #category : #accessing }
RMDIndividualDirectory >> cellSize: anInteger [
	cellSize := anInteger
]

{ #category : #enumerating }
RMDIndividualDirectory >> cellsDo: aBlock [
	cell to: cellSize * xCells * yCells by: cellSize do: aBlock
]

{ #category : #initialization }
RMDIndividualDirectory >> initialize [
	super initialize.
	nextAvailableSlot := 1.
	xCells := 0.
	yCells := 0.
	cellSize := 0.
	world := 1.
	cell := nil.
	animats := Dictionary new
]

{ #category : #enumerating }
RMDIndividualDirectory >> speciesDo: aBlock [
	animats keysDo: aBlock
]

{ #category : #accessing }
RMDIndividualDirectory >> world [
	^ world
]

{ #category : #accessing }
RMDIndividualDirectory >> world: anInteger [
	world := anInteger
]

{ #category : #enumerating }
RMDIndividualDirectory >> worldDo: aBlock [
	aBlock value: world
]

{ #category : #accessing }
RMDIndividualDirectory >> xCells: anInteger [
	xCells := anInteger
]

{ #category : #accessing }
RMDIndividualDirectory >> yCells: anInteger [
	yCells := anInteger
]
