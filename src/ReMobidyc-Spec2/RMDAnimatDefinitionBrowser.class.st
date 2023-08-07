Class {
	#name : #RMDAnimatDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#instVars : [
		'copyStageButton',
		'renameStageButton',
		'renameSpeciesButton'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDAnimatDefinitionBrowser class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #renameSpeciesButton expand: false;
				   add: #renameStageButton expand: false;
				   add: #copyStageButton expand: false;
				   yourself)
		  height: self buttonHeight;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.4;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.6;
						    add: (SpBoxLayout newVertical
								     add: 'Attributes' expand: false;
								     add: #attributeList;
								     add: (SpBoxLayout newHorizontal
										      add: #addAttributeButton width: self buttonHeight;
										      add: #removeAttributeButton width: self buttonHeight;
										      add: #moveUpAttributeButton width: self buttonHeight;
										      add: #moveDownAttributeButton
										      width: self buttonHeight;
										      add: #editAttributeButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     add: 'Data source' expand: false;
								     add: (SpBoxLayout newHorizontal
										      add: #addDataSourceButton width: self buttonHeight;
										      add: #removeDataSourceButton width: self buttonHeight;
										      add: #openDataSourceButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: 'where' expand: false;
								     add: #utilityList;
								     add: (SpBoxLayout newHorizontal
										      add: #addUtilityButton width: self buttonHeight;
										      add: #removeUtilityButton width: self buttonHeight;
										      add: #moveUpUtilityButton width: self buttonHeight;
										      add: #moveDownUtilityButton width: self buttonHeight;
										      add: #editUtilityButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    yourself);
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.75;
						    add: (SpBoxLayout newVertical
								     add: 'Tasks' expand: false;
								     add: (SpPanedLayout newHorizontal
										      positionOfSlider: 0.3;
										      add: (SpBoxLayout newVertical
												       add: #taskList;
												       add: (SpBoxLayout newHorizontal
														        add: #addTaskButton width: self buttonHeight;
														        add: #removeTaskButton width: self buttonHeight;
														        add: #moveUpTaskButton width: self buttonHeight;
														        add: #moveDownTaskButton
														        width: self buttonHeight;
														        add: #editTaskButton width: self buttonHeight;
														        yourself)
												       height: self buttonHeight;
												       yourself);
										      add: #sourceText);
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: 'Visualization' expand: false;
								     add: #rendererList;
								     add: (SpBoxLayout newHorizontal
										      add: #addRendererButton width: self buttonHeight;
										      add: #removeRendererButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    yourself) yourself);
		  yourself
]

{ #category : #'instance creation' }
RMDAnimatDefinitionBrowser class >> on: aRMDSimulationModeler animat: aString [

	^ self new
		  setSimulationModeler: aRMDSimulationModeler animat: aString;
		  yourself
]

{ #category : #menus }
RMDAnimatDefinitionBrowser >> addIconRendererMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  icon: self addIcon;
						  action: [ 
							  self addNewIconToSimulationModelDo: [ :iconName | 
									  self addRenderer:
											  (RMDAnimatIconRenderer on: animat iconName: iconName) ] ] ] ];
		  addGroup: [ :group | 
			  modeler simulationModel iconNames do: [ :iconName | 
				  group addItem: [ :item | 
					  item
						  name: iconName;
						  action: [ 
							  self addRenderer:
									  (RMDAnimatIconRenderer on: animat iconName: iconName) ] ] ] ]
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
						  expression: nil)) ] ]
]

{ #category : #operations }
RMDAnimatDefinitionBrowser >> addNewIconToSimulationModelDo: aBlock [

	^ modeler addNewIconDo: aBlock
]

{ #category : #menus }
RMDAnimatDefinitionBrowser >> addRendererMenu [

	^ self newMenu addGroup: [ :group | 
		  group
			  addItem: [ :item | 
				  item
					  name: 'dot';
					  action: [ 
						  self addRenderer:
								  (RMDAnimatDotRenderer
									   on: animat
									   shapeSize: 10
									   color: Color gray) ] ];
			  addItem: [ :item | 
				  item
					  name: 'rectangle';
					  action: [ 
						  self addRenderer:
								  (RMDAnimatRectangleRenderer
									   on: animat
									   shapeSize: 10
									   color: Color gray) ] ];
			  addItem: [ :item | 
				  item
					  name: 'triangle';
					  action: [ 
						  self addRenderer:
								  (RMDAnimatTriangleRenderer
									   on: animat
									   shapeSize: 10
									   color: Color gray) ] ];
			  addItem: [ :item | 
				  item
					  name: 'icon';
					  subMenu: self addIconRendererMenu ] ]
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
	^ (self simulationModel animatDefinitionAt: animat ifAbsent: [  ]) 
		  ifNotNil: aBlock
]

{ #category : #initialization }
RMDAnimatDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	renameSpeciesButton := self newButton
		                label: 'rename species';
		                help:
			                'Change the name of species.';
		                action: [ self renameSpecies ];
		                yourself.
	renameStageButton := self newButton
		                label: 'rename stage';
		                help:
			                'Change the name of stage. All references to this stage will be modified.';
		                action: [ self renameStage ];
		                yourself.
	copyStageButton := self newButton
		              label: 'copy stage';
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
RMDAnimatDefinitionBrowser >> renameSpecies [

	(UIManager default request: 'New name?' initialAnswer: self speciesName) 
		ifNotNil: [ :name | 
		modeler renameSpecies: self speciesName to: name capitalized ]
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

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> speciesName [

	^ self definitionDo: [ :animatDefinition | animatDefinition species ]
]
