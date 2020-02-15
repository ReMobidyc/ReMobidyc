Class {
	#name : #RMDSimulationDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'spaceDefinition',
		'timeDefinition',
		'animatDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSimulationDefinitionNode class >> spaceDefinition: aRMDSimulationSpaceDefinitionNode timeDefinition: aRMDSimulationTimeDefinitionNode animatDefinitions: anArrayOfRMDSimulationAnimatDefinitionNode [
	^ self new
		spaceDefinition: aRMDSimulationSpaceDefinitionNode;
		timeDefinition: aRMDSimulationTimeDefinitionNode;
		animatDefinitions: anArrayOfRMDSimulationAnimatDefinitionNode;
		yourself
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> animatDefinitions [
	^ animatDefinitions
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> animatDefinitions: anArrayOfRMDSimulationAnimatDefinition [
	animatDefinitions := anArrayOfRMDSimulationAnimatDefinition
]

{ #category : #enumerating }
RMDSimulationDefinitionNode >> childrenDo: aBlock [
	aBlock
		value: spaceDefinition;
		value: timeDefinition.
	animatDefinitions ifNotNil: [ animatDefinitions do: aBlock ]
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
	spaceDefinition printOn: aStream.
	aStream nextPut: Character cr.
	timeDefinition printOn: aStream.
	aStream nextPut: Character cr.
	animatDefinitions
		do: [ :def | def printOn: aStream ]
		separatedBy: [ aStream
				nextPut: $,;
				nextPut: Character cr ].
	aStream nextPut: $.
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> spaceDefinition [
	^ spaceDefinition
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> spaceDefinition: aRMDSimulationSpaceDefinition [
	spaceDefinition := aRMDSimulationSpaceDefinition
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> timeDefinition [
	^ timeDefinition
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> timeDefinition: aRMDSimulationTimeDefinition [
	timeDefinition := aRMDSimulationTimeDefinition
]
