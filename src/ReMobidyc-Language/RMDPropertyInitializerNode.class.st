Class {
	#name : #RMDPropertyInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyInitializerNode class >> identifier: aString expression: aRMDExpressionNode [
	^ self new
		identifier: aString;
		expression: aRMDExpressionNode;
		yourself
]

{ #category : #enumerating }
RMDPropertyInitializerNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #accessing }
RMDPropertyInitializerNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDPropertyInitializerNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #accessing }
RMDPropertyInitializerNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDPropertyInitializerNode >> identifier: aString [
	identifier := aString
]

{ #category : #printing }
RMDPropertyInitializerNode >> isPropertyInitializerNode [
	^ true
]

{ #category : #printing }
RMDPropertyInitializerNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' = '.
	expression printOn: aStream
]
