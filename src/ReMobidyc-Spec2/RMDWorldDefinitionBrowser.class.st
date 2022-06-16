Class {
	#name : #RMDWorldDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #'instance creation' }
RMDWorldDefinitionBrowser class >> on: aRMDSimulationModeler [

	^ self new
		  setModeler: aRMDSimulationModeler;
		  yourself
]

{ #category : #private }
RMDWorldDefinitionBrowser >> addInitializerWithAttribute: aRMDAttributeNode animat: anotherString [

	self simulationModel simulationDefinition worldInitializer ifNotNil: [ 
		:initializer | 
		initializer attributeInitializers:
			(initializer attributeInitializers copyWith:
				 (RMDAttributeInitializerNode
					  identifier: aRMDAttributeNode identifier
					  expression:
					  (RMDLiteralNode literal: '0' unit: aRMDAttributeNode unit))) ]
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> agentName [
	^ 'World'
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> definitionDo: aBlock [

	self simulationModel ifNotNil: [ :model | 
		model worldDefinition ifNotNil: aBlock ]
]

{ #category : #private }
RMDWorldDefinitionBrowser >> removeInitializerWithAttribute: aRMDAttributeNode animat: anotherString [

	self simulationModel simulationDefinition worldInitializer ifNotNil: [ 
		:initializer | 
		initializer attributeInitializers:
			(initializer attributeInitializers reject: [ :attributeInitializer | 
				 attributeInitializer identifier = aRMDAttributeNode identifier ]) ]
]

{ #category : #enumerating }
RMDWorldDefinitionBrowser >> renderersDo: aBlock [

	self simulationModel ifNotNil: [ :model | 
		model renderersDo: [ :renderer | 
			renderer isWorldRenderer ifTrue: [ aBlock cull: renderer ] ] ]
]
