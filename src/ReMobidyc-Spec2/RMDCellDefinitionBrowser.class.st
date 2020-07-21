Class {
	#name : #RMDCellDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDCellDefinitionBrowser class >> on: aRMDInterpreter visualizer: aRMDVisualizer [
	<script:
		'(RMDCellDefinitionBrowser on: RMDInterpreter sugarScape visualizer: RMDVisualizer sugarScape) openWithSpec'>
	^ self new
		setInterpreter: aRMDInterpreter visualizer: aRMDVisualizer;
		yourself
]

{ #category : #accessing }
RMDCellDefinitionBrowser >> agentName [
	^ 'Cell'
]

{ #category : #accessing }
RMDCellDefinitionBrowser >> definitionDo: aBlock [
	interpreter ifNotNil: [ interpreter cellDefinition ifNotNil: aBlock ]
]

{ #category : #enumerating }
RMDCellDefinitionBrowser >> renderersDo: aBlock [
	visualizer
		ifNotNil: [ visualizer
				renderersDo: [ :renderer | 
					renderer isCellRenderer
						ifTrue: [ aBlock cull: renderer ] ] ]
]
