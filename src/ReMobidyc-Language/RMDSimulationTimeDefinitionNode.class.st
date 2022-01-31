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

{ #category : #'instance creation' }
RMDSimulationTimeDefinitionNode class >> during: aString by: anotherString [
	<script:
		'(RMDSimulationTimeDefinitionNode during: ''100 [day]'' by: ''0.5 [day]'') inspect'>
	^ self
		duration: aString asRMDExpression
		step: anotherString asRMDExpression
]

{ #category : #'instance creation' }
RMDSimulationTimeDefinitionNode class >> empty [
	^ self
		duration: '1 [day]' asRMDExpression
		step: '1 [day]' asRMDExpression
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

{ #category : #printing }
RMDSimulationTimeDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'during '.
	duration
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' step by '.
	step
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
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
