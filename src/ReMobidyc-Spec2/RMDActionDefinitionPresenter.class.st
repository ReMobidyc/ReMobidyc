Class {
	#name : #RMDActionDefinitionPresenter,
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
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDActionDefinitionPresenter class >> defaultSpec [

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

{ #category : #initialization }
RMDActionDefinitionPresenter >> initializePresenters [

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
			              node guard: (text asString trim ifEmpty: [ nil ]) ];
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
RMDActionDefinitionPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Action definition'.
	aWindowPresenter initialExtent: 400 @ 500
]

{ #category : #accessing }
RMDActionDefinitionPresenter >> nodeChanged [

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
RMDActionDefinitionPresenter >> preferredHeight [
	^ 700
]

{ #category : #updating }
RMDActionDefinitionPresenter >> updatePropertyButtons [

	| hasSelection |
	hasSelection := propertyDefinitionList selectedItem notNil.
	removePropertyButton enabled: hasSelection.
	editPropertyButton enabled: hasSelection
]

{ #category : #updating }
RMDActionDefinitionPresenter >> updateUtilityButtons [

	| hasSelection |
	hasSelection := utilityDefinitionList selectedItem notNil.
	removeUtilityButton enabled: hasSelection.
	editUtilityButton enabled: hasSelection
]
