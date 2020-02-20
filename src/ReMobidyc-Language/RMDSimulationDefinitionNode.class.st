Class {
	#name : #RMDSimulationDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'timeInitializer',
		'worldInitializer',
		'cellInitializer',
		'animatInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSimulationDefinitionNode class >> default [
	^ self
		timeDefinition: RMDSimulationTimeDefinitionNode default
		worldInitializer: RMDWorldInitializerNode default
		cellInitializer: RMDCellInitializerNode default
		animatInitializers: Array new
]

{ #category : #'instance creation' }
RMDSimulationDefinitionNode class >> timeDefinition: aRMDSimulationTimeDefinitionNode worldInitializer: aRMDWorldInitializerNode cellInitializer: aRMDCellInitializerNode animatInitializers: anArrayOfRMDAnimatInitializerNode [
	^ self new
		timeDefinition: aRMDSimulationTimeDefinitionNode;
		worldInitializer: aRMDWorldInitializerNode;
		cellInitializer: aRMDCellInitializerNode;
		animatInitializers: anArrayOfRMDAnimatInitializerNode;
		yourself
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> addAnimatInitializer: aRMDAnimatInitializerNode [
	animatInitializers := animatInitializers
		copyWith: aRMDAnimatInitializerNode
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> animatInitializers [
	^ animatInitializers
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> animatInitializers: anArrayOfRMDSimulationAnimatInitializer [
	animatInitializers := anArrayOfRMDSimulationAnimatInitializer
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> cellInitializer [
	^ cellInitializer
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> cellInitializer: aRMDSimulationCellInitializer [
	cellInitializer := aRMDSimulationCellInitializer
]

{ #category : #enumerating }
RMDSimulationDefinitionNode >> childrenDo: aBlock [
	aBlock
		value: cellInitializer;
		value: timeInitializer.
	animatInitializers ifNotNil: [ animatInitializers do: aBlock ]
]

{ #category : #testing }
RMDSimulationDefinitionNode >> isSimulationDefinitionNode [
	^ true
]

{ #category : #printing }
RMDSimulationDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: 'Simulation with';
		nextPut: Character cr.
	cellInitializer printOn: aStream.
	aStream nextPut: Character cr.
	timeInitializer printOn: aStream.
	aStream nextPut: Character cr.
	animatInitializers
		do: [ :def | def printOn: aStream ]
		separatedBy: [ aStream
				nextPut: $,;
				nextPut: Character cr ].
	aStream nextPut: $.
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> timeDefinition [
	^ timeInitializer
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> timeDefinition: aRMDSimulationTimeDefinitionNode [
	timeInitializer := aRMDSimulationTimeDefinitionNode
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> worldInitializer [
	^ worldInitializer
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> worldInitializer: aRMDWorldInitializerNode [
	worldInitializer := aRMDWorldInitializerNode
]
