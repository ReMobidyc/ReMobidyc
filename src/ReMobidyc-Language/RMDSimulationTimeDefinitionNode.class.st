Class {
	#name : #RMDSimulationTimeDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'duration',
		'step'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSimulationTimeDefinitionNode class >> duration: aRMDExpression step: anotherRMDExpression [
	^ self new
		duration: aRMDExpression;
		step: anotherRMDExpression;
		yourself
]

{ #category : #enumerating }
RMDSimulationTimeDefinitionNode >> childrenDo: aBlock [
	aBlock
		value: duration;
		value: step
]

{ #category : #accessing }
RMDSimulationTimeDefinitionNode >> duration [
	^ duration
]

{ #category : #accessing }
RMDSimulationTimeDefinitionNode >> duration: aRMDExpressionNode [
	duration := aRMDExpressionNode
]

{ #category : #testing }
RMDSimulationTimeDefinitionNode >> isSimulationTimeDefinitionNode [
	^ true
]

{ #category : #printing }
RMDSimulationTimeDefinitionNode >> printOn: aStream [
	aStream nextPutAll: 'during '.
	duration printOn: aStream.
	aStream nextPutAll: ' step by '.
	step printOn: aStream
]

{ #category : #accessing }
RMDSimulationTimeDefinitionNode >> step [
	^ step
]

{ #category : #accessing }
RMDSimulationTimeDefinitionNode >> step: aRMDExpressionNode [
	step := aRMDExpressionNode
]
