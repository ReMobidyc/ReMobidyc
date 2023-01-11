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
RMDAgentInitializerNode >> agentName [

	^ self subclassResponsibility
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

{ #category : #accessing }
RMDAgentInitializerNode >> complementUtilityDefinitions [

	| boundUtils freeUtils |
	boundUtils := (utilityDefinitions collect: [ :util | 
		               util variable identifier ]) asSet.
	freeUtils := OrderedCollection new.
	attributeInitializers do: [ :attributeInitializer | 
		attributeInitializer
			nodesSuchThat: #isUtilityVariableNode
			do: [ :util | 
				| identifier |
				identifier := util identifier.
				((boundUtils includes: identifier) or: [ 
					 freeUtils includes: identifier ]) ifFalse: [ 
					freeUtils add: identifier ] ] ].
	utilityDefinitions do: [ :utilityDefinition | 
		utilityDefinition
			nodesSuchThat: #isUtilityVariableNode
			do: [ :util | 
				| identifier |
				identifier := util identifier.
				((boundUtils includes: identifier) or: [ 
					 freeUtils includes: identifier ]) ifFalse: [ 
					freeUtils add: identifier ] ] ].
	utilityDefinitions := utilityDefinitions
	                      , (freeUtils collect: [ :identifier | 
			                       RMDUtilityDefinitionNode
				                       variable:
				                       (RMDUtilityVariableNode identifier:
					                        identifier)
				                       expression: RMDLiteralNode zero ])
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

{ #category : #printing }
RMDAgentInitializerNode >> printShortOn: aStream [

	aStream
		nextPutAll: 'Initial setup of ';
		nextPutAll: self agentName
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
