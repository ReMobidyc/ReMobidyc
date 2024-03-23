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

{ #category : #menus }
RMDPatchDefinitionBrowser >> addRendererMenu [

	^ self newMenu addGroup: [ :group | 
		  group
			  addItem: [ :item | 
				  item
					  name: 'expression -> transparency';
					  action: [ 
						  self addRenderer: (RMDPatchColorAlphaRenderer
									   color: Color green
									   alpha: '0.5' asRMDExpression
									   between: '0.0' asRMDExpression
									   and: '1.0' asRMDExpression) ] ];
			  addItem: [ :item | 
				  item
					  name: 'expression -> brightness';
					  action: [ 
						  self addRenderer: (RMDPatchColorBrightnessRenderer
									   color: Color green
									   brightness: '0.5' asRMDExpression
									   between: '0.0' asRMDExpression
									   and: '1.0' asRMDExpression) ] ] ]
]

{ #category : #accessing }
RMDPatchDefinitionBrowser >> agentName [
	^ 'Patch'
]

{ #category : #accessing }
RMDPatchDefinitionBrowser >> definitionDo: aBlock [

	^ self simulationModel ifNotNil: [ :model |
		  model patchDefinition ifNotNil: aBlock ]
]

{ #category : #operations }
RMDPatchDefinitionBrowser >> renameAttribute: aString to: anotherString [

	super renameAttribute: aString to: anotherString.
	self renameAttribute: aString to: anotherString agentRef: 'here'
]

{ #category : #enumerating }
RMDPatchDefinitionBrowser >> renderersDo: aBlock [

	self simulationModel ifNotNil: [ :model | 
		model renderersDo: [ :renderer | 
			renderer isPatchRenderer ifTrue: [ aBlock cull: renderer ] ] ]
]
