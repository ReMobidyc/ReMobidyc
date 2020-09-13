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

{ #category : #accessing }
RMDCellDefinitionBrowser >> agentName [
	^ 'Cell'
]

{ #category : #accessing }
RMDCellDefinitionBrowser >> definitionDo: aBlock [
	simulationModel ifNotNil: [ simulationModel cellDefinition ifNotNil: aBlock ]
]

{ #category : #enumerating }
RMDCellDefinitionBrowser >> renderersDo: aBlock [
	simulationModel
		ifNotNil: [ simulationModel
				renderersDo: [ :renderer | 
					renderer isCellRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
