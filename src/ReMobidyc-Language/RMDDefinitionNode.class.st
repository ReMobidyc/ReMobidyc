Class {
	#name : #RMDDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'variable',
		'definitionBody'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDDefinitionNode class >> variable: aRMDVariableNode expression: aRMDExpressionNode [
	^ self new
		variable: aRMDVariableNode;
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

{ #category : #evaluating }
RMDDefinitionNode >> evalIn: aRMDInterpreter [
	^ self subclassResponsibility
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
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]

{ #category : #accessing }
RMDDefinitionNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDDefinitionNode >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
