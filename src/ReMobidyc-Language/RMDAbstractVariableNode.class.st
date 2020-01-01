Class {
	#name : #RMDAbstractVariableNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'symbol'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAbstractVariableNode class >> symbol: aString [
	^ self new
		symbol: aString;
		yourself
]

{ #category : #comparing }
RMDAbstractVariableNode >> = anObject [
	^ self class = anObject class and: [ symbol = anObject symbol ]
]

{ #category : #comparing }
RMDAbstractVariableNode >> hash [
	^ self class hash bitXor: symbol hash
]

{ #category : #accessing }
RMDAbstractVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDAbstractVariableNode >> printOn: aStream [
	aStream nextPutAll: self operator.
	aStream nextPutAll: symbol
]

{ #category : #accessing }
RMDAbstractVariableNode >> symbol [
	^ symbol
]

{ #category : #accessing }
RMDAbstractVariableNode >> symbol: aString [
	symbol := aString
]
