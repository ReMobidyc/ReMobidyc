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

{ #category : #accessing }
RMDWorldDefinitionBrowser >> agentName [
	^ 'World'
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> definitionDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel worldDefinition ifNotNil: aBlock ]
]

{ #category : #enumerating }
RMDWorldDefinitionBrowser >> renderersDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel
				renderersDo: [ :renderer | 
					renderer isWorldRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
