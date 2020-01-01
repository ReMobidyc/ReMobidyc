Class {
	#name : #RMDDeltaVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDeltaVariableNode >> isDeltaNode [
	^ true
]

{ #category : #accessing }
RMDDeltaVariableNode >> operator [
	^ 'Δ'
]

{ #category : #accessing }
RMDDeltaVariableNode >> precedence [
	^ 1
]
