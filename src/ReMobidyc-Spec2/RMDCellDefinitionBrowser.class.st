Class {
	#name : #RMDCellDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDCellDefinitionBrowser class >> on: aRMDSimulationModel [
	<script:
		'(RMDCellDefinitionBrowser on: RMDSimulationModel sugarScape ) openWithSpec'>
	^ self new setSimulationModel: aRMDSimulationModel yourself
]

{ #category : #private }
RMDCellDefinitionBrowser >> addInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	simulationModel simulationDefinition cellInitializer
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
RMDCellDefinitionBrowser >> agentName [
	^ 'Cell'
]

{ #category : #accessing }
RMDCellDefinitionBrowser >> definitionDo: aBlock [
	simulationModel ifNotNil: [ simulationModel cellDefinition ifNotNil: aBlock ]
]

{ #category : #private }
RMDCellDefinitionBrowser >> removeInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	simulationModel simulationDefinition cellInitializer
		ifNotNil: [ :initializer | 
			initializer
				attributeInitializers:
					(initializer attributeInitializers
						reject:
							[ :attributeInitializer | attributeInitializer identifier = aRMDAttributeNode identifier ]) ]
]

{ #category : #enumerating }
RMDCellDefinitionBrowser >> renderersDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel
				renderersDo: [ :renderer | 
					renderer isCellRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
