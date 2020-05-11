Class {
	#name : #RMDCellExpressionRenderer,
	#superclass : #RMDCellRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDCellExpressionRenderer class >> expression: aRMDExpressionNode min: aNumber max: anotherNumber [
	^ self new
		expression: aRMDExpressionNode;
		min: aNumber;
		max: anotherNumber;
		yourself
]

{ #category : #drawing }
RMDCellExpressionRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
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
						scale: aNumber)
						corner:
							(self
								pointFromX: cellX * cellLength
								y: cellY * cellLength
								interpreter: aRMDInterpreter
								scale: aNumber))
				on: aCanvas ] ]
]

{ #category : #drawing }
RMDCellExpressionRenderer >> drawValue: aNumber bounds: aRectangle on: aFormCanvas [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDCellExpressionRenderer >> expression [
	^ expression
]

{ #category : #accessing }
RMDCellExpressionRenderer >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #initialization }
RMDCellExpressionRenderer >> initialize [
	super initialize.
	min := 0.0.
	max := 1.0.
	expression := '0 []' asRMDExpression
]

{ #category : #accessing }
RMDCellExpressionRenderer >> max [
	^ max
]

{ #category : #accessing }
RMDCellExpressionRenderer >> max: aRMDLiteral [
	max := aRMDLiteral
]

{ #category : #accessing }
RMDCellExpressionRenderer >> min [
	^ min
]

{ #category : #accessing }
RMDCellExpressionRenderer >> min: aRMDLiteral [
	min := aRMDLiteral
]

{ #category : #accessing }
RMDCellExpressionRenderer >> valueForIndividual: anInteger interpreter: aRMDInterpreter [
	| cellDef value |
	cellDef := aRMDInterpreter cellDefinition.
	aRMDInterpreter
		setObserverContextWithSubject: anInteger
		species: cellDef.
	value := expression evalIn: aRMDInterpreter.
	^ (value - min) / (max - min) min: 1.0 max: 0.0
]
