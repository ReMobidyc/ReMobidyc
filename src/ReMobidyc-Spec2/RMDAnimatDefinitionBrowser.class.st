Class {
	#name : #RMDAnimatDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #'instance creation' }
RMDAnimatDefinitionBrowser class >> on: aRMDInterpreter visualizer: aRMDVisualizer animat: aString [
	<script:
		'(RMDAnimatDefinitionBrowser on: RMDInterpreter sugarScape visualizer: RMDVisualizer sugarScape animat: ''Goat'') openWithSpec'>
	^ self new
		setInterpreter: aRMDInterpreter
			visualizer: aRMDVisualizer
			animat: aString;
		yourself
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> agentName [
	^ animat
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> definitionDo: aBlock [
	interpreter ifNil: [ ^ nil ].
	animat ifNil: [ ^ nil ].
	(interpreter animatDefinitionAt: animat ifAbsent: [  ])
		ifNotNil: aBlock
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> renderersDo: aBlock [
	visualizer ifNil: [ ^ self ].
	animat ifNil: [ ^ self ].
	visualizer
		renderersDo: [ :renderer | 
			(renderer isAnimatRendererFor: animat)
				ifTrue: [ aBlock cull: renderer ] ]
]

{ #category : #private }
RMDAnimatDefinitionBrowser >> setInterpreter: aRMDInterpreter visualizer: aRMDVisualizer animat: aString [
	animat := aString.
	self setInterpreter: aRMDInterpreter visualizer: aRMDVisualizer
]
