Class {
	#name : #RMDAnimatDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDAnimatDefinitionBrowser class >> on: aRMDSimulationModel animat: aString [
	<script:
		'(RMDAnimatDefinitionBrowser on: RMDSimulationModel sugarScape animat: ''Goat'') openWithSpec'>
	^ self new
		setSimulationModel: aRMDSimulationModel
			animat: aString;
		yourself
]

{ #category : #private }
RMDAnimatDefinitionBrowser >> addInitializerWithProperty: aRMDPropertyNode animat: aString [
	simulationModel simulationDefinition animatInitializers
		do: [ :animatInitializer | 
			animatInitializer animat = aString
				ifTrue: [ animatInitializer
						propertyInitializers:
							(animatInitializer propertyInitializers
								copyWith:
									(RMDPropertyInitializerNode
										identifier: aRMDPropertyNode identifier
										expression: (RMDLiteralNode literal: '0' unit: aRMDPropertyNode unit))) ] ]
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> agentName [
	^ animat
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> definitionDo: aBlock [
	simulationModel ifNil: [ ^ nil ].
	animat ifNil: [ ^ nil ].
	(simulationModel animatDefinitionAt: animat ifAbsent: [  ])
		ifNotNil: aBlock
]

{ #category : #private }
RMDAnimatDefinitionBrowser >> removeInitializerWithProperty: aRMDPropertyNode animat: aString [
	simulationModel simulationDefinition animatInitializers
		do: [ :animatInitializer | 
			animatInitializer animat = aString
				ifTrue: [ animatInitializer
						propertyInitializers:
							(animatInitializer propertyInitializers
								reject: [ :initializer | initializer identifier = aRMDPropertyNode identifier ]) ] ]
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> renderersDo: aBlock [
	simulationModel ifNil: [ ^ self ].
	animat ifNil: [ ^ self ].
	simulationModel
		renderersDo: [ :renderer | 
			(renderer isAnimatRendererFor: animat)
				ifTrue: [ aBlock cull: renderer ] ]
]

{ #category : #private }
RMDAnimatDefinitionBrowser >> setSimulationModel: aRMDSimulationModel animat: aString [
	animat := aString.
	self setSimulationModel: aRMDSimulationModel
]
