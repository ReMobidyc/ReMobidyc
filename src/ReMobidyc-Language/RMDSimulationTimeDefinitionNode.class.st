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
RMDSimulationTimeDefinitionNode class >> default [
	^ self
		duration: '0 [s]' asRMDExpression
		step: '1 [h]' asRMDExpression
]

{ #category : #'instance creation' }
RMDSimulationTimeDefinitionNode class >> duration: aRMDExpression step: anotherRMDExpression [
	^ self new
		duration: aRMDExpression;
		step: anotherRMDExpression;
		yourself
]

{ #category : #comparing }
RMDSimulationTimeDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ duration = anObject duration and: [ step = anObject step ] ]
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

{ #category : #comparing }
RMDSimulationTimeDefinitionNode >> hash [
	^ duration hash bitXor: step hash
]

{ #category : #testing }
RMDSimulationTimeDefinitionNode >> isSimulationTimeDefinitionNode [
	^ true
]

{ #category : #copying }
RMDSimulationTimeDefinitionNode >> postCopy [
	duration := duration copy.
	step := step copy
]

{ #category : #printing }
RMDSimulationTimeDefinitionNode >> printOn: aStream [
	aStream nextPutAll: 'during '.
	duration printOn: aStream.
	aStream nextPutAll: ' step by '.
	step printOn: aStream
]

{ #category : #rewriting }
RMDSimulationTimeDefinitionNode >> replaceChildren: aDictionary [
	duration := duration copyReplace: aDictionary.
	step := step copyReplace: aDictionary
]

{ #category : #accessing }
RMDSimulationTimeDefinitionNode >> step [
	^ step
]

{ #category : #accessing }
RMDSimulationTimeDefinitionNode >> step: aRMDExpressionNode [
	step := aRMDExpressionNode
]
