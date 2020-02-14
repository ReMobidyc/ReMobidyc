Class {
	#name : #RMDPropertyDeclarationNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'expression',
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyDeclarationNode class >> identifier: aString expression: aRMDExpression [
	^ self new
		identifier: aString;
		expression: aRMDExpression;
		yourself
]

{ #category : #comparing }
RMDPropertyDeclarationNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier
				and: [ expression = anObject expression ] ]
]

{ #category : #enumerating }
RMDPropertyDeclarationNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> expression: anRMDExpressionNode [
	expression := anRMDExpressionNode
]

{ #category : #comparing }
RMDPropertyDeclarationNode >> hash [
	^ (self class hash bitXor: identifier hash) bitXor: expression hash
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDPropertyDeclarationNode >> isPropertyDeclarationNode [
	^ true
]

{ #category : #printing }
RMDPropertyDeclarationNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' = '.
	expression printOn: aStream
]
