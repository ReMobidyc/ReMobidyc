Class {
	#name : #RMDAgentDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'visualizer',
		'animat',
		'propertyList',
		'addPropertyButton',
		'removePropertyButton',
		'editPropertyButton',
		'rendererList',
		'addRendererButton',
		'removeRendererButton',
		'editRendererButton',
		'sourceText',
		'addTaskButton',
		'taskList',
		'editTaskButton',
		'removeTaskButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDAgentDefinitionBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.3;
		add:
			(SpPanedLayout newHorizontal
				position: 0.5;
				add:
					(SpBoxLayout newVertical
						add: 'Properties' expand: false;
						add: #propertyList;
						add:
							(SpBoxLayout newHorizontal
								add: #addPropertyButton width: self buttonHeight;
								add: #removePropertyButton width: self buttonHeight;
								add: #editPropertyButton width: self buttonHeight;
								yourself)
							height: self buttonHeight;
						yourself);
				add:
					(SpBoxLayout newVertical
						add: 'Visualization' expand: false;
						add: #rendererList;
						add:
							(SpBoxLayout newHorizontal
								add: #addRendererButton width: self buttonHeight;
								add: #removeRendererButton width: self buttonHeight;
								add: #editRendererButton width: self buttonHeight;
								yourself)
							height: self buttonHeight;
						yourself);
				yourself);
		add:
			(SpBoxLayout newVertical
				add: 'Tasks' expand: false;
				add:
					(SpPanedLayout newHorizontal
						position: 0.4;
						add:
							(SpBoxLayout newVertical
								add: #taskList;
								add:
									(SpBoxLayout newHorizontal
										add: #addTaskButton width: self buttonHeight;
										add: #removeTaskButton width: self buttonHeight;
										add: #editTaskButton width: self buttonHeight;
										yourself)
									height: self buttonHeight;
								yourself);
						add: #sourceText);
				yourself);
		yourself
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addProperty [
	| propertyNode |
	(propertyNode := RMDPropertyDeclarationNode
		identifier: ''
		unit: RMDUnit noDimension) asPresenter openDialogWithSpec
		title: 'Add property to ' , self agentName;
		okAction: [ self
				definitionDo: [ :definition | 
					definition
						propertyDeclarations: (definition propertyDeclarations copyWith: propertyNode).
					self updatePropertyList ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addRenderer [
	^ self notYetImplemented
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addTask [
	| actionDefinitionBrowser |
	actionDefinitionBrowser := (RMDTaskDefinitionEditor
		on: simulationModel)
		taskDefinition: nil;
		agentName: self agentName;
		yourself.
	actionDefinitionBrowser openDialogWithSpec
		okAction: [ actionDefinitionBrowser taskDefinition
				ifNotNil: [ :taskDefinition | 
					simulationModel addTaskDefinition: taskDefinition.
					self updateTaskList ] ]
]

{ #category : #accessing }
RMDAgentDefinitionBrowser >> agentName [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAgentDefinitionBrowser >> definitionDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> editProperty [
	propertyList selection selectedItem
		ifNotNil: [ :originalPropertyNode | 
			| newPropertyNode |
			newPropertyNode := originalPropertyNode copy.
			newPropertyNode asPresenter openDialogWithSpec
				title: 'Edit property of ' , self agentName;
				okAction: [ self
						definitionDo: [ :definition | 
							definition
								propertyDeclarations:
									((definition propertyDeclarations copyWithout: originalPropertyNode)
										copyWith: newPropertyNode).
							self updatePropertyList ] ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> editRenderer [
	^ self notYetImplemented
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> editTask [
	taskList selection selectedItem
		ifNotNil: [ :oldTaskDefinition | 
			| actionDefinitionBrowser |
			actionDefinitionBrowser := (RMDTaskDefinitionEditor
				on: simulationModel)
				taskDefinition: oldTaskDefinition copy;
				agentName: self agentName;
				yourself.
			actionDefinitionBrowser openDialogWithSpec
				okAction: [ actionDefinitionBrowser taskDefinition
						ifNotNil: [ :taskDefinition | 
							simulationModel
								removeTaskDefinition: oldTaskDefinition ifAbsent: [  ];
								addTaskDefinition: taskDefinition.
							self updateTaskList.
							taskList selectItem: taskDefinition.
							self updateSourceText ] ] ]
]

{ #category : #initialization }
RMDAgentDefinitionBrowser >> initializePresenters [
	super initializePresenters.
	propertyList := self newTable
		beSingleSelection;
		beResizable;
		showColumnHeaders;
		addColumn:
			(SpStringTableColumn
				title: 'name'
				evaluated: [ :item | item identifier ]);
		addColumn:
			(SpStringTableColumn
				title: 'unit'
				evaluated: [ :item | 
					| unit |
					unit := item unit.
					unit hasDimension
						ifTrue: [ unit printString ]
						ifFalse: [ '' ] ]);
		whenModelChangedDo: [ propertyList selectItem: nil ];
		whenSelectionChangedDo: [ | selected |
			selected := propertyList selection selectedItem notNil.
			removePropertyButton enabled: selected.
			editPropertyButton enabled: selected ];
		yourself.
	addPropertyButton := self newButton
		icon: self addIcon;
		action: [ self addProperty ];
		yourself.
	removePropertyButton := self newButton
		icon: self removeIcon;
		action: [ self removeProperty ];
		disable;
		yourself.
	editPropertyButton := self newButton
		icon: self editIcon;
		action: [ self editProperty ];
		disable;
		yourself.
	rendererList := self newComponentList
		beSingleSelection;
		whenModelChangedDo: [ rendererList selectItem: nil ];
		whenSelectionChangedDo: [ | selected |
			selected := rendererList selection selectedItem notNil.
			removeRendererButton enabled: selected.
			editRendererButton enabled: selected ];
		yourself.
	addRendererButton := self newButton
		icon: self addIcon;
		action: [ self addRenderer ];
		yourself.
	removeRendererButton := self newButton
		icon: self removeIcon;
		action: [ self removeRenderer ];
		disable;
		yourself.
	editRendererButton := self newButton
		icon: self editIcon;
		action: [ self editRenderer ];
		disable;
		yourself.
	taskList := self newTable
		beSingleSelection;
		beResizable;
		addColumn: (SpStringTableColumn evaluated: [ :item | item verbIdentifier ]);
		addColumn:
			(SpStringTableColumn
				evaluated: [ :item | item objectIdentifier ifNil: [ '' ] ]);
		whenModelChangedDo: [ taskList selectItem: nil ];
		whenSelectionChangedDo: [ | selected |
			selected := taskList selection selectedItem notNil.
			removeTaskButton enabled: selected.
			editTaskButton enabled: selected.
			self updateSourceText ];
		yourself.
	addTaskButton := self newButton
		icon: self addIcon;
		action: [ self addTask ];
		yourself.
	removeTaskButton := self newButton
		icon: self removeIcon;
		action: [ self removeTask ];
		disable;
		yourself.
	editTaskButton := self newButton
		icon: self editIcon;
		action: [ self editTask ];
		disable;
		yourself.
	sourceText := (self newSourceWith: RMDGrammar new actionDefinition)
		enabled: false;
		whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		yourself
]

{ #category : #initialization }
RMDAgentDefinitionBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: self agentName.
	aWindowPresenter initialExtent: 800 @ 600
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeProperty [
	propertyList selection selectedItem
		ifNotNil: [ :propertyNode | 
			(self newLabel
				label: 'OK to remove ' , propertyNode identifier , '?';
				yourself) openDialogWithSpec
				title: 'Remove property from ' , self agentName;
				extent: 400 @ (self class buttonHeight * 3.5);
				okAction: [ self
								definitionDo: [ :definitionNode | 
									definitionNode
										propertyDeclarations: (definitionNode propertyDeclarations copyWithout: propertyNode).
									self updatePropertyList ] ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeRenderer [
	rendererList selection selectedItem
		ifNotNil: [ :rendererPresenter | 
			(self newLabel
				label: 'OK to remove ' , rendererPresenter name , '?';
				yourself) openDialogWithSpec
				title: 'Remove visualization from ' , self agentName;
				extent: 400 @ (self class buttonHeight * 3.5);
				okAction: [ simulationModel
								removeRenderer: rendererPresenter renderer
								ifAbsent: [  ].
							self updateRendererList ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeTask [
	taskList selection selectedItem
		ifNotNil: [ :taskDefinition | 
			simulationModel
				removeTaskDefinition: taskDefinition
				ifAbsent: [ KeyNotFound signal: taskDefinition ].
			self updateTaskList ]
]

{ #category : #enumerating }
RMDAgentDefinitionBrowser >> renderersDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #private }
RMDAgentDefinitionBrowser >> setSimulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel.
	self updatePropertyList.
	self updateRendererList.
	self updateTaskList
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updatePropertyList [
	self
		definitionDo: [ :definition | propertyList items: definition propertyDeclarations ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateRendererList [
	rendererList
		items:
			(Array
				streamContents: [ :stream | 
					self
						renderersDo: [ :renderer | 
							stream
								nextPut: (renderer asPresenter enabled: false);
								yourself ] ]).
	rendererList items
		do:
			[ :item | item withWidgetDo: [ :w | w update: #color: with: {Color white} ] ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateSourceText [
	simulationModel
		ifNotNil: [ taskList selection selectedItem
				ifNotNil: [ :behaviorDefinition | 
					sourceText
						text: (behaviorDefinition actionWith: simulationModel) printString asText ]
				ifNil: [ sourceText text: '' ] ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateTaskList [
	simulationModel
		ifNotNil: [ | selectedBehavior |
			selectedBehavior := taskList selection selectedItem.
			taskList
				items:
					(simulationModel taskDefinitions
						select: [ :behavior | behavior subjectIdentifier = self agentName ]);
				selectItem: selectedBehavior ]
]
