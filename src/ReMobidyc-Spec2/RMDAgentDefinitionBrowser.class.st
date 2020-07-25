Class {
	#name : #RMDAgentDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
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
		'behaviorList',
		'addBehaviorButton',
		'removeBehaviorButton',
		'editBehaviorButton',
		'actionSourceText',
		'replacementList',
		'addReplacementButton',
		'removeReplacementButton',
		'editReplacementButton',
		'sourceText'
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
								add: 'Behaviors' expand: false;
								add:
									(SpPanedLayout newHorizontal
										position: 0.3;
										add: #behaviorList;
										add: #actionSourceText);
								add:
									(SpBoxLayout newHorizontal
										add: #addBehaviorButton width: self buttonHeight;
										add: #removeBehaviorButton width: self buttonHeight;
										add: #editBehaviorButton width: self buttonHeight;
										yourself)
									height: self buttonHeight;
								yourself);
						add:
							(SpBoxLayout newVertical
								add: 'Adaptation' expand: false;
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

{ #category : #operations }
RMDAgentDefinitionBrowser >> addBehavior [
	^ self notYetImplemented
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
	^ self notYetImplemented
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
RMDAgentDefinitionBrowser >> editBehavior [
	^ self notYetImplemented
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
	^ self notYetImplemented
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
	behaviorList := self newTable
		beSingleSelection;
		beResizable;
		addColumn: (SpStringTableColumn evaluated: [ :item | item actionIdentifier ]);
		addColumn:
			(SpStringTableColumn
				evaluated: [ :item | item objectIdentifier ifNil: [ '' ] ]);
		whenModelChangedDo: [ behaviorList selectItem: nil ];
		whenSelectionChangedDo: [ | selected |
			selected := behaviorList selection selectedItem notNil.
			removeBehaviorButton enabled: selected.
			editBehaviorButton enabled: selected.
			self
				updateReplacementList;
				updateActionSourceText;
				updateSourceText ];
		yourself.
	addBehaviorButton := self newButton
		icon: self addIcon;
		action: [ self addBehavior ];
		yourself.
	removeBehaviorButton := self newButton
		icon: self removeIcon;
		action: [ self removeBehavior ];
		disable;
		yourself.
	editBehaviorButton := self newButton
		icon: self editIcon;
		action: [ self editBehavior ];
		disable;
		yourself.
	actionSourceText := (self
		newSourceWith: RMDGrammar new actionDefinition)
		enabled: false;
		whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
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
RMDAgentDefinitionBrowser >> removeBehavior [
	^ self notYetImplemented
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
	^ self notYetImplemented
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeReplacement [
	^ self notYetImplemented
]

{ #category : #enumerating }
RMDAgentDefinitionBrowser >> renderersDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #private }
RMDAgentDefinitionBrowser >> setInterpreter: aRMDInterpreter visualizer: aRMDVisualizer [
	interpreter := aRMDInterpreter.
	visualizer := aRMDVisualizer.
	self updatePropertyList.
	self updateRendererList.
	self updateBehaviorList
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateActionSourceText [
	interpreter
		ifNotNil: [ behaviorList selection selectedItem
				ifNotNil: [ :behaviorDefinition | 
					actionSourceText
						text:
							((interpreter
								actionDefinitionAt: behaviorDefinition actionIdentifier
								ifAbsent: [ nil ]) ifNotNil: #printString ifNil: [ '' ]) ] ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateBehaviorList [
	interpreter
		ifNotNil: [ behaviorList
				items:
					(interpreter behaviorDefinitions
						select: [ :behavior | behavior subjectIdentifier = self agentName ]) ]
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
								yourself ] ])
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateReplacementList [
	behaviorList selection selectedItem
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
	interpreter
		ifNotNil: [ behaviorList selection selectedItem
				ifNotNil:
					[ :behaviorDefinition | sourceText text: (behaviorDefinition actionWith: interpreter) ] ]
]
