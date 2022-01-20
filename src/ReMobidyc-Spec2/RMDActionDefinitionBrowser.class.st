Class {
	#name : #RMDActionDefinitionBrowser,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'identifierField',
		'objectField',
		'guardField',
		'directivesButton',
		'propertyDefinitionList',
		'utilityDefinitionList',
		'addPropertyButton',
		'removePropertyButton',
		'editPropertyButton',
		'addUtilityButton',
		'removeUtilityButton',
		'editUtilityButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDActionDefinitionBrowser class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: ' To    ' expand: false;
				   add: #identifierField width: 150;
				   add: '    ' expand: false;
				   add: #objectField width: 150;
				   add: '    is' expand: false;
				   yourself)
		  expand: false
		  fill: true
		  padding: 10;
		  add: (SpBoxLayout newHorizontal
				   add: '    when ' expand: false;
				   add: #guardField;
				   yourself)
		  expand: false
		  fill: true
		  padding: 10;
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: '    with ' expand: false;
				   add: (SpBoxLayout newVertical
						    add: #directivesButton height: self inputTextHeight;
						    yourself)
				   width: 150;
				   yourself)
		  expand: false
		  fill: true
		  padding: 10;
		  add: (SpBoxLayout newHorizontal
				   add: '    ' expand: false;
				   add: (SpBoxLayout newVertical
						    add: #propertyDefinitionList;
						    add: (SpBoxLayout newHorizontal
								     add: #addPropertyButton expand: false;
								     add: #removePropertyButton expand: false;
								     add: #editPropertyButton expand: false;
								     yourself)
						    height: self inputTextHeight))
		  expand: true
		  fill: true
		  padding: 10;
		  add: 'where' expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: '    ' expand: false;
				   add: (SpBoxLayout newVertical
						    add: #utilityDefinitionList;
						    add: (SpBoxLayout newHorizontal
								     add: #addUtilityButton expand: false;
								     add: #removeUtilityButton expand: false;
								     add: #editUtilityButton expand: false;
								     yourself)
						    height: self inputTextHeight))
		  expand: true
		  fill: true
		  padding: 10;
		  yourself
]

{ #category : #operations }
RMDActionDefinitionBrowser >> addPropertyDefinition [

	| newDefinition |
	newDefinition := RMDPropertyDefinitionNode template.
	newDefinition asPresenter openDialogWithSpec okAction: [ 
		node propertyDefinitions:
			(node propertyDefinitions copyWith: newDefinition).
		self nodeChanged ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> addUtilityDefinition [

	| newDefinition |
	newDefinition := RMDUtilityDefinitionNode template.
	newDefinition asPresenter openDialogWithSpec okAction: [ 
		node utilityDefinitions:
			(node utilityDefinitions copyWith: newDefinition).
		self nodeChanged ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> editDirectives [

	| directives chooser |
	directives := Array
		              with: { 
				              'die'.
				              (node lifeDirectives contains: [ :directive | 
					               directive isDieDirectiveNode ]).
				              [ RMDDieDirectiveNode new ] }
		              with: { 
				              'kill'.
				              (node lifeDirectives contains: [ :directive | 
					               directive isKillDirectiveNode ]).
				              [ RMDKillDirectiveNode new ] }
		              with: { 
				              'new'.
				              (node lifeDirectives contains: [ :directive | 
					               directive isNewDirectiveNode ]).
				              [ 
				              RMDNewDirectiveNode new
					              animatIdentifier:
						              self requestAnimatIdentifierForNewDirective;
					              yourself ] }
		              with: { 
				              'stage'.
				              (node lifeDirectives contains: [ :directive | 
					               directive isStageDirectiveNode ]).
				              [ 
				              RMDNewDirectiveNode new
					              animatIdentifier:
						              self requestAnimatIdentifierForStageDirective;
					              yourself ] }.
	chooser := self newTable
		           items: directives;
		           addColumn:
			           ((SpCheckBoxTableColumn evaluated: [ :pair | 
					             pair second ])
				            onActivation: [ :pair | pair at: 2 put: true ];
				            onDeactivation: [ :pair | pair at: 2 put: false ];
				            beNotExpandable;
				            yourself);
		           addColumn:
			           ((SpStringTableColumn evaluated: [ :pair | pair first ])
				            beNotEditable;
				            yourself).
	chooser openDialogWithSpec okAction: [ 
		node lifeDirectives: (directives
				 select: #second
				 thenCollect: [ :triple | triple third value ]).
		self nodeChanged ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> editPropertyDefinition [

	propertyDefinitionList selectedItem ifNotNil: [ :oldDefinition | 
		| newDefinition index |
		newDefinition := oldDefinition copy.
		newDefinition asPresenter openDialogWithSpec okAction: [ 
			node propertyDefinitions
				at: (index := node propertyDefinitions indexOf: oldDefinition)
				put: newDefinition.
			self nodeChanged.
			propertyDefinitionList selectIndex: index ] ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> editUtilityDefinition [

	utilityDefinitionList selectedItem ifNotNil: [ :oldDefinition | 
		| newDefinition index |
		newDefinition := oldDefinition copy.
		newDefinition asPresenter openDialogWithSpec okAction: [ 
			node utilityDefinitions
				at: (index := node utilityDefinitions indexOf: oldDefinition)
				put: newDefinition.
			self nodeChanged.
			utilityDefinitionList selectIndex: index ] ]
]

{ #category : #initialization }
RMDActionDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	identifierField := self newSyntaxNodeTextInput
		                   parser: RMDGrammar new identifier end;
		                   placeholder: 'verb';
		                   autoAccept: true;
		                   whenLastValidSyntaxNodeChangedDo: [ :identifier | 
			                   node identifier: identifier ];
		                   yourself.
	objectField := self newSyntaxNodeTextInput
		               parser: RMDGrammar new agentIdentifier optional trimBlanks end;
		               placeholder: '(object)';
		               autoAccept: true;
		               whenLastValidSyntaxNodeChangedDo: [ :animat | 
			               node object: animat ];
		               yourself.
	guardField := self newSyntaxNodeTextInput
		              parser: RMDGrammar new condition optional trimBlanks end;
		              placeholder: 'guard condition';
		              autoAccept: true;
		              whenLastValidSyntaxNodeChangedDo: [ :guard | 
			              node guard: guard ];
		              yourself.
	directivesButton := self newButton
		                    color: Color white;
		                    label: 'no directive';
		                    action: [ self editDirectives ];
		                    yourself.
	propertyDefinitionList := self newList
		                          display: [ :propertyDef | 
			                          propertyDef printString ];
		                          whenSelectionChangedDo: [ 
			                          self updatePropertyButtons ];
		                          yourself.
	addPropertyButton := self newButton
		                     label: '';
		                     icon: Smalltalk ui icons add;
		                     action: [ self addPropertyDefinition ];
		                     yourself.
	removePropertyButton := self newButton
		                        label: '';
		                        icon: Smalltalk ui icons remove;
		                        action: [ self removePropertyDefinition ];
		                        disable;
		                        yourself.
	editPropertyButton := self newButton
		                      label: '';
		                      icon: Smalltalk ui icons edit;
		                      action: [ self editPropertyDefinition ];
		                      disable;
		                      yourself.
	utilityDefinitionList := self newList
		                         display: [ :utilityDef | 
			                         utilityDef printString ];
		                         whenSelectionChangedDo: [ 
			                         self updateUtilityButtons ];
		                         yourself.
	addUtilityButton := self newButton
		                    label: '';
		                    icon: Smalltalk ui icons add;
		                    action: [ self addUtilityDefinition ];
		                    yourself.
	removeUtilityButton := self newButton
		                       label: '';
		                       icon: Smalltalk ui icons remove;
		                       action: [ self removeUtilityDefinition ];
		                       disable;
		                       yourself.
	editUtilityButton := self newButton
		                     label: '';
		                     icon: Smalltalk ui icons edit;
		                     action: [ self editUtilityDefinition ];
		                     disable;
		                     yourself.
	self whenBuiltDo: [ 
		self withWidgetDo: [ :w | 
			w
				update: #color: with: { Color white };
				update: #borderColor: with: { Color darkGray };
				update: #borderWidth: with: { 1 } ] ]
]

{ #category : #initialization }
RMDActionDefinitionBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Action definition'.
	aWindowPresenter initialExtent: 400 @ self preferredHeight
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> nodeChanged [

	node ifNil: [ ^ self ].
	identifierField text: node identifier.
	objectField text: (node object ifNil: [ '' ]).
	guardField text: (node guard ifNotNil: #printString ifNil: [ '' ]).
	directivesButton label:
		((', ' join: (node lifeDirectives collect: #printString)) ifEmpty: [ 
			 'no directives' ]).
	propertyDefinitionList
		items: node propertyDefinitions;
		unselectAll.
	utilityDefinitionList
		items: node utilityDefinitions;
		unselectAll
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> preferredHeight [
	^ 600
]

{ #category : #operations }
RMDActionDefinitionBrowser >> removePropertyDefinition [

	propertyDefinitionList selectedItem ifNotNil: [ :oldDefinition | 
		(UIManager default confirm:
			 'Sure to remove `' , oldDefinition printString , '''?') ifTrue: [ 
			node propertyDefinitions:
				(node propertyDefinitions copyWithout: oldDefinition).
			self nodeChanged ] ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> removeUtilityDefinition [

	utilityDefinitionList selectedItem ifNotNil: [ :oldDefinition | 
		(UIManager default confirm:
			 'Sure to remove `' , oldDefinition printString , '''?') ifTrue: [ 
			node utilityDefinitions:
				(node utilityDefinitions copyWithout: oldDefinition).
			self nodeChanged ] ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> requestAnimatIdentifierForNewDirective [

	^ ((UIManager default
		    request: 'Animat (blank if not yet decided)'
		    initialAnswer: ((node lifeDirectives
				      detect: [ :directive | directive isNewDirectiveNode ]
				      ifNone: [ nil ])
				     ifNotNil: [ :directive | directive animatIdentifier ]
				     ifNil: [ '-' ])) ifNil: [ '-' ]) trim ifEmpty: [ '-' ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> requestAnimatIdentifierForStageDirective [

	^ (UIManager default
		   request: 'Animat'
		   initialAnswer: ((node lifeDirectives
				     detect: [ :directive | directive isStageDirectiveNode ]
				     ifNone: [ nil ])
				    ifNotNil: [ :directive | directive animatIdentifier ]
				    ifNil: [ '-' ])) ifNotNil: [ :name | 
		  name trim ifEmpty: [ nil ] ]
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updatePropertyButtons [

	| hasSelection |
	hasSelection := propertyDefinitionList selectedItem notNil.
	removePropertyButton enabled: hasSelection.
	editPropertyButton enabled: hasSelection
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updateUtilityButtons [

	| hasSelection |
	hasSelection := utilityDefinitionList selectedItem notNil.
	removeUtilityButton enabled: hasSelection.
	editUtilityButton enabled: hasSelection
]
