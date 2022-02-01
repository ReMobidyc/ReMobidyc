Class {
	#name : #RMDWorldDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDWorldDefinitionBrowser class >> on: aRMDSimulationModel [
	<script:
		'(RMDWorldDefinitionBrowser on: RMDSimulationModel sugarScape) openWithSpec'>
	^ self new
		setSimulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #private }
RMDWorldDefinitionBrowser >> addInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	simulationModel simulationDefinition worldInitializer
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
RMDWorldDefinitionBrowser >> agentName [
	^ 'World'
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> definitionDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel worldDefinition ifNotNil: aBlock ]
]

{ #category : #private }
RMDWorldDefinitionBrowser >> removeInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	simulationModel simulationDefinition worldInitializer
		ifNotNil: [ :initializer | 
			initializer
				attributeInitializers:
					(initializer attributeInitializers
						reject:
							[ :attributeInitializer | attributeInitializer identifier = aRMDAttributeNode identifier ]) ]
]

{ #category : #enumerating }
RMDWorldDefinitionBrowser >> renderersDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel
				renderersDo: [ :renderer | 
					renderer isWorldRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
