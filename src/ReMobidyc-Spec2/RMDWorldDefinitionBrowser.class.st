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
RMDWorldDefinitionBrowser >> addInitializerWithProperty: aRMDPropertyNode animat: anotherString [
	simulationModel simulationDefinition worldInitializer
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
RMDWorldDefinitionBrowser >> agentName [
	^ 'World'
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> definitionDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel worldDefinition ifNotNil: aBlock ]
]

{ #category : #private }
RMDWorldDefinitionBrowser >> removeInitializerWithProperty: aRMDPropertyNode animat: anotherString [
	simulationModel simulationDefinition worldInitializer
		ifNotNil: [ :initializer | 
			initializer
				propertyInitializers:
					(initializer propertyInitializers
						reject:
							[ :propertyInitializer | propertyInitializer identifier = aRMDPropertyNode identifier ]) ]
]

{ #category : #enumerating }
RMDWorldDefinitionBrowser >> renderersDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel
				renderersDo: [ :renderer | 
					renderer isWorldRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
