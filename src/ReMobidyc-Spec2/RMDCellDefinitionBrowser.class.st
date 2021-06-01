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
RMDCellDefinitionBrowser >> addInitializerWithProperty: aRMDPropertyNode animat: anotherString [
	simulationModel simulationDefinition cellInitializer
		ifNotNil: [ :initializer | 
			initializer
				propertyInitializers:
					(initializer propertyInitializers
						copyWith:
							(RMDPropertyInitializerNode
								identifier: aRMDPropertyNode identifier
								expression: (RMDLiteralNode literal: '0' unit: aRMDPropertyNode unit))) ]
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
RMDCellDefinitionBrowser >> removeInitializerWithProperty: aRMDPropertyNode animat: anotherString [
	simulationModel simulationDefinition cellInitializer
		ifNotNil: [ :initializer | 
			initializer
				propertyInitializers:
					(initializer propertyInitializers
						reject:
							[ :propertyInitializer | propertyInitializer identifier = aRMDPropertyNode identifier ]) ]
]

{ #category : #enumerating }
RMDCellDefinitionBrowser >> renderersDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel
				renderersDo: [ :renderer | 
					renderer isCellRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
