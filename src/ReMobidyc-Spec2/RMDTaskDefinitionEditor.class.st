Class {
	#name : #RMDTaskDefinitionEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'agentName',
		'repositoryList',
		'actionList',
		'templateText',
		'addRepositoryButton',
		'removeRepositoryButton',
		'editRepositoryButton',
		'verbIdentifierField',
		'objectIdentifierField',
		'replacementList',
		'addReplacementButton',
		'removeReplacementButton',
		'editReplacementButton',
		'sourceText',
		'taskDefinitionNode'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDTaskDefinitionEditor class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.5;
		add:
			(SpPanedLayout newHorizontal
				position: 0.6;
				add:
					(SpPanedLayout newHorizontal
						position: 0.4;
						add:
							(SpBoxLayout newVertical
								add: 'Repositories' expand: false;
								add: #repositoryList;
								add:
									(SpBoxLayout newHorizontal
										add: #addRepositoryButton width: self buttonHeight;
										add: #removeRepositoryButton width: self buttonHeight;
										add: #editRepositoryButton width: self buttonHeight;
										yourself)
									height: self buttonHeight;
								yourself);
						add:
							(SpBoxLayout newVertical
								add: 'Actions' expand: false;
								add: #actionList;
								yourself);
						yourself);
				add:
					(SpBoxLayout newVertical
						add: 'Template' expand: false;
						add: #templateText;
						yourself));
		add:
			(SpBoxLayout newVertical
				add: 'Task Specialization' expand: false;
				add:
					(SpPanedLayout newHorizontal
						position: 0.4;
						add:
							(SpBoxLayout newVertical
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
						add: #sourceText;
						yourself));
		yourself
]

{ #category : #'instance creation' }
RMDTaskDefinitionEditor class >> on: aRMDSimulationModel [
	^ self new
		simulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #'instance creation' }
RMDTaskDefinitionEditor class >> withoutInterpreter [
	^ self new
]

{ #category : #operations }
RMDTaskDefinitionEditor >> acceptObjectIdentifierField [
	self taskDefinition
		ifNotNil: [ :task | 
			| newObjectIdentifier |
			newObjectIdentifier := objectIdentifierField lastValidSyntaxNode
				ifEmpty: [ nil ].
			task objectIdentifier: newObjectIdentifier.
			self updateSourceText ]
]

{ #category : #operations }
RMDTaskDefinitionEditor >> acceptVerbIdentifierField [
	self taskDefinition
		ifNotNil: [ :task | 
			| newVerb |
			newVerb := verbIdentifierField lastValidSyntaxNode.
			task
				verbIdentifier: newVerb;
				resetAction.
			self updateSourceText ]
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> actionDefinition [
	^ self actionIdentifier
		ifNotNil: [ :actionIdentifier | 
			self simulationModel
				ifNotNil: [ :model | actionIdentifier resolveWith: simulationModel ] ]
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> actionIdentifier [ 
	^ actionList selection selectedItem
]

{ #category : #operations }
RMDTaskDefinitionEditor >> addReplacement [
	self taskDefinition
		ifNotNil: [ :taskDefinition | 
			| bindEditor |
			(bindEditor := RMDPropertyBindEditor
				actionDefinition: (taskDefinition actionIdentifier resolveWith: simulationModel)
				except:
					(taskDefinition propertyBinds
						collect: [ :bind | 
							RMDPropertyVariableNode
								identifier: bind actionProperty
								agent: bind actionAgent ])) openDialogWithSpec
				okAction: [ bindEditor propertyBindNode
						ifNotNil: [ :bindNode | 
							taskDefinition
								propertyBinds: (taskDefinition propertyBinds copyWith: bindNode).
							self
								updateReplacementList;
								updateSourceText ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionEditor >> addRepository [
	^ self notYetImplemented
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> agentName [
	^ agentName
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> agentName: aString [
	agentName := aString
]

{ #category : #operations }
RMDTaskDefinitionEditor >> editReplacement [
	replacementList selection selectedItem
		ifNotNil: [ :oldBind | 
			self taskDefinition
				ifNotNil: [ :taskModel | 
					| bindEditor |
					bindEditor := RMDPropertyBindEditor
						actionDefinition: (taskModel actionIdentifier resolveWith: simulationModel)
						except:
							(taskModel propertyBinds
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
									index := taskModel propertyBinds indexOf: oldBind.
									index > 0
										ifTrue: [ taskModel propertyBinds at: index put: newBind.
											taskModel resetAction ]
										ifFalse: [ taskModel propertyBinds: (taskModel propertyBinds copyWith: newBind) ].
									self
										updateReplacementList;
										updateSourceText ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionEditor >> editRepository [
	^ self notYetImplemented
]

{ #category : #initialization }
RMDTaskDefinitionEditor >> initializePresenters [
	super initializePresenters.
	repositoryList := self newList
		beSingleSelection;
		whenModelChangedDo: [ repositoryList selectItem: nil ];
		whenSelectionChangedDo: [ self updateActionList ];
		display: [ :item | item repositoryName ];
		yourself.
	addRepositoryButton := self newButton
		icon: self addIcon;
		action: [ self addRepository ];
		yourself.
	removeRepositoryButton := self newButton
		icon: self removeIcon;
		action: [ self removeRepository ];
		disable;
		yourself.
	editRepositoryButton := self newButton
		icon: self editIcon;
		action: [ self editRepository ];
		disable;
		yourself.
	actionList := self newTable
		beSingleSelection;
		beResizable;
		showColumnHeaders;
		addColumn:
			(SpStringTableColumn
				title: 'verb'
				evaluated: [ :item | (item resolveWith: simulationModel) identifier ]);
		addColumn:
			(SpStringTableColumn
				title: 'object'
				evaluated: [ :item | (item resolveWith: simulationModel) object ifNil: [ '' ] ]);
		whenModelChangedDo: [ actionList selectItem: nil ];
		whenSelectionChangedDo: [ self updateTaskDefinition.
			self taskDefinition
				ifNotNil: [ :taskDefinition | 
					self actionIdentifier
						ifNotNil: [ :actionIdentifier | 
							self updateVerbIdentifierField.
							self updateObjectIdentifierField ].
					self
						updateTemplateText;
						updateReplacementList;
						updateSourceText ] ];
		yourself.
	templateText := (self newSourceWith: RMDGrammar new actionDefinition)
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
				evaluated: [ :item | 
					| agent actionDefinition |
					agent := (item actionAgent
						ifNil: [ 'my' ]
						ifNotNil: [ :name | name , '''s' ]) asText.
					actionDefinition := self actionDefinition.
					(actionDefinition isNil
						or: [ (actionDefinition
								includesNode:
									(RMDPropertyVariableNode
										identifier: item actionProperty
										agent: item actionAgent)) not ])
						ifTrue: [ agent makeAllColor: Color red ].
					agent ]) beNotExpandable;
		addColumn:
			(SpStringTableColumn
				evaluated: [ :item | 
					| actionProperty actionDefinition |
					actionProperty := item actionProperty asText.
					actionDefinition := self actionDefinition.
					(actionDefinition isNil
						or: [ (actionDefinition
								includesNode:
									(RMDPropertyVariableNode
										identifier: item actionProperty
										agent: item actionAgent)) not ])
						ifTrue: [ actionProperty makeAllColor: Color red ].
					actionProperty ]) beNotExpandable;
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
		yourself.
	self updateRepositoryList
]

{ #category : #initialization }
RMDTaskDefinitionEditor >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Task definition'.
	aWindowPresenter initialExtent: 800 @ 600
]

{ #category : #operations }
RMDTaskDefinitionEditor >> removeReplacement [
	replacementList selection selectedItem
		ifNotNil: [ :bind | 
			self taskDefinition
				ifNotNil: [ :task | 
					task propertyBinds: (task propertyBinds copyWithout: bind).
					self
						updateReplacementList;
						updateSourceText ] ]
]

{ #category : #operations }
RMDTaskDefinitionEditor >> removeRepository [
	^ self notYetImplemented
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> repositories [
	^ Array
		streamContents: [ :stream | 
			stream nextPut: RMDBuiltinRepository current.
			simulationModel
				ifNotNil: [ stream nextPut: (RMDModelRepository on: simulationModel) ] ]
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> repository [
	^ repositoryList selection selectedItem
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> simulationModel [
	^ simulationModel
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel.
	self updateRepositoryList
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> taskDefinition [
	^ taskDefinitionNode
]

{ #category : #accessing }
RMDTaskDefinitionEditor >> taskDefinition: aRMDTaskDefinitionNode [
	taskDefinitionNode := aRMDTaskDefinitionNode.
	self taskDefinitionChanged
]

{ #category : #updating }
RMDTaskDefinitionEditor >> taskDefinitionChanged [
	taskDefinitionNode
		ifNotNil: [ taskDefinitionNode actionIdentifier
				ifNotNil: [ :actionIdentifier | 
					actionIdentifier selectRepositoryList: repositoryList.
					actionList
						selectItem:
							(actionList items
								detect: [ :action | actionIdentifier = action ]
								ifNone: [ nil ]) ]
				ifNil: [ repositoryList selectItem: nil ] ]
		ifNil: [ repositoryList selectItem: nil ].
	self updateReplacementList.

]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateActionList [
	actionList
		items:
			(self repository
				ifNotNil: [ :repository | repository actionIdentifiers ]
				ifNil: [ #() ])
]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateObjectIdentifierField [
	objectIdentifierField text asString trim
		ifEmpty: [ self taskDefinition
				ifNotNil: [ :taskDefinition | 
					taskDefinition objectIdentifier
						ifNotNil: [ :objectIdentifier | objectIdentifierField text: objectIdentifier ]
						ifNil: [ objectIdentifierField
								enabled: false;
								text: '' ] ] ]
]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateReplacementList [
	| font width1 width2 |
	self taskDefinition
		ifNotNil: [ :taskDefinition | 
			font := TextStyle defaultFont.
			width1 := width2 := 0.
			taskDefinition propertyBinds
				do: [ :bind | 
					width1 := width1 max: (font widthOfString: bind actionAgent).
					width2 := width2 max: (font widthOfString: bind actionProperty) ].
			replacementList columns first width: width1 + 40.
			replacementList columns second width: width2 + 20.
			replacementList columns: replacementList columns.
			replacementList items: taskDefinition propertyBinds ]
]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateRepositoryList [
	repositoryList items: self repositories
]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateSourceText [
	simulationModel
		ifNotNil: [ self taskDefinition
				ifNotNil: [ :taskDefinition | 
					sourceText
						text: (taskDefinition actionWith: simulationModel) printString asText ] ]
]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateTaskDefinition [
	self actionIdentifier
		ifNotNil: [ :actionIdentifier | 
			self taskDefinition
				ifNil: [ self
						taskDefinition:
							(RMDTaskDefinitionNode
								subjectIdentifier: self agentName
								verbIdentifier:
									(verbIdentifierField text asString trim
										ifEmpty: [ actionIdentifier shortName ])
								objectIdentifier: (objectIdentifierField text asString trim ifEmpty: [ nil ])
								actionIdentifier: actionIdentifier
								within: nil
								propertyBinds: Array new) ]
				ifNotNil:
					[ :taskDefinition | taskDefinition actionIdentifier: actionIdentifier ] ]
]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateTemplateText [
	self actionIdentifier
		ifNotNil: [ :actionIdentifier | 
			templateText
				syntaxNode: (actionIdentifier resolveWith: simulationModel);
				enabled: actionIdentifier isReadOnly not ]
		ifNil: [ templateText
				text: '';
				enabled: false ]
]

{ #category : #updating }
RMDTaskDefinitionEditor >> updateVerbIdentifierField [
	objectIdentifierField text asString trim
		ifEmpty: [ self taskDefinition
				ifNotNil: [ :taskDefinition | 
					verbIdentifierField
						text: (taskDefinition verbIdentifier ifNil: [ String new ]) ] ]
]
