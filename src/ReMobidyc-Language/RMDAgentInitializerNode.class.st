Class {
	#name : #RMDAgentInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'attributeInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDAgentInitializerNode >> = anObject [
	^ self class = anObject class
		and: [ attributeInitializers = anObject attributeInitializers ]
]

{ #category : #accessing }
RMDAgentInitializerNode >> attributeInitializers [
	^ attributeInitializers
]

{ #category : #accessing }
RMDAgentInitializerNode >> attributeInitializers: anArrayOfRMDSimulationAttributeInitializerNode [
	attributeInitializers := anArrayOfRMDSimulationAttributeInitializerNode
]

{ #category : #enumerating }
RMDAgentInitializerNode >> childrenDo: aBlock [
	attributeInitializers do: aBlock
]

{ #category : #comparing }
RMDAgentInitializerNode >> hash [
	^ attributeInitializers hash
]

{ #category : #testing }
RMDAgentInitializerNode >> isAgentInitializerNode [
	^ true
]

{ #category : #copying }
RMDAgentInitializerNode >> postCopy [
	attributeInitializers := attributeInitializers collect: #copy
]

{ #category : #rewriting }
RMDAgentInitializerNode >> replaceChildren: aDictionary [
	attributeInitializers := attributeInitializers
		collect: [ :node | node copyReplace: aDictionary ]
]
