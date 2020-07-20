Class {
	#name : #RMDAnimatDefinitionBrowser,
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
		'replacementList',
		'addReplacementButton',
		'removeReplacementButton',
		'editReplacementButton',
		'sourceText'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAnimatDefinitionBrowser class >> defaultSpec [
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
						position: 0.4;
						add:
							(SpBoxLayout newVertical
								add: 'Behaviors' expand: false;
								add: #behaviorList;
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
RMDAnimatDefinitionBrowser >> animatDefinitionDo: aBlock [
	interpreter ifNil: [ ^ nil ].
	animat ifNil: [ ^ nil ].
	(interpreter animatDefinitionAt: animat ifAbsent: [  ])
		ifNotNil: aBlock
]

{ #category : #initialization }
RMDAnimatDefinitionBrowser >> initializePresenters [
	super initializePresenters.
	propertyList := self newTable
		beSingleSelection;
		beResizable;
		addColumn: (SpStringTableColumn evaluated: [ :item | item identifier ]);
		addColumn: (SpStringTableColumn evaluated: [ :item | item unit ]);
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
RMDAnimatDefinitionBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 600 @ 400
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
	interpreter := aRMDInterpreter.
	visualizer := aRMDVisualizer.
	animat := aString.
	self updatePropertyList.
	self updateRendererList.
	self updateBehaviorList
]

{ #category : #updating }
RMDAnimatDefinitionBrowser >> updateBehaviorList [
	interpreter
		ifNotNil: [ behaviorList
				items:
					(interpreter behaviorDefinitions
						select: [ :behavior | behavior subjectIdentifier = animat ]) ]
]

{ #category : #updating }
RMDAnimatDefinitionBrowser >> updatePropertyList [
	self animatDefinitionDo: [:animatDefinition |
		propertyList items: animatDefinition propertyDeclarations]
]

{ #category : #updating }
RMDAnimatDefinitionBrowser >> updateRendererList [
	rendererList
		items:
			(Array
				streamContents:
					[ :stream | self renderersDo: [ :renderer | stream nextPut: renderer asPresenter ] ])
]

{ #category : #updating }
RMDAnimatDefinitionBrowser >> updateReplacementList [
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
RMDAnimatDefinitionBrowser >> updateSourceText [
	interpreter
		ifNotNil: [ behaviorList selection selectedItem
				ifNotNil:
					[ :behaviorDefinition | sourceText text: (behaviorDefinition actionWith: interpreter) ] ]
]
