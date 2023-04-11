Class {
	#name : #RMDPatchExpressionRenderer,
	#superclass : #RMDPatchRenderer,
	#instVars : [
		'expression'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDPatchExpressionRenderer class >> expression: aRMDExpressionNode min: aNumber max: anotherNumber [
	^ self new
		expression: aRMDExpressionNode;
		min: aNumber;
		max: anotherNumber;
		yourself
]

{ #category : #testing }
RMDPatchExpressionRenderer class >> isAbstract [

	^ self == RMDPatchExpressionRenderer
]

{ #category : #comparing }
RMDPatchExpressionRenderer >> = anObject [

	^ super = anObject and: [ expression = anObject expression ]
]

{ #category : #drawing }
RMDPatchExpressionRenderer >> drawPatch: anInteger interpreter: aRMDInterpreter bounds: aRectangle on: aCanvas [
	self
		drawValue:
			(self valueForIndividual: anInteger interpreter: aRMDInterpreter)
		bounds: aRectangle
		on: aCanvas
]

{ #category : #drawing }
RMDPatchExpressionRenderer >> drawValue: aNumber bounds: aRectangle on: aFormCanvas [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDPatchExpressionRenderer >> expression [
	^ expression
]

{ #category : #accessing }
RMDPatchExpressionRenderer >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDPatchExpressionRenderer >> hash [

	^ super hash bitXor: expression hash
]

{ #category : #initialization }
RMDPatchExpressionRenderer >> initialize [
	super initialize.
	expression := '0 []' asRMDExpression
]

{ #category : #accessing }
RMDPatchExpressionRenderer >> valueForIndividual: anInteger interpreter: aRMDInterpreter [

	| patchDef |
	patchDef := aRMDInterpreter simulationModel patchDefinition.
	aRMDInterpreter
		withObserverContextWithSubject: anInteger
		definition: patchDef
		do: [ ^ expression evalIn: aRMDInterpreter ]
]
