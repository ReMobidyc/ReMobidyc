Class {
	#name : #RMDAssignableDifferentialAttributeVariableNode,
	#superclass : #RMDAbstractAssignableAttributeVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDAssignableDifferentialAttributeVariableNode >> isAssignableDifferentialAttributeVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignableDifferentialAttributeVariableNode >> operator [
	^ 'd/dt '
]
