Class {
	#name : #RMDSpeciesInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'propertyInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #enumerating }
RMDSpeciesInitializerNode >> childrenDo: aBlock [
	propertyInitializers do: aBlock
]

{ #category : #testing }
RMDSpeciesInitializerNode >> isSpeciesInitializerNode [
	^ true
]

{ #category : #accessing }
RMDSpeciesInitializerNode >> propertyInitializers [
	^ propertyInitializers
]

{ #category : #accessing }
RMDSpeciesInitializerNode >> propertyInitializers: anArrayOfRMDSimulationPropertyInitializerNode [
	propertyInitializers := anArrayOfRMDSimulationPropertyInitializerNode
]
