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
	#category : #'ReMobidyc-Spec2-Editors'
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

{ #category : #accessing }
RMDAgentDefinitionBrowser >> agentName [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAgentDefinitionBrowser >> definitionDo: aBlock [
	^ self subclassResponsibility
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
		addColumn: (SpStringTableColumn title: 'unit' evaluated: [ :item | item unit ]);
		yourself.
	addPropertyButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallAdd);
		yourself.
	removePropertyButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallDelete);
		yourself.
	editPropertyButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallConfiguration);
		yourself.
	rendererList := self newComponentList
		beSingleSelection;
		yourself.
	addRendererButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallAdd);
		yourself.
	removeRendererButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallDelete);
		yourself.
	editRendererButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallConfiguration);
		yourself.
	behaviorList := self newTable
		beSingleSelection;
		beResizable;
		addColumn: (SpStringTableColumn evaluated: [ :item | item actionIdentifier ]);
		addColumn:
			(SpStringTableColumn
				evaluated: [ :item | item objectIdentifier ifNil: [ '' ] ]);
		whenSelectionChangedDo: [ :selection | 
			self
				updateReplacementList;
				updateActionSourceText;
				updateSourceText ];
		yourself.
	addBehaviorButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallAdd);
		yourself.
	removeBehaviorButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallDelete);
		yourself.
	editBehaviorButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallConfiguration);
		yourself.
	actionSourceText := (self newSourceWith: RMDGrammar new actionDefinition)
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
			((SpImageTableColumn
				evaluated: [ :item | Smalltalk ui icons iconNamed: #smallForward ])
				width: 20);
		addColumn:
			((SpStringTableColumn
				evaluated: [ :item | item expression printString ]) width: 200)
				beExpandable;
		yourself.
	addReplacementButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallAdd);
		yourself.
	removeReplacementButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallDelete);
		yourself.
	editReplacementButton := self newButton
		icon: (Smalltalk ui icons iconNamed: #smallConfiguration);
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
								nextPut: renderer asPresenter disableAgentFields;
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
