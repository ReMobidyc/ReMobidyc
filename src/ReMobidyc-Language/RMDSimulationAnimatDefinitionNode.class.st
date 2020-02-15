Class {
	#name : #RMDSimulationAnimatDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'population',
		'animat',
		'propertyDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSimulationAnimatDefinitionNode class >> population: anInteger animat: aString propertyDefinitions: anArrayOfRMDSimulationPropertyDefinitionNode [
	^ self new
		population: anInteger;
		animat: aString;
		propertyDefinitions: anArrayOfRMDSimulationPropertyDefinitionNode;
		yourself
]

{ #category : #accessing }
RMDSimulationAnimatDefinitionNode >> animat [
	^ animat
]

{ #category : #accessing }
RMDSimulationAnimatDefinitionNode >> animat: aString [
	animat := aString
]

{ #category : #enumerating }
RMDSimulationAnimatDefinitionNode >> childrenDo: aBlock [
	propertyDefinitions do: aBlock
]

{ #category : #testing }
RMDSimulationAnimatDefinitionNode >> isSimulationAnimatDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDSimulationAnimatDefinitionNode >> population [
	^ population
]

{ #category : #accessing }
RMDSimulationAnimatDefinitionNode >> population: anInteger [
	population := anInteger
]

{ #category : #printing }
RMDSimulationAnimatDefinitionNode >> printOn: aStream [
	population printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: animat.
	propertyDefinitions
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyDefinitions
				do: [ :def | 
					def printOn: aStream.
					aStream nextPut: Character cr ] ]
]

{ #category : #accessing }
RMDSimulationAnimatDefinitionNode >> propertyDefinitions [
	^ propertyDefinitions
]

{ #category : #accessing }
RMDSimulationAnimatDefinitionNode >> propertyDefinitions: anArrayOfRMDSimulationPropertyDefinitionNode [
	propertyDefinitions := anArrayOfRMDSimulationPropertyDefinitionNode
]
