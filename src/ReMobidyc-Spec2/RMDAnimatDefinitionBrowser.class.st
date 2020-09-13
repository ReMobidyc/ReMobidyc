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
