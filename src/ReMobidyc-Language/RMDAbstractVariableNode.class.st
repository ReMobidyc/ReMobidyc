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

{ #category : #copying }
RMDAbstractVariableNode >> postCopy [
	
]

{ #category : #rewriting }
RMDAbstractVariableNode >> replaceChildren: aDictionary [
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]
