Class {
	#name : #RMDAssignableDeltaAttributeVariableNode,
	#superclass : #RMDAbstractAssignableAttributeVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDAssignableDeltaAttributeVariableNode >> isAssignableDeltaVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignableDeltaAttributeVariableNode >> operator [
	^ 'Δ'
]
