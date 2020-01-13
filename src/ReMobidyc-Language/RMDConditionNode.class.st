Class {
	#name : #RMDConditionNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDConditionNode >> evalIn: aRMDInterpreter [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDConditionNode >> precedence [
	^ self subclassResponsibility
]
