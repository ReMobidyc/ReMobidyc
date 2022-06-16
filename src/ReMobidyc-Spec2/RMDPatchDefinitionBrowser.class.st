Class {
	#name : #RMDPatchDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #'instance creation' }
RMDPatchDefinitionBrowser class >> on: aRMDSimulationModeler [

	^ self new
		  setModeler: aRMDSimulationModeler;
		  yourself
]

{ #category : #private }
RMDPatchDefinitionBrowser >> addInitializerWithAttribute: aRMDAttributeNode animat: anotherString [

	self simulationModel simulationDefinition patchInitializer ifNotNil: [ 
		:initializer | 
		initializer attributeInitializers:
			(initializer attributeInitializers copyWith:
				 (RMDAttributeInitializerNode
					  identifier: aRMDAttributeNode identifier
					  expression:
					  (RMDLiteralNode literal: '0' unit: aRMDAttributeNode unit))) ]
]

{ #category : #accessing }
RMDPatchDefinitionBrowser >> agentName [
	^ 'Patch'
]

{ #category : #accessing }
RMDPatchDefinitionBrowser >> definitionDo: aBlock [

	self simulationModel ifNotNil: [ :model | 
		model patchDefinition ifNotNil: aBlock ]
]

{ #category : #private }
RMDPatchDefinitionBrowser >> removeInitializerWithAttribute: aRMDAttributeNode animat: anotherString [

	self simulationModel simulationDefinition patchInitializer ifNotNil: [ 
		:initializer | 
		initializer attributeInitializers:
			(initializer attributeInitializers reject: [ :attributeInitializer | 
				 attributeInitializer identifier = aRMDAttributeNode identifier ]) ]
]

{ #category : #enumerating }
RMDPatchDefinitionBrowser >> renderersDo: aBlock [

	self simulationModel ifNotNil: [ :model | 
		model renderersDo: [ :renderer | 
			renderer isPatchRenderer ifTrue: [ aBlock cull: renderer ] ] ]
]
