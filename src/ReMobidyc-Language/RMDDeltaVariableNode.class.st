Class {
	#name : #RMDDeltaVariableNode,
	#superclass : #RMDAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDeltaVariableNode >> isDeltaVariableNode [
	^ true
]

{ #category : #accessing }
RMDDeltaVariableNode >> operator [
	^ 'Δ'
]
