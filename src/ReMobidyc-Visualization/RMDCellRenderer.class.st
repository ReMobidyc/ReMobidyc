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
	| xDivisions yDivisions formWidth formHeight cellWidth cellExtent offsetX offsetY |
	xDivisions := aRMDInterpreter cellXDivisions.
	yDivisions := aRMDInterpreter cellYDivisions.
	formWidth := aFormCanvas form width.
	formHeight := aFormCanvas form height.
	cellWidth := formWidth asFloat / xDivisions asFloat min: formHeight asFloat / yDivisions asFloat.
	cellExtent := cellWidth @ cellWidth.
	offsetX := (formWidth - (cellWidth * xDivisions)) // 2.
	offsetY := (formHeight - (cellWidth * yDivisions)) // 2.
	1 to: yDivisions do: [ :cellY | 
		1 to: xDivisions do: [ :cellX | 
			| x y |
			x := (cellX - 1) * cellWidth + offsetX.
			y := (cellY - 1) * cellWidth + offsetY.
			self
				drawValue:
					(self
						valueForIndividual: (aRMDInterpreter cellAtXIndex: cellX yIndex: cellY)
						interpreter: aRMDInterpreter)
				bounds: (x @ y extent: cellExtent)
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
