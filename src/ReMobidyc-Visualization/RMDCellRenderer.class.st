Class {
	#name : #RMDCellRenderer,
	#superclass : #RMDRenderer,
	#instVars : [
		'min',
		'max',
		'expression'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDCellRenderer class >> expression: aRMDExpressionNode min: aNumber max: anotherNumber [
	^ self new
		expression: aRMDExpressionNode;
		min: aNumber;
		max: anotherNumber;
		yourself
]

{ #category : #drawing }
RMDCellRenderer >> draw: aRMDInterpreter on: aFormCanvas [
	| xDivisions yDivisions cellLength |
	xDivisions := aRMDInterpreter cellXDivisions.
	yDivisions := aRMDInterpreter cellYDivisions.
	cellLength := aRMDInterpreter cellLength.
	1 to: yDivisions do: [ :cellY | 
		1 to: xDivisions do: [ :cellX | 
			self
				drawValue:
					(self
						valueForIndividual: (aRMDInterpreter cellAtXIndex: cellX yIndex: cellY)
						interpreter: aRMDInterpreter)
				bounds:
					((self
						pointFromX: (cellX - 1) * cellLength
						y: (cellY - 1) * cellLength
						interpreter: aRMDInterpreter
						on: aFormCanvas)
						corner:
							(self
								pointFromX: cellX * cellLength
								y: cellY * cellLength
								interpreter: aRMDInterpreter
								on: aFormCanvas))
				on: aFormCanvas ] ]
]

{ #category : #drawing }
RMDCellRenderer >> drawValue: aNumber bounds: aRectangle on: aFormCanvas [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDCellRenderer >> expression [
	^ expression
]

{ #category : #accessing }
RMDCellRenderer >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #initialization }
RMDCellRenderer >> initialize [
	super initialize.
	min := 0.0.
	max := 1.0.
	expression := '0 []' asRMDExpression
]

{ #category : #accessing }
RMDCellRenderer >> max [
	^ max
]

{ #category : #accessing }
RMDCellRenderer >> max: aRMDLiteral [
	max := aRMDLiteral
]

{ #category : #accessing }
RMDCellRenderer >> min [
	^ min
]

{ #category : #accessing }
RMDCellRenderer >> min: aRMDLiteral [
	min := aRMDLiteral
]

{ #category : #accessing }
RMDCellRenderer >> valueForIndividual: anInteger interpreter: aRMDInterpreter [
	| cellDef value |
	cellDef := aRMDInterpreter cellDefinition.
	aRMDInterpreter
		setObserverContextWithSubject: anInteger
		species: cellDef.
	value := expression evalIn: aRMDInterpreter.
	^ (value - min) / (max - min) min: 1.0 max: 0.0
]
