Class {
	#name : #RMDSpeciesInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'attributeInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDSpeciesInitializerNode >> = anObject [
	^ self class = anObject class
		and: [ attributeInitializers = anObject attributeInitializers ]
]

{ #category : #accessing }
RMDSpeciesInitializerNode >> attributeInitializers [
	^ attributeInitializers
]

{ #category : #accessing }
RMDSpeciesInitializerNode >> attributeInitializers: anArrayOfRMDSimulationAttributeInitializerNode [
	attributeInitializers := anArrayOfRMDSimulationAttributeInitializerNode
]

{ #category : #enumerating }
RMDSpeciesInitializerNode >> childrenDo: aBlock [
	attributeInitializers do: aBlock
]

{ #category : #comparing }
RMDSpeciesInitializerNode >> hash [
	^ attributeInitializers hash
]

{ #category : #testing }
RMDSpeciesInitializerNode >> isSpeciesInitializerNode [
	^ true
]

{ #category : #copying }
RMDSpeciesInitializerNode >> postCopy [
	attributeInitializers := attributeInitializers collect: #copy
]

{ #category : #rewriting }
RMDSpeciesInitializerNode >> replaceChildren: aDictionary [
	attributeInitializers := attributeInitializers
		collect: [ :node | node copyReplace: aDictionary ]
]
