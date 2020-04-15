Class {
	#name : #RMDAbstractVariableNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDAbstractVariableNode >> = anObject [
	^ self class = anObject class and: [ identifier = anObject identifier ]
]

{ #category : #comparing }
RMDAbstractVariableNode >> hash [
	^ self class hash bitXor: identifier hash
]

{ #category : #accessing }
RMDAbstractVariableNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAbstractVariableNode >> identifier: aString [
	identifier := aString
]
