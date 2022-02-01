Class {
	#name : #RMDAttributeDefinitionBrowser,
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
RMDAttributeDefinitionBrowser class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: #agentList width: 100;
				   add: #modifierList width: 50;
				   add: #identifierField width: 150;
				   add: ''' = ' expand: false;
				   add: #definitionBodyField expand: true;
				   yourself)
		  height: self buttonHeight
]

{ #category : #examples }
RMDAttributeDefinitionBrowser class >> example1 [

	| browser |
	(browser := self on:
		            (RMDGrammar new attributeDefinition end parse:
			             'my delta x'' = 10 [m]')) openDialogWithSpec 
		okAction: [ browser node inspect ]
]

{ #category : #private }
RMDAttributeDefinitionBrowser >> agentChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].
	self selectedAssignableVariableNode ifNotNil: [ :v | 
		node variable: v ]
]

{ #category : #private }
RMDAttributeDefinitionBrowser >> definitionBodyChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	definitionBodyField syntaxNode ifNotNil: [ :expression | 
		node definitionBody: expression ]
]

{ #category : #private }
RMDAttributeDefinitionBrowser >> identifierChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	self selectedAssignableVariableNode ifNotNil: [ :v | 
		node variable: v ]
]

{ #category : #initialization }
RMDAttributeDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	agentList := self newDropList
		             items: self possibleAgents;
		             display: [ :assoc | assoc key ];
		             whenSelectedItemChangedDo: [ self agentChanged ];
		             yourself.
	modifierList := self newDropList
		                items: { 
				                ('' -> [ :agent :identifier | 
					                 RMDAssignableAttributeVariableNode
						                 identifier: identifier
						                 agent: agent ]).

				                ('Δ' -> [ :agent :identifier | 
					                 RMDAssignableDeltaAttributeVariableNode
						                 identifier: identifier
						                 agent: agent ]).

				                ('d/dt' -> [ :agent :identifier | 
					                 RMDAssignableDifferentialAttributeVariableNode
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
RMDAttributeDefinitionBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Attribute definition'.
	aWindowPresenter initialExtent:
		600 @ (self preferredHeight + self class buttonHeight * 3)
]

{ #category : #private }
RMDAttributeDefinitionBrowser >> modifierChanged [

	node ifNil: [ ^ self ].
	self isAfterNodeChanged ifTrue: [ ^ self ].

	self selectedAssignableVariableNode ifNotNil: [ :v | 
		node variable: v ]
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> nodeChanged [

	node ifNil: [ ^ self ].
	agentList selectIndex: (agentList listItems findFirst: [ :assoc | 
			 assoc value = (node variable agent ifNil: [ #my ]) ]).
	node variable isAssignableAttributeVariableNode ifTrue: [ 
		modifierList selectIndex: 1 ].
	node variable isAssignableDeltaVariableNode ifTrue: [ 
		modifierList selectIndex: 2 ].
	node variable isAssignableDifferentialAttributeVariableNode ifTrue: [ 
		modifierList selectIndex: 3 ].
	identifierField text: node variable identifier.
	node definitionBody ifNotNil: [ :expression | 
		definitionBodyField syntaxNode: expression ]
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> objectAgent [
	^ objectAgent
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> objectAgent: aString [

	objectAgent := aString
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> possibleAgents [

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
RMDAttributeDefinitionBrowser >> preferredHeight [

	^ self class buttonHeight
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> selectedAgent [

	^ agentList selectedItem ifNotNil: #value
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> selectedAssignableVariableNode [

	self selectedAgent ifNotNil: [ :agent | 
		self selectedModifierBlock ifNotNil: [ :modifierBlock | 
			self selectedIdentifier ifNotNil: [ :identifier | 
				^ modifierBlock value: agent value: identifier ] ] ].
	^ nil
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> selectedIdentifier [

	^ identifierField syntaxNode
]

{ #category : #accessing }
RMDAttributeDefinitionBrowser >> selectedModifierBlock [

	^ modifierList selectedItem ifNotNil: #value
]
