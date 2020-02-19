Class {
	#name : #RMDAnimatInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'population',
		'animat',
		'propertyInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAnimatInitializerNode class >> population: anInteger animat: aString propertyInitializers: anArrayOfRMDSimulationPropertyInitializerNode [
	^ self new
		population: anInteger;
		animat: aString;
		propertyInitializers: anArrayOfRMDSimulationPropertyInitializerNode;
		yourself
]

{ #category : #accessing }
RMDAnimatInitializerNode >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatInitializerNode >> animat: aString [
	animat := aString
]

{ #category : #enumerating }
RMDAnimatInitializerNode >> childrenDo: aBlock [
	propertyInitializers do: aBlock
]

{ #category : #testing }
RMDAnimatInitializerNode >> isSimulationAnimatDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDAnimatInitializerNode >> population [
	^ population
]

{ #category : #accessing }
RMDAnimatInitializerNode >> population: anInteger [
	population := anInteger
]

{ #category : #printing }
RMDAnimatInitializerNode >> printOn: aStream [
	population printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: animat.
	propertyInitializers
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyInitializers
				do: [ :def | 
					def printOn: aStream.
					aStream nextPut: Character cr ] ]
]

{ #category : #accessing }
RMDAnimatInitializerNode >> propertyInitializers [
	^ propertyInitializers
]

{ #category : #accessing }
RMDAnimatInitializerNode >> propertyInitializers: anArrayOfRMDSimulationPropertyInitializerNode [
	propertyInitializers := anArrayOfRMDSimulationPropertyInitializerNode
]
