Class {
	#name : #RMDAnimatDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#instVars : [
		'renameButton',
		'copyButton'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDAnimatDefinitionBrowser class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #renameButton expand: false;
				   add: #copyButton expand: false;
				   yourself)
		  height: self buttonHeight;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.3;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.5;
						    add: (SpBoxLayout newVertical
								     add: 'Attributes' expand: false;
								     add: #attributeList;
								     add: (SpBoxLayout newHorizontal
										      add: #addAttributeButton width: self buttonHeight;
										      add: #removeAttributeButton width: self buttonHeight;
										      add: #editAttributeButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: 'Visualization' expand: false;
								     add: #rendererList;
								     yourself);
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Tasks' expand: false;
						    add: (SpPanedLayout newHorizontal
								     positionOfSlider: 0.4;
								     add: (SpBoxLayout newVertical
										      add: #taskList;
										      add: (SpBoxLayout newHorizontal
												       add: #addTaskButton width: self buttonHeight;
												       add: #removeTaskButton width: self buttonHeight;
												       add: #editTaskButton width: self buttonHeight;
												       yourself)
										      height: self buttonHeight;
										      yourself);
								     add: #sourceText);
						    yourself);
				   yourself);
		  yourself
]

{ #category : #'instance creation' }
RMDAnimatDefinitionBrowser class >> on: aRMDSimulationModeler animat: aString [

	^ self new
		  setSimulationModeler: aRMDSimulationModeler animat: aString;
		  yourself
]

{ #category : #private }
RMDAnimatDefinitionBrowser >> addInitializerWithAttribute: aRMDAttributeNode animat: aString [

	self simulationModel simulationDefinition animatInitializers do: [ 
		:animatInitializer | 
		animatInitializer animat = aString ifTrue: [ 
			animatInitializer attributeInitializers:
				(animatInitializer attributeInitializers copyWith:
					 (RMDAttributeInitializerNode
						  identifier: aRMDAttributeNode identifier
						  expression:
						  (RMDLiteralNode literal: '0' unit: aRMDAttributeNode unit))) ] ]
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> agentName [
	^ animat
]

{ #category : #operations }
RMDAnimatDefinitionBrowser >> copyStage [

	(UIManager default request: 'New name?' initialAnswer: self agentName) 
		ifNotNil: [ :name | 
		modeler copyStage: self agentName to: name capitalized ]
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> definitionDo: aBlock [

	self simulationModel ifNil: [ ^ nil ].
	animat ifNil: [ ^ nil ].
	(self simulationModel animatDefinitionAt: animat ifAbsent: [  ]) 
		ifNotNil: aBlock
]

{ #category : #initialization }
RMDAnimatDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	renameButton := self newButton
		                label: 'rename';
		                help:
			                'Change the name of stage. All references to this stage will be modified.';
		                action: [ self renameStage ];
		                yourself.
	copyButton := self newButton
		              label: 'copy';
		              help: 'Create a copy of this stage and rename it.';
		              action: [ self copyStage ];
		              yourself
]

{ #category : #private }
RMDAnimatDefinitionBrowser >> removeInitializerWithAttribute: aRMDAttributeNode animat: aString [

	self simulationModel simulationDefinition animatInitializers do: [ 
		:animatInitializer | 
		animatInitializer animat = aString ifTrue: [ 
			animatInitializer attributeInitializers:
				(animatInitializer attributeInitializers reject: [ :initializer | 
					 initializer identifier = aRMDAttributeNode identifier ]) ] ]
]

{ #category : #operations }
RMDAnimatDefinitionBrowser >> renameStage [

	(UIManager default request: 'New name?' initialAnswer: self agentName) 
		ifNotNil: [ :name | 
		modeler renameStage: self agentName to: name capitalized ]
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> renderersDo: aBlock [

	self simulationModel ifNil: [ ^ self ].
	animat ifNil: [ ^ self ].
	self simulationModel renderersDo: [ :renderer | 
		(renderer isAnimatRendererFor: animat) ifTrue: [ 
			aBlock cull: renderer ] ]
]

{ #category : #private }
RMDAnimatDefinitionBrowser >> setSimulationModeler: aRMDSimulationModeler animat: aString [

	animat := aString.
	self setModeler: aRMDSimulationModeler
]
