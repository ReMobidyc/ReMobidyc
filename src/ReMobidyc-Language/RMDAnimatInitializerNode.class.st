Class {
	#name : #RMDAnimatInitializerNode,
	#superclass : #RMDSpeciesInitializerNode,
	#instVars : [
		'population',
		'animat'
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

{ #category : #comparing }
RMDAnimatInitializerNode >> = anObject [
	^ super = anObject
		and: [ population = anObject population and: [ animat = anObject animat ] ]
]

{ #category : #accessing }
RMDAnimatInitializerNode >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatInitializerNode >> animat: aString [
	animat := aString
]

{ #category : #comparing }
RMDAnimatInitializerNode >> hash [
	^ (super hash bitXor: population hash) bitXor: animat hash
]

{ #category : #testing }
RMDAnimatInitializerNode >> isAnimatInitializerNode [
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

{ #category : #rewriting }
RMDAnimatInitializerNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary at: animat ifPresent: [ :node | animat := node copy ]
]
