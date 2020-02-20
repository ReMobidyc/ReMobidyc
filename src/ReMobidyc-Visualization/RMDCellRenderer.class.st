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

{ #category : #drawing }
RMDCellRenderer >> draw: aRMDInterpreter on: aFormCanvas [
	| xDivisions yDivisions formWidth formHeight cellWidth cellHeight cellExtent |
	xDivisions := aRMDInterpreter cellXDivisions.
	yDivisions := aRMDInterpreter cellYDivisions.
	formWidth := aFormCanvas form width.
	formHeight := aFormCanvas form height.
	cellWidth := formWidth / xDivisions.
	cellHeight := formHeight / yDivisions.
	cellExtent := cellWidth @ cellHeight.
	1 to: yDivisions do: [ :cellY | 
		1 to: xDivisions do: [ :cellX | 
			| x y |
			x := (cellX - 1) * cellWidth.
			y := (cellY - 1) * cellHeight.
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
	^ (value - min) / (max - min)
]
