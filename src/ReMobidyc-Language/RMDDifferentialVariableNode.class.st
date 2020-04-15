Class {
	#name : #RMDDifferentialVariableNode,
	#superclass : #RMDAssignablePropertyVariableNode,
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
