Class {
	#name : #RMDDifferential2VariableNode,
	#superclass : #RMDPropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDifferential2VariableNode >> isDifferential2VariableNode [
	^ true
]

{ #category : #accessing }
RMDDifferential2VariableNode >> operator [
	^ 'd^2/dt^2 '
]
