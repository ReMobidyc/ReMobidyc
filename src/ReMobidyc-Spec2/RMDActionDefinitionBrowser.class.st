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
				   add: 'to    ' expand: false;
				   add: #identifierField width: 150;
				   add: '    ' expand: false;
				   add: #objectField width: 150;
				   add: '    is' expand: false;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: '    when ' expand: false;
				   add: #guardField;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: '    with ' expand: false;
				   add: (SpBoxLayout newVertical
						    add: #directivesButton height: self inputTextHeight;
						    yourself);
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: '    ' expand: false;
				   add: (SpBoxLayout newVertical
						    add: #propertyDefinitionList;
						    add: (SpBoxLayout newHorizontal
								     add: #addPropertyButton expand: false;
								     add: #removePropertyButton expand: false;
								     add: #editPropertyButton expand: false;
								     yourself)
						    height: self buttonHeight));
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
						    height: self buttonHeight));
		  yourself
]

{ #category : #operations }
RMDActionDefinitionBrowser >> editDirectives [

	| directives chooser |
	directives := Array
		              with: { 
				              'die'.
				              (node lifeDirectives contains: [ :directive | 
					               directive isDieDirectiveNode ]).
				              [ RMDDieDirective new ] }
		              with: { 
				              'new'.
				              (node lifeDirectives contains: [ :directive | 
					               directive isNewDirectiveNode ]).
				              [ RMDNewDirective new ] }.
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

{ #category : #initialization }
RMDActionDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	identifierField := self newValidatedTextInput
		                   placeholder: 'verb';
		                   validation: [ :text | 
			                   (RMDGrammar new identifier end parse:
					                    text asString trim) isPetit2Failure not ];
		                   autoAccept: true;
		                   whenLastValidTextChangedDo: [ :text | 
			                   node identifier: text asString trim ];
		                   yourself.
	objectField := self newValidatedTextInput
		               placeholder: 'object';
		               validation: [ :text | 
			               (RMDGrammar new agentIdentifier end parse:
					                text asString trim) isPetit2Failure not ];
		               autoAccept: true;
		               whenLastValidTextChangedDo: [ :text | 
			               node identifier: text asString trim ];
		               yourself.
	guardField := self newValidatedTextInput
		              placeholder: 'verb';
		              validation: [ :text | 
			              (RMDGrammar new condition end parse:
					               text asString trim) isPetit2Failure not ];
		              autoAccept: true;
		              whenLastValidTextChangedDo: [ :text | 
			              node guard:
					              (RMDGrammar new condition end parse:
							               text asString trim) ];
		              yourself.
	directivesButton := self newButton
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
		                     yourself
]

{ #category : #initialization }
RMDActionDefinitionBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Action definition'.
	aWindowPresenter initialExtent: 400 @ 500
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
	^ 700
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
