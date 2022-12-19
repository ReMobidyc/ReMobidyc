Class {
	#name : #RMDActionDefinitionBrowser,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'identifierField',
		'objectField',
		'guardField',
		'directivesButton',
		'utilityDefinitionList',
		'addUtilityButton',
		'removeUtilityButton',
		'moveUpUtilityButton',
		'moveDownUtilityButton',
		'editUtilityButton',
		'attributeDefinitionList',
		'addAttributeButton',
		'moveUpAttributeButton',
		'moveDownAttributeButton',
		'editAttributeButton',
		'removeAttributeButton',
		'subjectAgent'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDActionDefinitionBrowser class >> defaultLayout [

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
				   expand: true;
				   yourself)
		  expand: false
		  fill: true
		  padding: 10;
		  add: (SpBoxLayout newHorizontal
				   add: '    ' expand: false;
				   add: (SpBoxLayout newVertical
						    add: #attributeDefinitionList;
						    add: (SpBoxLayout newHorizontal
								     add: #addAttributeButton expand: false;
								     add: #removeAttributeButton expand: false;
								     add: #moveUpAttributeButton expand: false;
								     add: #moveDownAttributeButton expand: false;
								     add: #editAttributeButton expand: false;
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
								     add: #moveUpUtilityButton expand: false;
								     add: #moveDownUtilityButton expand: false;
								     add: #editUtilityButton expand: false;
								     yourself)
						    height: self inputTextHeight))
		  expand: true
		  fill: true
		  padding: 10;
		  yourself
]

{ #category : #operations }
RMDActionDefinitionBrowser >> addAttributeDefinition [

	| newDefinition |
	newDefinition := RMDAttributeDefinitionNode template.
	(newDefinition asPresenter
		 simulationModel: self simulationModel;
		 subjectAgent: subjectAgent;
		 objectAgent: node objectIdentifier;
		 yourself) openDialog okAction: [ 
		node attributeDefinitions:
			(node attributeDefinitions copyWith: newDefinition).
		self nodeChanged ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> addUtilityDefinition [

	| newDefinition |
	newDefinition := RMDUtilityDefinitionNode template.
	newDefinition asPresenter openDialog okAction: [ 
		node utilityDefinitions:
			(node utilityDefinitions copyWith: newDefinition).
		self nodeChanged ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> editAttributeDefinition [

	attributeDefinitionList selectedItem ifNotNil: [ :oldDefinition | 
		| newDefinition index |
		newDefinition := oldDefinition copy.
		(newDefinition asPresenter
			 simulationModel: self simulationModel;
			 subjectAgent: subjectAgent;
			 objectAgent: node object;
			 yourself) openDialog okAction: [ 
			node attributeDefinitions
				at: (index := node attributeDefinitions indexOf: oldDefinition)
				put: newDefinition.
			self nodeChanged.
			attributeDefinitionList selectIndex: index ] ]
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
				              | animat quantity |
				              animat := self
					                        requestAnimatIdentifierForNewDirective.
				              quantity := animat ~= '-' ifTrue: [ 
					                          self requestQuantityForNewDirective ].
				              RMDNewDirectiveNode new
					              animatIdentifier: animat;
					              quantity: quantity;
					              yourself ] }
		              with: { 
				              'stage'.
				              (node lifeDirectives contains: [ :directive | 
					               directive isStageDirectiveNode ]).
				              [ 
				              RMDStageDirectiveNode new
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
	chooser openDialog okAction: [ 
		node lifeDirectives: (directives
				 select: #second
				 thenCollect: [ :triple | triple third value ]).
		self nodeChanged ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> editUtilityDefinition [

	utilityDefinitionList selectedItem ifNotNil: [ :oldDefinition | 
		| newDefinition index |
		newDefinition := oldDefinition copy.
		newDefinition asPresenter openDialog okAction: [ 
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
	objectField := self newHighlightingSyntaxNodeTextInput
		               parser:
			               RMDGrammar new agentIdentifier optional trimBlanks
				               end;
		               placeholder: '(object)';
		               autoAccept: true;
		               whenLastValidSyntaxNodeChangedDo: [ :animat | 
			               node object: animat ];
		               yourself.
	guardField := self newHighlightingSyntaxNodeTextInput
		              parser:
			              RMDGrammar new condition optional trimBlanks end;
		              placeholder: 'guard condition';
		              autoAccept: false;
		              whenLastValidSyntaxNodeChangedDo: [ :guard | 
			              node guard: guard ];
		              yourself.
	directivesButton := self newButton
		                    color: Color white;
		                    label: 'no directive';
		                    action: [ self editDirectives ];
		                    help:
			                    'Edit directives such as new, stage, die and kill';
		                    yourself.
	attributeDefinitionList := self newList
		                           display: [ :attributeDef | 
			                           attributeDef printString ];
		                           whenSelectionChangedDo: [ 
			                           self updateAttributeButtons ];
		                           yourself.
	addAttributeButton := self newButton
		                      label: '';
		                      icon: self addIcon;
		                      action: [ self addAttributeDefinition ];
		                      help: 'Add a new attribute';
		                      yourself.
	removeAttributeButton := self newButton
		                         label: '';
		                         icon: self removeIcon;
		                         action: [ self removeAttributeDefinition ];
		                         help: 'Remove the selected attribute';
		                         disable;
		                         yourself.
	moveUpAttributeButton := self newButton
		                         icon: self upIcon;
		                         action: [ self moveUpAttribute ];
		                         help:
			                         'Move the selected attribute definition up';
		                         disable;
		                         yourself.
	moveDownAttributeButton := self newButton
		                           icon: self downIcon;
		                           action: [ self moveDownAttribute ];
		                           help:
			                           'Move the selected attribute definition down';
		                           disable;
		                           yourself.
	editAttributeButton := self newButton
		                       label: '';
		                       icon: self editIcon;
		                       action: [ self editAttributeDefinition ];
		                       help:
			                       'Edit the definition of the selected attribute';
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
		                    icon: self addIcon;
		                    action: [ self addUtilityDefinition ];
		                    help: 'Add a new utility variable';
		                    yourself.
	removeUtilityButton := self newButton
		                       label: '';
		                       icon: self removeIcon;
		                       action: [ self removeUtilityDefinition ];
		                       help: 'Remove the selected utility variable';
		                       disable;
		                       yourself.
	moveUpUtilityButton := self newButton
		                       icon: self upIcon;
		                       action: [ self moveUpUtility ];
		                       help:
			                       'Move the selected utility definition up';
		                       disable;
		                       yourself.
	moveDownUtilityButton := self newButton
		                         icon: self downIcon;
		                         action: [ self moveDownUtility ];
		                         help:
			                         'Move the selected utility definition down';
		                         disable;
		                         yourself.
	editUtilityButton := self newButton
		                     label: '';
		                     icon: self editIcon;
		                     action: [ self editUtilityDefinition ];
		                     help:
			                     'Edit the definition of the selected utility variable';
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
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ self preferredHeight
]

{ #category : #operations }
RMDActionDefinitionBrowser >> moveDownAttribute [

	attributeDefinitionList selection selectedItem ifNotNil: [ 
		:attributeNode | 
		| attributeDefinitions index |
		attributeDefinitions := node attributeDefinitions copy.
		index := attributeDefinitions
			         indexOf: attributeNode
			         ifAbsent: attributeDefinitions size + 1.
		index <= (attributeDefinitions size - 1) ifTrue: [ 
			attributeDefinitions
				at: index
				put: (attributeDefinitions at: index + 1).
			attributeDefinitions at: index + 1 put: attributeNode.
			node attributeDefinitions: attributeDefinitions.
			self nodeChanged.
			attributeDefinitionList selectIndex: index + 1 ] ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> moveDownUtility [

	utilityDefinitionList selection selectedItem ifNotNil: [ :utilityNode | 
		| utilityDeclarations index |
		utilityDeclarations := node utilityDefinitions copy.
		index := utilityDeclarations
			         indexOf: utilityNode
			         ifAbsent: utilityDeclarations size + 1.
		index <= (utilityDeclarations size - 1) ifTrue: [ 
			utilityDeclarations
				at: index
				put: (utilityDeclarations at: index + 1).
			utilityDeclarations at: index + 1 put: utilityNode.
			node utilityDefinitions: utilityDeclarations.
			self nodeChanged.
			utilityDefinitionList selectIndex: index + 1 ] ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> moveUpAttribute [

	attributeDefinitionList selection selectedItem ifNotNil: [ 
		:attributeNode | 
		| attributeDefinitions index |
		attributeDefinitions := node attributeDefinitions copy.
		index := attributeDefinitions indexOf: attributeNode ifAbsent: 0.
		index >= 2 ifTrue: [ 
			attributeDefinitions
				at: index
				put: (attributeDefinitions at: index - 1).
			attributeDefinitions at: index - 1 put: attributeNode.
			node attributeDefinitions: attributeDefinitions.
			self nodeChanged.
			attributeDefinitionList selectIndex: index - 1 ] ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> moveUpUtility [

	utilityDefinitionList selection selectedItem ifNotNil: [ 
		:utilityNode | 
		| utilityDefinitions index |
		utilityDefinitions := node utilityDefinitions copy.
		index := utilityDefinitions indexOf: utilityNode ifAbsent: 0.
		index >= 2 ifTrue: [ 
			utilityDefinitions
				at: index
				put: (utilityDefinitions at: index - 1).
			utilityDefinitions at: index - 1 put: utilityNode.
			node utilityDefinitions: utilityDefinitions.
			self nodeChanged.
			utilityDefinitionList selectIndex: index - 1 ] ]
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
	attributeDefinitionList
		items: node attributeDefinitions;
		unselectAll.
	utilityDefinitionList
		items: node utilityDefinitions;
		unselectAll.
	self updateTitle
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> preferredHeight [
	^ 600
]

{ #category : #operations }
RMDActionDefinitionBrowser >> removeAttributeDefinition [

	attributeDefinitionList selectedItem ifNotNil: [ :oldDefinition | 
		(UIManager default confirm:
			 'Sure to remove `' , oldDefinition printString , '''?') ifTrue: [ 
			node attributeDefinitions:
				(node attributeDefinitions copyWithout: oldDefinition).
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
		  name trim ifEmpty: [ '-' ] ]
]

{ #category : #operations }
RMDActionDefinitionBrowser >> requestQuantityForNewDirective [

	| parser |
	parser := RMDGrammar new expression end.

	^ ((UIManager default
		    request: 'Quantity of new borns'
		    initialAnswer: ((node lifeDirectives
				      detect: [ :directive | directive isNewDirectiveNode ]
				      ifNone: [ nil ])
				     ifNotNil: [ :directive | 
					     directive quantity ifNil: [ '1' ] ifNotNil: #printString ]
				     ifNil: [ '1' ])) ifNil: [ '1' ]) trim
		  ifEmpty: [ parser parse: '1' ]
		  ifNotEmpty: [ :expr | 
			  | n |
			  n := parser parse: expr.
			  n isPetit2Failure
				  ifTrue: [ parser parse: '1' ]
				  ifFalse: [ n ] ]
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> subjectAgent [

	^ subjectAgent
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> subjectAgent: aString [

	subjectAgent := aString
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> title [

	^ 'Action definition'
	  , (node ifNil: [ '' ] ifNotNil: [ :action | ' of ' , action name ])
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updateAttributeButtons [

	| hasSelection |
	hasSelection := attributeDefinitionList selectedItem notNil.
	removeAttributeButton enabled: hasSelection.
	moveUpAttributeButton enabled: (hasSelection and: [ 
			 attributeDefinitionList selection selectedIndex >= 2 ]).
	moveDownAttributeButton enabled: (hasSelection and: [ 
			 attributeDefinitionList selection selectedIndex
			 < attributeDefinitionList items size ]).
	editAttributeButton enabled: hasSelection
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updateTitle [

	self window ifNotNil: [ :w | w title: self title ]
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updateUtilityButtons [

	| hasSelection |
	hasSelection := utilityDefinitionList selectedItem notNil.
	removeUtilityButton enabled: hasSelection.
	moveUpUtilityButton enabled: (hasSelection and: [ 
			 utilityDefinitionList selection selectedIndex >= 2 ]).
	moveDownUtilityButton enabled: (hasSelection and: [ 
			 utilityDefinitionList selection selectedIndex
			 < utilityDefinitionList items size ]).
	editUtilityButton enabled: hasSelection
]
