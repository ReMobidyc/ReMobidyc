Class {
	#name : #RMDCellExpressionRenderer,
	#superclass : #RMDCellRenderer,
	#instVars : [
		'min',
		'expression',
		'max'
	],
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
RMDCellExpressionRenderer >> drawCell: anInteger interpreter: aRMDInterpreter bounds: aRectangle on: aCanvas [
	self
		drawValue:
			(self valueForIndividual: anInteger interpreter: aRMDInterpreter)
		bounds: aRectangle
		on: aCanvas
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
	^ (value - min numeric) / (max numeric - min numeric)
		min: 1.0
		max: 0.0
]
