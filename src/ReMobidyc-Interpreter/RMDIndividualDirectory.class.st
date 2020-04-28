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
RMDIndividualDirectory >> animatNamesDo: aBlock [
	animats keysDo: aBlock
]

{ #category : #enumerating }
RMDIndividualDirectory >> animatsOf: aString do: aBlock [
	(animats at: aString ifAbsent: [ ^ self ]) asArray
		do: [ :id | aBlock value: id ]
]

{ #category : #accessing }
RMDIndividualDirectory >> cell [
	^ cell
]

{ #category : #accessing }
RMDIndividualDirectory >> cellAtXIndex: anInteger yIndex: anotherInteger [
	^ ((anotherInteger - 1) * xCells + anInteger - 1) * cellSize + cell
]

{ #category : #accessing }
RMDIndividualDirectory >> cellSize [
	^ cellSize
]

{ #category : #enumerating }
RMDIndividualDirectory >> cellsDo: aBlock [
	cellSize > 0
		ifTrue:
			[ cell to: cellSize * xCells * yCells + cell - 1 by: cellSize do: aBlock ]
]

{ #category : #accessing }
RMDIndividualDirectory >> eastOf: anInteger do: aBlock [
	(self xCellOf: anInteger) < xCells
		ifTrue: [ aBlock value: anInteger + cellSize ]
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

{ #category : #accessing }
RMDIndividualDirectory >> northOf: anInteger do: aBlock [
	(self yCellOf: anInteger) < yCells
		ifTrue: [ aBlock value: anInteger + (cellSize * xCells) ]
]

{ #category : #allocating }
RMDIndividualDirectory >> remove: anInteger animat: aRMDAnimatDefinitionNode ifAbsent: errorBlock [
	^ (animats
		at: aRMDAnimatDefinitionNode identifier
		ifAbsent: [ ^ errorBlock value ])
		remove: anInteger
		ifAbsent: errorBlock
]

{ #category : #accessing }
RMDIndividualDirectory >> southOf: anInteger do: aBlock [
	(self yCellOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - (cellSize * xCells) ]
]

{ #category : #accessing }
RMDIndividualDirectory >> westOf: anInteger do: aBlock [
	(self xCellOf: anInteger) > 1
		ifTrue: [ aBlock value: anInteger - cellSize ]
]

{ #category : #accessing }
RMDIndividualDirectory >> world [
	^ world
]

{ #category : #enumerating }
RMDIndividualDirectory >> worldDo: aBlock [
	aBlock value: world
]

{ #category : #accessing }
RMDIndividualDirectory >> xCellOf: anInteger [
	^ (anInteger - cell) // cellSize \\ xCells + 1
]

{ #category : #accessing }
RMDIndividualDirectory >> yCellOf: anInteger [
	^ (anInteger - cell) // cellSize // xCells + 1
]
