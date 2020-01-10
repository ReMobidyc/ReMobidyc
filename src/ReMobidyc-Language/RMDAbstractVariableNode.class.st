Class {
	#name : #RMDAbstractVariableNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAbstractVariableNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

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

{ #category : #accessing }
RMDAbstractVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDAbstractVariableNode >> printOn: aStream [
	aStream nextPutAll: self operator.
	aStream nextPutAll: identifier
]
