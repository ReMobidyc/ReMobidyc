Class {
	#name : #RMDDifferentialVariableNode,
	#superclass : #RMDPropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDifferentialVariableNode >> isDifferentialVariableNode [
	^ true
]

{ #category : #accessing }
RMDDifferentialVariableNode >> operator [
	^ 'd/dt '
]
