Class {
	#name : #RMDAssignableDeltaPropertyVariableNode,
	#superclass : #RMDAbstractAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDAssignableDeltaPropertyVariableNode >> isAssignableDeltaVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignableDeltaPropertyVariableNode >> operator [
	^ 'Δ'
]
