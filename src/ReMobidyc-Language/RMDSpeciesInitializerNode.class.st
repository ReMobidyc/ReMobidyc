Class {
	#name : #RMDSpeciesInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'propertyInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDSpeciesInitializerNode >> = anObject [
	^ self class = anObject class
		and: [ propertyInitializers = anObject propertyInitializers ]
]

{ #category : #enumerating }
RMDSpeciesInitializerNode >> childrenDo: aBlock [
	propertyInitializers do: aBlock
]

{ #category : #comparing }
RMDSpeciesInitializerNode >> hash [
	^ propertyInitializers hash
]

{ #category : #'type checking' }
RMDSpeciesInitializerNode >> inferType [
	propertyInitializers do: [ :node | node inferType ].
	^ type
]

{ #category : #testing }
RMDSpeciesInitializerNode >> isSpeciesInitializerNode [
	^ true
]

{ #category : #copying }
RMDSpeciesInitializerNode >> postCopy [
	propertyInitializers := propertyInitializers collect: #copy
]

{ #category : #accessing }
RMDSpeciesInitializerNode >> propertyInitializers [
	^ propertyInitializers
]

{ #category : #accessing }
RMDSpeciesInitializerNode >> propertyInitializers: anArrayOfRMDSimulationPropertyInitializerNode [
	propertyInitializers := anArrayOfRMDSimulationPropertyInitializerNode
]

{ #category : #rewriting }
RMDSpeciesInitializerNode >> replaceChildren: aDictionary [
	propertyInitializers := propertyInitializers
		collect: [ :node | node copyReplace: aDictionary ]
]
