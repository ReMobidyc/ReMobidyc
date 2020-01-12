Class {
	#name : #RMDAssignablePropertyVariableNode,
	#superclass : #RMDPropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDAssignablePropertyVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ self subclassResponsibility
]
