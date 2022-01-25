Class {
	#name : #RMDCellExpressionRenderer,
	#superclass : #RMDCellRenderer,
	#instVars : [
		'expression'
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

{ #category : #comparing }
RMDCellExpressionRenderer >> = anObject [

	^ super = anObject and: [ expression = anObject expression ]
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

{ #category : #comparing }
RMDCellExpressionRenderer >> hash [

	^ super hash bitXor: expression hash
]

{ #category : #initialization }
RMDCellExpressionRenderer >> initialize [
	super initialize.
	expression := '0 []' asRMDExpression
]

{ #category : #accessing }
RMDCellExpressionRenderer >> valueForIndividual: anInteger interpreter: aRMDInterpreter [
	| cellDef |
	cellDef := aRMDInterpreter cellDefinition.
	aRMDInterpreter
		withObserverContextWithSubject: anInteger
		species: cellDef
		do: [ ^ expression evalIn: aRMDInterpreter ]
]
