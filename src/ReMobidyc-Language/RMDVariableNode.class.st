Class {
	#name : #RMDVariableNode,
	#superclass : #RMDAbstractVariableNode,
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

{ #category : #accessing }
RMDVariableNode >> precedence [
	^ 0
]
