Class {
	#name : #RMDAssignableDifferentialPropertyVariableNode,
	#superclass : #RMDAbstractAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDAssignableDifferentialPropertyVariableNode >> isAssignableDifferentialPropertyVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignableDifferentialPropertyVariableNode >> operator [
	^ 'd/dt '
]
