Class {
	#name : #RMDDifferential2VariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDifferential2VariableNode >> isDifferential2Node [
	^ true
]

{ #category : #accessing }
RMDDifferential2VariableNode >> operator [
	^ 'd^2/dt^2 '
]

{ #category : #accessing }
RMDDifferential2VariableNode >> precedence [
	^ 1
]
