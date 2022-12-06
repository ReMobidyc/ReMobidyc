Class {
	#name : #RMDAgentInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'attributeInitializers',
		'utilityDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDAgentInitializerNode >> = anObject [

	^ self class = anObject class and: [ 
		  attributeInitializers = anObject attributeInitializers and: [ 
			  utilityDefinitions = anObject utilityDefinitions ] ]
]

{ #category : #accessing }
RMDAgentInitializerNode >> attributeInitializers [
	^ attributeInitializers
]

{ #category : #accessing }
RMDAgentInitializerNode >> attributeInitializers: anArayOfRMDAttributeInitializerNode [
	attributeInitializers := anArayOfRMDAttributeInitializerNode
]

{ #category : #enumerating }
RMDAgentInitializerNode >> childrenDo: aBlock [

	attributeInitializers do: aBlock.
	utilityDefinitions do: aBlock
]

{ #category : #comparing }
RMDAgentInitializerNode >> hash [

	^ (self class hash bitXor: attributeInitializers hash) bitXor:
		  utilityDefinitions hash
]

{ #category : #testing }
RMDAgentInitializerNode >> isAgentInitializerNode [
	^ true
]

{ #category : #copying }
RMDAgentInitializerNode >> postCopy [

	attributeInitializers := attributeInitializers collect: #copy.
	utilityDefinitions := utilityDefinitions collect: #copy
]

{ #category : #rewriting }
RMDAgentInitializerNode >> replaceChildren: aDictionary [

	attributeInitializers := attributeInitializers collect: [ :node | 
		                         node copyReplace: aDictionary ].
	utilityDefinitions := utilityDefinitions collect: [ :node | 
		                      node copyReplace: aDictionary ]
]

{ #category : #accessing }
RMDAgentInitializerNode >> utilityDefinitions [

	^ utilityDefinitions
]

{ #category : #accessing }
RMDAgentInitializerNode >> utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	utilityDefinitions := anArrayOfRMDUtilityDefinitionNode
]
