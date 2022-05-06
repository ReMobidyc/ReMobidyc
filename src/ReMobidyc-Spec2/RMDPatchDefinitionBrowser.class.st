Class {
	#name : #RMDPatchDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDPatchDefinitionBrowser class >> on: aRMDSimulationModel [
	<script:
		'(RMDPatchDefinitionBrowser on: RMDSimulationModel sugarScape ) openWithSpec'>
	^ self new setSimulationModel: aRMDSimulationModel yourself
]

{ #category : #private }
RMDPatchDefinitionBrowser >> addInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	simulationModel simulationDefinition patchInitializer
		ifNotNil: [ :initializer | 
			initializer
				attributeInitializers:
					(initializer attributeInitializers
						copyWith:
							(RMDAttributeInitializerNode
								identifier: aRMDAttributeNode identifier
								expression: (RMDLiteralNode literal: '0' unit: aRMDAttributeNode unit))) ]
]

{ #category : #accessing }
RMDPatchDefinitionBrowser >> agentName [
	^ 'Patch'
]

{ #category : #accessing }
RMDPatchDefinitionBrowser >> definitionDo: aBlock [
	simulationModel ifNotNil: [ simulationModel patchDefinition ifNotNil: aBlock ]
]

{ #category : #private }
RMDPatchDefinitionBrowser >> removeInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	simulationModel simulationDefinition patchInitializer
		ifNotNil: [ :initializer | 
			initializer
				attributeInitializers:
					(initializer attributeInitializers
						reject:
							[ :attributeInitializer | attributeInitializer identifier = aRMDAttributeNode identifier ]) ]
]

{ #category : #enumerating }
RMDPatchDefinitionBrowser >> renderersDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel
				renderersDo: [ :renderer | 
					renderer isPatchRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
