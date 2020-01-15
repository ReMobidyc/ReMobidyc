Class {
	#name : #RMDVariableDeclarationNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'variable',
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDVariableDeclarationNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDVariableDeclarationNode >> expression: anRMDExpressionNode [
	expression := anRMDExpressionNode
]

{ #category : #printing }
RMDVariableDeclarationNode >> printOn: aStream [
	variable printOn: aStream.
	aStream nextPutAll: ' = '.
	expression printOn: aStream
]

{ #category : #accessing }
RMDVariableDeclarationNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDVariableDeclarationNode >> variable: anRMDAssignablePropertyVariableNode [
	variable := anRMDAssignablePropertyVariableNode
]
