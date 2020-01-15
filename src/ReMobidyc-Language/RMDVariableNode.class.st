Class {
	#name : #RMDVariableNode,
	#superclass : #RMDAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDVariableNode >> isVariableNode [
	^ true
]

{ #category : #accessing }
RMDVariableNode >> operator [
	^ ''
]
