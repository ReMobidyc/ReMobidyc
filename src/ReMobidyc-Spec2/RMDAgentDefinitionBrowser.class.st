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
		'actionSourceText',
		'replacementList',
		'addReplacementButton',
		'removeReplacementButton',
		'editReplacementButton',
		'sourceText',
		'verbIdentifierField',
		'objectIdentifierField',
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
			(SpPanedLayout newVertical
				position: 0.6;
				add:
					(SpPanedLayout newHorizontal
						position: 0.6;
						add:
							(SpBoxLayout newVertical
								add: 'Tasks' expand: false;
								add:
									(SpPanedLayout newHorizontal
										position: 0.3;
										add: #taskList;
										add: #actionSourceText);
								add:
									(SpBoxLayout newHorizontal
										add: #addTaskButton width: self buttonHeight;
										add: #removeTaskButton width: self buttonHeight;
										yourself)
									height: self buttonHeight;
								yourself);
						add:
							(SpBoxLayout newVertical
								add: 'Task Specialization' expand: false;
								add:
									(SpBoxLayout newHorizontal
										add: #verbIdentifierField;
										add: #objectIdentifierField)
									height: self inputTextHeight;
								add: #replacementList;
								add:
									(SpBoxLayout newHorizontal
										add: #addReplacementButton width: self buttonHeight;
										add: #removeReplacementButton width: self buttonHeight;
										add: #editReplacementButton width: self buttonHeight;
										yourself)
									height: self buttonHeight;
								yourself);
						yourself);
				add: #sourceText;
				yourself);
		yourself
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> acceptObjectIdentifierField [
	taskList selection selectedItem
		ifNotNil: [ :taskDefinition | 
			| newObjectIdentifier |
			newObjectIdentifier := objectIdentifierField lastValidSyntaxNode
				ifEmpty: [ nil ].
			taskDefinition objectIdentifier ~= newObjectIdentifier
				ifTrue: [ (simulationModel taskDefinitions
						anySatisfy: [ :task | 
							task verbIdentifier = verbIdentifierField lastValidSyntaxNode
								and: [ task objectIdentifier = newObjectIdentifier ] ])
						ifTrue: [ objectIdentifierField beError ]
						ifFalse: [ taskDefinition objectIdentifier: newObjectIdentifier.
							self updateTaskList ] ] ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> acceptVerbIdentifierField [
	taskList selection selectedItem
		ifNotNil: [ :taskDefinition | 
			| newVerb |
			newVerb := verbIdentifierField lastValidSyntaxNode.
			taskDefinition verbIdentifier ~= newVerb
				ifTrue: [ (simulationModel taskDefinitions
						anySatisfy: [ :task | 
							task verbIdentifier = newVerb
								and: [ task objectIdentifier
										= (objectIdentifierField lastValidSyntaxNode ifEmpty: [ nil ]) ] ])
						ifTrue: [ verbIdentifierField beError ]
						ifFalse: [ taskDefinition
								verbIdentifier: newVerb;
								resetAction.
							self
								updateTaskList;
								updateSourceText ] ] ]
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
RMDAgentDefinitionBrowser >> addReplacement [
	taskList selection selectedItem
		ifNotNil: [ :task | 
			| bindEditor |
			(bindEditor := RMDPropertyBindEditor
				actionDefinition: (task actionIdentifier resolveWith: simulationModel)
				except:
					(task propertyBinds
						collect: [ :bind | 
							RMDPropertyVariableNode
								identifier: bind actionProperty
								agent: bind actionAgent ])) openDialogWithSpec
				okAction: [ bindEditor propertyBindNode
						ifNotNil: [ :bindNode | 
							task propertyBinds: (task propertyBinds copyWith: bindNode).
							self
								updateReplacementList;
								updateSourceText ] ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addTask [
	| actionDefinitionBrowser |
	actionDefinitionBrowser := RMDActionDefinitionBrowser
		on: simulationModel.
	actionDefinitionBrowser openDialogWithSpec
		okAction: [ | actionIdentifier actionDefinition |
			actionIdentifier := actionDefinitionBrowser actionIdentifier.
			actionDefinition := actionIdentifier resolveWith: simulationModel.
			simulationModel
				addTaskDefinition:
					(RMDTaskDefinitionNode
						subjectIdentifier: self agentName
						verbIdentifier: actionIdentifier shortName
						objectIdentifier: actionDefinition object
						actionIdentifier: actionIdentifier
						within: nil
						propertyBinds: Array new).
			self updateTaskList ]
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
RMDAgentDefinitionBrowser >> editReplacement [
	replacementList selection selectedItem
		ifNotNil: [ :oldBind | 
			taskList selection selectedItem
				ifNotNil: [ :task | 
					| bindEditor |
					bindEditor := RMDPropertyBindEditor
						actionDefinition: (task actionIdentifier resolveWith: simulationModel)
						except:
							(task propertyBinds
								select: [ :bind | bind ~= oldBind ]
								thenCollect: [ :bind | 
									RMDPropertyVariableNode
										identifier: bind actionProperty
										agent: bind actionAgent ]).
					bindEditor propertyBindNode: oldBind.
					bindEditor openDialogWithSpec
						okAction: [ bindEditor propertyBindNode
								ifNotNil: [ :newBind | 
									| index |
									index := task propertyBinds indexOf: oldBind.
									index > 0
										ifTrue: [ task propertyBinds at: index put: newBind.
											task resetAction ]
										ifFalse: [ task propertyBinds: (task propertyBinds copyWith: newBind) ].
									self
										updateReplacementList;
										updateSourceText ] ] ] ]
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
			self
				updateVerbIdentifierField;
				updateObjectIdentifierField;
				updateReplacementList;
				updateActionSourceText;
				updateSourceText ];
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
	actionSourceText := (self
		newSourceWith: RMDGrammar new actionDefinition)
		enabled: false;
		whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		yourself.
	verbIdentifierField := self newSyntaxNodeTextInput
		acceptOnCR: true;
		beIdentifier;
		whenLastValidSyntaxNodeChangedDo: [ self acceptVerbIdentifierField ];
		yourself.
	objectIdentifierField := self newSyntaxNodeTextInput
		acceptOnCR: true;
		beAgentIdentifier;
		allowEmpty;
		whenLastValidSyntaxNodeChangedDo: [ self acceptObjectIdentifierField ];
		yourself.
	replacementList := self newTable
		beSingleSelection;
		beResizable;
		addColumn:
			(SpStringTableColumn
				evaluated:
					[ :item | item actionAgent ifNil: [ 'my' ] ifNotNil: [ :agent | agent , '''s' ] ])
				beNotExpandable;
		addColumn:
			(SpStringTableColumn evaluated: [ :item | item actionProperty ])
				beNotExpandable;
		addColumn:
			((SpImageTableColumn evaluated: [ :item | self replacementIcon ])
				width: 20);
		addColumn:
			((SpStringTableColumn
				evaluated: [ :item | item expression printString ]) width: 200)
				beExpandable;
		whenModelChangedDo: [ replacementList selectItem: nil ];
		whenSelectionChangedDo: [ | selected |
			selected := replacementList selection selectedItem notNil.
			removeReplacementButton enabled: selected.
			editReplacementButton enabled: selected ];
		yourself.
	addReplacementButton := self newButton
		icon: self addIcon;
		action: [ self addReplacement ];
		yourself.
	removeReplacementButton := self newButton
		icon: self removeIcon;
		action: [ self removeReplacement ];
		disable;
		yourself.
	editReplacementButton := self newButton
		icon: self editIcon;
		action: [ self editReplacement ];
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
RMDAgentDefinitionBrowser >> removeReplacement [
	replacementList selection selectedItem
		ifNotNil: [ :bind | 
			taskList selection selectedItem
				ifNotNil: [ :task | 
					task propertyBinds: (task propertyBinds copyWithout: bind).
					self
						updateReplacementList;
						updateSourceText ] ]
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
RMDAgentDefinitionBrowser >> updateActionSourceText [
	simulationModel
		ifNotNil: [ taskList selection selectedItem
				ifNotNil: [ :behaviorDefinition | 
					actionSourceText
						text:
							((behaviorDefinition actionIdentifier resolveWith: simulationModel)
								ifNotNil: #printString
								ifNil: [ '' ]) ] ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateObjectIdentifierField [
	taskList selection selectedItem
		ifNotNil: [ :behaviorDefinition | 
			behaviorDefinition objectIdentifier
				ifNotNil: [ :objectIdentifier | objectIdentifierField text: objectIdentifier ]
				ifNil: [ objectIdentifierField
						enabled: false;
						text: '' ] ]
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
RMDAgentDefinitionBrowser >> updateReplacementList [
	taskList selection selectedItem
		ifNotNil: [ :behaviorDefinition | 
			| font width1 width2 |
			font := TextStyle defaultFont.
			width1 := width2 := 0.
			behaviorDefinition propertyBinds
				do: [ :bind | 
					width1 := width1 max: (font widthOfString: bind actionAgent).
					width2 := width2 max: (font widthOfString: bind actionProperty) ].
			replacementList columns first width: width1 + 40.
			replacementList columns second width: width2 + 20.
			replacementList columns: replacementList columns.
			replacementList items: behaviorDefinition propertyBinds ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateSourceText [
	simulationModel
		ifNotNil: [ taskList selection selectedItem
				ifNotNil: [ :behaviorDefinition | 
					sourceText
						text: (behaviorDefinition actionWith: simulationModel) printString asText ] ]
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

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateVerbIdentifierField [
	taskList selection selectedItem
		ifNotNil:
			[ :behaviorDefinition | verbIdentifierField text: behaviorDefinition verbIdentifier ]
]
