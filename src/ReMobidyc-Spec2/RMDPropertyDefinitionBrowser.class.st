Class {
	#name : #RMDPropertyDefinitionBrowser,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'objectAgent',
		'agentList',
		'modifierList',
		'identifierField',
		'definitionBodyField'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDPropertyDefinitionBrowser class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #agentList width: 100;
				   add: #modifierList width: 50;
				   add: #identifierField width: 150;
				   add: ''' = ' expand: false;
				   add: #definitionBodyField expand: true;
				   yourself)
		  height: self buttonHeight
]

{ #category : #examples }
RMDPropertyDefinitionBrowser class >> example1 [

	| browser |
	(browser := self on:
		            (RMDGrammar new propertyDefinition end parse:
			             'my delta x'' = 10 [m]')) openDialogWithSpec 
		okAction: [ browser node inspect ]
]

{ #category : #private }
RMDPropertyDefinitionBrowser >> agentChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].
	self selectedAssignableVariableNode ifNotNil: [ :v | 
		node variable: v ]
]

{ #category : #private }
RMDPropertyDefinitionBrowser >> definitionBodyChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	definitionBodyField syntaxNode ifNotNil: [ :expression | 
		node definitionBody: expression ]
]

{ #category : #private }
RMDPropertyDefinitionBrowser >> identifierChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	self selectedAssignableVariableNode ifNotNil: [ :v | 
		node variable: v ]
]

{ #category : #initialization }
RMDPropertyDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	agentList := self newDropList
		             items: self possibleAgents;
		             display: [ :assoc | assoc key ];
		             whenSelectedItemChangedDo: [ self agentChanged ];
		             yourself.
	modifierList := self newDropList
		                items: { 
				                ('' -> [ :agent :identifier | 
					                 RMDAssignablePropertyVariableNode
						                 identifier: identifier
						                 agent: agent ]).

				                ('Δ' -> [ :agent :identifier | 
					                 RMDAssignableDeltaPropertyVariableNode
						                 identifier: identifier
						                 agent: agent ]).

				                ('d/dt' -> [ :agent :identifier | 
					                 RMDAssignableDifferentialPropertyVariableNode
						                 identifier: identifier
						                 agent: agent ]) };
		                display: [ :assoc | assoc key ];
		                whenSelectedItemChangedDo: [ self modifierChanged ];
		                yourself.
	identifierField := self newSyntaxNodeTextInput
		                   parser: RMDGrammar new identifier end;
		                   whenLastValidSyntaxNodeChangedDo: [ 
			                   self identifierChanged ];
		                   yourself.
	definitionBodyField := self newSyntaxNodeTextInput
		                       beExpression;
		                       whenLastValidSyntaxNodeChangedDo: [ 
			                       self definitionBodyChanged ];
		                       yourself
]

{ #category : #initialization }
RMDPropertyDefinitionBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Property definition'.
	aWindowPresenter initialExtent: 600 @ self preferredHeight
]

{ #category : #private }
RMDPropertyDefinitionBrowser >> modifierChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	self selectedAssignableVariableNode ifNotNil: [ :v | 
		node variable: v ]
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> nodeChanged [

	node ifNil: [ ^ self ].
	agentList selectIndex: (agentList listItems findFirst: [ :assoc | 
			 assoc value = (node variable agent ifNil: [ #my ]) ]).
	node variable isAssignablePropertyVariableNode ifTrue: [ 
		modifierList selectIndex: 1 ].
	node variable isAssignableDeltaVariableNode ifTrue: [ 
		modifierList selectIndex: 2 ].
	node variable isAssignableDifferentialPropertyVariableNode ifTrue: [ 
		modifierList selectIndex: 3 ].
	identifierField text: node variable identifier.
	definitionBodyField syntaxNode: node definitionBody
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> objectAgent [
	^ objectAgent
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> objectAgent: aString [

	objectAgent := aString
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> possibleAgents [

	^ Array streamContents: [ :stream | 
		  stream nextPut: 'my' -> #my.
		  objectAgent ifNotNil: [ 
			  stream nextPut: objectAgent , '''s' -> objectAgent ].
		  stream
			  nextPut: 'here''s' -> 'here';
			  nextPut: 'the' -> #the;
			  nextPut: 'new' -> #new ]
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> preferredHeight [

	^ self class buttonHeight * 4
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> selectedAgent [

	^ agentList selectedItem ifNotNil: #value
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> selectedAssignableVariableNode [

	self selectedAgent ifNotNil: [ :agent | 
		self selectedModifierBlock ifNotNil: [ :modifierBlock | 
			self selectedIdentifier ifNotNil: [ :identifier | 
				^ modifierBlock value: agent value: identifier ] ] ].
	^ nil
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> selectedIdentifier [

	^ identifierField syntaxNode
]

{ #category : #accessing }
RMDPropertyDefinitionBrowser >> selectedModifierBlock [

	^ modifierList selectedItem ifNotNil: #value
]
