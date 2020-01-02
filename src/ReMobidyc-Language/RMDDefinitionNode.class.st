Class {
	#name : #RMDDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'variable',
		'type',
		'definitionBody'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDDefinitionNode class >> variable: aRMDVariableNode type: aRMDTypeNodeOrNil expression: aRMDExpressionNode [
	^ self new
		variable: aRMDVariableNode;
		type: aRMDTypeNodeOrNil;
		definitionBody: aRMDExpressionNode;
		yourself
]

{ #category : #accessing }
RMDDefinitionNode >> definitionBody [
	^ definitionBody
]

{ #category : #accessing }
RMDDefinitionNode >> definitionBody: aRMDExpressionNode [
	definitionBody := aRMDExpressionNode
]

{ #category : #accessing }
RMDDefinitionNode >> operator [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: $';
		nextPut: Character space.
	type
		ifNotNil: [ aStream nextPut: Character space.
			type printOn: aStream ].
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]

{ #category : #accessing }
RMDDefinitionNode >> type [
	^ type
]

{ #category : #accessing }
RMDDefinitionNode >> type: aRMDTypeNodeOrNil [
	type := aRMDTypeNodeOrNil
]

{ #category : #accessing }
RMDDefinitionNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDDefinitionNode >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
