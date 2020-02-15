Class {
	#name : #RMDSimulationPropertyDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSimulationPropertyDefinitionNode class >> identifier: aString expression: aRMDExpressionNode [
	^ self new
		identifier: aString;
		expression: aRMDExpressionNode;
		yourself
]

{ #category : #enumerating }
RMDSimulationPropertyDefinitionNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #accessing }
RMDSimulationPropertyDefinitionNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDSimulationPropertyDefinitionNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #accessing }
RMDSimulationPropertyDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDSimulationPropertyDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #printing }
RMDSimulationPropertyDefinitionNode >> isSimulationPropertyDefinitionNode [
	^ true
]

{ #category : #printing }
RMDSimulationPropertyDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' = '.
	expression printOn: aStream
]
