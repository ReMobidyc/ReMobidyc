Class {
	#name : #RMDAnimatDefinitionBrowser,
	#superclass : #RMDAgentDefinitionBrowser,
	#instVars : [
		'copyStageButton',
		'renameStageButton',
		'renameSpeciesButton',
		'spreadAttributeButton',
		'spreadUtilityButton',
		'spreadTaskButton'
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
										      add: #spreadAttributeButton width: self buttonHeight;
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
										      add: #spreadUtilityButton width: self buttonHeight;
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
														        add: #spreadTaskButton width: self buttonHeight;
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
	spreadAttributeButton := self newButton
		                         icon: self spreadIcon;
		                         action: [ self spreadAttribute ];
		                         help:
			                         'Spread the attribute definition over all stages of the species';
		                         disable;
		                         yourself.
	spreadUtilityButton := self newButton
		                       icon: self spreadIcon;
		                       action: [ self spreadUtility ];
		                       help:
			                       'Spread the utility definition over all stages of the species';
		                       disable;
		                       yourself.
	spreadTaskButton := self newButton
		                    icon: self spreadIcon;
		                    action: [ self spreadTask ];
		                    help:
			                    'Spread the task definition over all stages of the species';
		                    disable;
		                    yourself.
	renameSpeciesButton := self newButton
		                       label: 'rename species';
		                       help: 'Change the name of species.';
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
		                   help:
			                   'Create a copy of this stage and rename it.';
		                   action: [ self copyStage ];
		                   yourself
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

{ #category : #operations }
RMDAnimatDefinitionBrowser >> spreadAttribute [

	attributeList selection selectedItem ifNotNil: [ :attributeNode |
		(UIManager default
			 confirm: 'Add/overwrite the attribute definition to all stages?'
			 label: 'Spread attribute') ifTrue: [
			| animatDefinition |
			animatDefinition := self agentDefinition.
			self stagesOfSpeciesDo: [ :stage |
				| attributes |
				attributes := stage attributeDeclarations.
				(attributes
					 detect: [ :attribute |
					 attribute identifier = attributeNode identifier ]
					 ifNone: [ nil ])
					ifNil: [ attributes := attributes copyWith: attributeNode copy ]
					ifNotNil: [ :attribute |
						attribute ~= attributeNode ifTrue: [
							(UIManager default
								 confirm:
								 'Overwrite ' , stage identifier , '''s '
								 , attribute printString , '?'
								 label: 'Overwrite') ifTrue: [
								attributes
									at: (attributes indexOf: attribute)
									put: attributeNode copy ] ] ].
				stage attributeDeclarations: attributes ].
			self updateAttributeList.
			modeler ifNotNil: #updatePages ] ]
]

{ #category : #operations }
RMDAnimatDefinitionBrowser >> spreadTask [

	taskList selection selectedItem ifNotNil: [ :taskNode |
		(UIManager default
			 confirm: 'Add/overwrite the task definition to all stages?'
			 label: 'Spread task') ifTrue: [
			| animatDefinition tasks |
			animatDefinition := self agentDefinition.
			tasks := self simulationModel taskDefinitions.
			self stagesOfSpeciesDo: [ :stage |
				(tasks
					 detect: [ :task |
						 task subjectIdentifier = stage identifier and: [
							 task verbIdentifier = taskNode verbIdentifier ] ]
					 ifNone: [ nil ])
					ifNil: [
						tasks := tasks copyWith: (taskNode copy
								          subjectIdentifier: stage identifier;
								          yourself) ]
					ifNotNil: [ :task |
						task ~= taskNode ifTrue: [
							(UIManager default
								 confirm:
								 'Overwrite ' , stage identifier , '''s '
								 , task verbIdentifier , '?'
								 label: 'Overwrite') ifTrue: [
								tasks at: (tasks indexOf: task) put: (task copy
										 subjectIdentifier: stage identifier;
										 yourself) ] ] ] ].
			self simulationModel taskDefinitions: tasks.
			self updateTaskList.
			self updateSourceText.
			modeler ifNotNil: #updatePages ] ]
]

{ #category : #operations }
RMDAnimatDefinitionBrowser >> spreadUtility [

	utilityList selection selectedItem ifNotNil: [ :utilityNode |
		(UIManager default
			 confirm: 'Add/overwrite the utility definition to all stages?'
			 label: 'Spread utility') ifTrue: [
			| animatDefinition |
			animatDefinition := self agentDefinition.
			self stagesOfSpeciesDo: [ :stage |
				| utilities |
				utilities := stage utilityDefinitions.
				(utilities
					 detect: [ :utility |
						 utility variable identifier = utilityNode variable identifier ]
					 ifNone: [ nil ])
					ifNil: [ utilities := utilities copyWith: utilityNode copy ]
					ifNotNil: [ :utility |
						utility ~= utilityNode ifTrue: [
							(UIManager default
								 confirm:
								 'Overwrite ' , stage identifier , '''s '
								 , utility printString , '?'
								 label: 'Overwrite') ifTrue: [
								utilities
									at: (utilities indexOf: utility)
									put: utilityNode copy ] ] ].
				stage utilityDefinitions: utilities ].
			self updateUtilityList.
			modeler ifNotNil: #updatePages ] ]
]

{ #category : #accessing }
RMDAnimatDefinitionBrowser >> stagesOfSpeciesDo: aBlock [

	(self simulationModel stageNamesOf: self speciesName) do: [ :name |
		(self simulationModel animatDefinitionAt: name ifAbsent: [ nil ])
			ifNotNil: aBlock ]
]

{ #category : #updating }
RMDAnimatDefinitionBrowser >> updateAttributeButtons [

	| selected |
	super updateAttributeButtons.
	selected := attributeList selection selectedItem notNil.
	spreadAttributeButton enabled: selected
]

{ #category : #updating }
RMDAnimatDefinitionBrowser >> updateTaskButtons [

	| selected |
	selected := taskList selection selectedItem notNil.
	super updateTaskButtons.
	spreadTaskButton enabled: selected
]

{ #category : #updating }
RMDAnimatDefinitionBrowser >> updateUtilityButtons [

	| selected |
	super updateUtilityButtons.
	selected := utilityList selection selectedItem notNil.
	spreadUtilityButton enabled: selected
]
