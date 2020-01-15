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

{ #category : #accessing }
RMDPropertyDeclarationNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> expression: anRMDExpressionNode [
	expression := anRMDExpressionNode
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
	identifier printOn: aStream.
	aStream nextPutAll: ' = '.
	expression printOn: aStream
]
