Class {
	#name : #RMDWorldDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDWorldDefinitionBrowser class >> on: aRMDInterpreter visualizer: aRMDVisualizer [
	<script:
		'(RMDWorldDefinitionBrowser on: RMDInterpreter sugarScape visualizer: RMDVisualizer sugarScape) openWithSpec'>
	^ self new
		setInterpreter: aRMDInterpreter visualizer: aRMDVisualizer;
		yourself
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> agentName [
	^ 'World'
]

{ #category : #accessing }
RMDWorldDefinitionBrowser >> definitionDo: aBlock [
	interpreter
		ifNotNil: [ interpreter worldDefinition ifNotNil: aBlock ]
]

{ #category : #enumerating }
RMDWorldDefinitionBrowser >> renderersDo: aBlock [
	visualizer
		ifNotNil: [ visualizer
				renderersDo: [ :renderer | 
					renderer isWorldRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
