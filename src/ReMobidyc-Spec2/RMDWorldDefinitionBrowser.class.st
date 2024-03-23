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

{ #category : #menus }
RMDWorldDefinitionBrowser >> addRendererMenu [

	^ self newMenu
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> agentName [
	^ 'World'
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> definitionDo: aBlock [

	^ self simulationModel ifNotNil: [ :model |
		  model worldDefinition ifNotNil: aBlock ]
]

{ #category : #initialization }
RMDWorldDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	addRendererButton disable
]

{ #category : #operations }
RMDWorldDefinitionBrowser >> renameAttribute: aString to: anotherString [

	super renameAttribute: aString to: anotherString.
	self renameAttribute: aString to: anotherString agentRef: 'world'
]

{ #category : #enumerating }
RMDWorldDefinitionBrowser >> renderersDo: aBlock [

	self simulationModel ifNotNil: [ :model | 
		model renderersDo: [ :renderer | 
			renderer isWorldRenderer ifTrue: [ aBlock cull: renderer ] ] ]
]
