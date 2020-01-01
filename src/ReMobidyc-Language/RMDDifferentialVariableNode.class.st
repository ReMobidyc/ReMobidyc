Class {
	#name : #RMDDifferentialVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDifferentialVariableNode >> isDifferentialNode [
	^ true
]

{ #category : #printing }
RMDDifferentialVariableNode >> operator [
	^ 'd/dt '
]

{ #category : #accessing }
RMDDifferentialVariableNode >> precedence [
	^ 1
]
