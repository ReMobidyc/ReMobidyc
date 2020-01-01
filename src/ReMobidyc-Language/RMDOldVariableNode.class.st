Class {
	#name : #RMDOldVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDOldVariableNode >> isOldNode [
	^ true
]

{ #category : #printing }
RMDOldVariableNode >> operator [
	^ 'old '
]

{ #category : #accessing }
RMDOldVariableNode >> precedence [
	^ 1
]
