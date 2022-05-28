Class {
	#name : #RMDTaskDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'agentName',
		'actionList',
		'templateText',
		'importActionButton',
		'addActionButton',
		'removeActionButton',
		'editActionButton',
		'verbIdentifierField',
		'objectIdentifierField',
		'replacementList',
		'addReplacementButton',
		'removeReplacementButton',
		'editReplacementButton',
		'sourceText',
		'taskDefinitionNode',
		'rangeField',
		'nearestCheckBox'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDTaskDefinitionBrowser class >> defaultLayout [

	^ SpPanedLayout newVertical
		  positionOfSlider: 0.4;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.5;
				   add: (SpBoxLayout newVertical
						    add: 'Actions' expand: false;
						    add: #actionList;
						    add: (SpBoxLayout newHorizontal
								     add: #importActionButton width: self buttonHeight;
								     add: #addActionButton width: self buttonHeight;
								     add: #removeActionButton width: self buttonHeight;
								     add: #editActionButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Template' expand: false;
						    add: #templateText;
						    yourself));
		  add: (SpBoxLayout newVertical
				   add: 'Task Specialization' expand: false;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.5;
						    add: (SpBoxLayout newVertical
								     add: (SpBoxLayout newHorizontal
										      vAlignCenter;
										      add: #verbIdentifierField;
										      add: #nearestCheckBox width: 100;
										      add: #objectIdentifierField;
										      add: (SpBoxLayout newHorizontal
												       vAlignCenter;
												       add: 'within ' expand: false;
												       add: #rangeField))
								     height: self inputTextHeight;
								     add: #replacementList;
								     add: (SpBoxLayout newHorizontal
										      add: #addReplacementButton width: self buttonHeight;
										      add: #removeReplacementButton
										      width: self buttonHeight;
										      add: #editReplacementButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    add: #sourceText;
						    yourself));
		  yourself
]

{ #category : #'instance creation' }
RMDTaskDefinitionBrowser class >> on: aRMDSimulationModel [
	^ self new
		simulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #'instance creation' }
RMDTaskDefinitionBrowser class >> withoutInterpreter [
	^ self new
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> acceptNearestCheckBox [

	self taskDefinition ifNotNil: [ :task | 
		task objectIdentifier ifNotNil: [ 
			task nearest: nearestCheckBox state.
			self updateSourceText ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> acceptObjectIdentifierField [
	self taskDefinition
		ifNotNil: [ :task | 
			| newObjectIdentifier |
			newObjectIdentifier := objectIdentifierField lastValidSyntaxNode
				ifEmpty: [ nil ].
			task objectIdentifier: newObjectIdentifier.
			self updateSourceText ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> acceptRangeField [

	self taskDefinition ifNotNil: [ :task | 
		task objectIdentifier ifNotNil: [ 
			| newRange |
			newRange := rangeField lastValidSyntaxNode ifNotNil: [ :r | 
				            r isString
					            ifTrue: [ nil ]
					            ifFalse: [ 
						            r unit isLength
							            ifTrue: [ r ]
							            ifFalse: [ nil ] ] ].
			task range: newRange.
			self updateSourceText ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> acceptVerbIdentifierField [
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
RMDTaskDefinitionBrowser >> actionDefinition [
	^ actionList selection selectedItem
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> addAction [

	| newActionDef |
	newActionDef := RMDActionDefinitionNode template.
	newActionDef asPresenter openDialog okAction: [ 
		self simulationModel ifNotNil: [ :model | 
			model addActionDefinition: newActionDef.
			self taskDefinition ifNotNil: #resetAction.
			self
				updateActionList;
				updateActionButtons;
				updateTemplateText;
				updateSourceText ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> addReplacement [

	self simulationModel ifNotNil: [ :model | 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			(model
				 actionDefinitionAt: taskDefinition actionIdentifier
				 ifAbsent: [ nil ]) ifNotNil: [ :actionDefinition | 
				| bindEditor |
				(bindEditor := RMDAttributeBindEditor
					               actionDefinition: actionDefinition
					               except:
					               (taskDefinition attributeBinds collect:
						                #placeholder)) openDialog okAction: [ 
					bindEditor attributeBindNode ifNotNil: [ :bindNode | 
						taskDefinition attributeBinds:
							(taskDefinition attributeBinds copyWith: bindNode).
						self
							updateReplacementList;
							updateSourceText ] ] ] ] ]
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> agentName [
	^ agentName
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> agentName: aString [
	agentName := aString
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> editAction [

	self actionDefinition ifNotNil: [ :oldActionDef | 
		| newActionDef |
		newActionDef := oldActionDef copy.
		newActionDef asPresenter openDialogWithSpec okAction: [ 
			self actionDefinition ifNotNil: [ :actionDefinition | 
				self simulationModel ifNotNil: [ :model | 
					model
						removeActionDefinition: oldActionDef ifAbsent: [  ];
						addActionDefinition: newActionDef.
					self taskDefinition ifNotNil: #resetAction.
					self
						updateActionList;
						updateActionButtons;
						updateTemplateText;
						updateSourceText ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> editReplacement [

	self simulationModel ifNotNil: [ :model | 
		replacementList selection selectedItem ifNotNil: [ :oldBind | 
			self taskDefinition ifNotNil: [ :taskDefinition | 
				(model
					 actionDefinitionAt: taskDefinition actionIdentifier
					 ifAbsent: [ nil ]) ifNotNil: [ :actionDefinition | 
					| bindEditor |
					bindEditor := RMDAttributeBindEditor
						              actionDefinition: actionDefinition
						              except: (taskDefinition attributeBinds
								               select: [ :bind | bind ~= oldBind ]
								               thenCollect: #placeholder).
					bindEditor attributeBindNode: oldBind.
					bindEditor openDialog okAction: [ 
						bindEditor attributeBindNode ifNotNil: [ :newBind | 
							| index |
							index := taskDefinition attributeBinds indexOf: oldBind.
							index > 0
								ifTrue: [ 
									taskDefinition attributeBinds at: index put: newBind.
									taskDefinition resetAction ]
								ifFalse: [ 
									taskDefinition attributeBinds:
										(taskDefinition attributeBinds copyWith: newBind) ].
							self
								updateReplacementList;
								updateSourceText ] ] ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> importAction [

	RMDRepositoryActionsBrowser openToLoadDo: [ :newAction | 
		self simulationModel ifNotNil: [ :model | 
			model load: newAction copy.
			self
				updateActionList;
				updateActionButtons;
				updateTemplateText;
				updateSourceText ] ]
]

{ #category : #initialization }
RMDTaskDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	actionList := self newTable
		              beSingleSelection;
		              beResizable;
		              showColumnHeaders;
		              addColumn: (SpStringTableColumn
				               title: 'verb'
				               evaluated: [ :item | item identifier ]);
		              addColumn: (SpStringTableColumn
				               title: 'object'
				               evaluated: [ :item | item object ifNil: [ '' ] ]);
		              whenModelChangedDo: [ actionList selectItem: nil ];
		              whenSelectionChangedDo: [ 
			              self updateActionButtons.
			              self updateTaskDefinition.
			              self taskDefinition ifNotNil: [ :taskDefinition | 
					              self actionDefinition ifNotNil: [ :actionIdentifier | 
							              self updateVerbIdentifierField.
							              self updateObjectIdentifierField.
							              self updateNearestCheckBox.
							              self updateRangeField ].
					              self
						              updateTemplateText;
						              updateReplacementList;
						              updateSourceText ] ];
		              yourself.
	importActionButton := self newButton
		                      icon: self repositoryIcon;
		                      action: [ self importAction ];
		                      yourself.
	addActionButton := self newButton
		                   icon: self addIcon;
		                   action: [ self addAction ];
		                   yourself.
	removeActionButton := self newButton
		                      icon: self removeIcon;
		                      action: [ self removeAction ];
		                      disable;
		                      yourself.
	editActionButton := self newButton
		                    icon: self editIcon;
		                    action: [ self editAction ];
		                    disable;
		                    yourself.
	templateText := (self newSourceWith: RMDGrammar new actionDefinition)
		                enabled: false;
		                editable: false;
		                highlights: Array new;
		                whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		                yourself.
	verbIdentifierField := self newSyntaxNodeTextInput
		                       beIdentifier;
		                       whenLastValidSyntaxNodeChangedDo: [ 
			                       self acceptVerbIdentifierField ];
		                       yourself.
	nearestCheckBox := self newCheckBox
		                   label: 'nearest';
		                   labelOnRight;
		                   whenChangedDo: [ self acceptNearestCheckBox ];
		                   yourself.
	objectIdentifierField := self newSyntaxNodeTextInput
		                         beAgentIdentifier;
		                         allowEmpty;
		                         whenLastValidSyntaxNodeChangedDo: [ 
			                         self acceptObjectIdentifierField ];
		                         yourself.
	rangeField := self newSyntaxNodeTextInput
		              beLiteral;
		              allowEmpty;
		              whenLastValidSyntaxNodeChangedDo: [ 
			              self acceptRangeField ];
		              yourself.
	replacementList := self newTable
		                   beSingleSelection;
		                   beResizable;
		                   addColumn:
			                   ((SpStringTableColumn
				                     title: 'placeholder'
				                     evaluated: [ :item | 
					                     | actionAttribute actionDefinition |
					                     actionAttribute := item placeholder
						                                       printString asText.
					                     actionDefinition := self actionDefinition.
					                     (actionDefinition isNil or: [ 
							                      (actionDefinition includesNode:
									                       item placeholder) not ]) ifTrue: [ 
							                     actionAttribute makeAllColor: Color red ].
					                     actionAttribute ])
				                    beExpandable;
				                    yourself);
		                   addColumn:
			                   ((SpImageTableColumn evaluated: [ :item | 
					                     self replacementIcon ])
				                    width: 20;
				                    beNotExpandable);
		                   addColumn: ((SpStringTableColumn
				                     title: 'specialized'
				                     evaluated: [ :item | 
					                     item replacement printString ])
				                    beExpandable;
				                    yourself);
		                   whenModelChangedDo: [ 
		                   replacementList selectItem: nil ];
		                   whenSelectionChangedDo: [ 
			                   | selected |
			                   selected := replacementList selection
				                               selectedItem notNil.
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
		              editable: false;
		              whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		              yourself.
	self updateActionList
]

{ #category : #initialization }
RMDTaskDefinitionBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Task definition'.
	aWindowPresenter initialExtent: 800 @ 600
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> removeAction [

	self actionDefinition ifNotNil: [ :oldActionDef | 
		(UIManager default confirm:
			 'Sure to remove ' , oldActionDef identifier , ' from the model?') 
			ifTrue: [ 
				self actionDefinition ifNotNil: [ :actionDefinition | 
					self simulationModel ifNotNil: [ :model | 
						model removeActionDefinition: actionDefinition ifAbsent: [].
						self taskDefinition ifNotNil: #resetAction.
						self
							updateActionList;
							updateActionButtons;
							updateTemplateText;
							updateSourceText ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> removeReplacement [
	replacementList selection selectedItem
		ifNotNil: [ :bind | 
			self taskDefinition
				ifNotNil: [ :task | 
					task attributeBinds: (task attributeBinds copyWithout: bind).
					self
						updateReplacementList;
						updateSourceText ] ]
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> simulationModel [
	^ simulationModel
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel.
	self updateActionList
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> taskDefinition [
	^ taskDefinitionNode
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> taskDefinition: aRMDTaskDefinitionNode [
	taskDefinitionNode := aRMDTaskDefinitionNode.
	self taskDefinitionChanged
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> taskDefinitionChanged [

	taskDefinitionNode ifNotNil: [ 
		taskDefinitionNode actionIdentifier ifNotNil: [ :actionIdentifier | 
			actionList selectItem: (actionList items
					 detect: [ :action | actionIdentifier = action identifier ]
					 ifNone: [ nil ]) ] ].
	self updateReplacementList
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateActionButtons [

	| selected |
	selected := actionList selection selectedItem notNil.
	importActionButton enable.
	addActionButton enable.
	removeActionButton enabled: selected.
	editActionButton enabled: selected
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateActionList [

	actionList items: (simulationModel
			 ifNotNil: [ 
				 simulationModel actionNames
					 collect: [ :name | 
					 simulationModel actionDefinitionAt: name ifAbsent: [  ] ]
					 thenSelect: #notNil ]
			 ifNil: [ Array new ])
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateNearestCheckBox [

	self taskDefinition ifNotNil: [ :taskDefinition | 
		nearestCheckBox state: taskDefinition nearest ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateObjectIdentifierField [

	objectIdentifierField text asString trim ifEmpty: [ 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			taskDefinition objectIdentifier
				ifNotNil: [ :objectIdentifier | 
				objectIdentifierField text: objectIdentifier ]
				ifNil: [ objectIdentifierField text: '' ] ] ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateRangeField [

	rangeField text asString trim ifEmpty: [ 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			taskDefinition range
				ifNotNil: [ :range | rangeField syntaxNode: range ]
				ifNil: [ rangeField text: '' ] ] ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateReplacementList [

	replacementList items: (self taskDefinition
			 ifNotNil: [ :taskDefinition | taskDefinition attributeBinds ]
			 ifNil: [ Array new ])
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateSourceText [

	simulationModel ifNotNil: [ 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			| highlights |
			highlights := Set new: 10.
			[ 
			[ simulationModel typecheck: taskDefinitionNode ]
				on: RMDTypeError
				do: [ :ex | 
					highlights add: ex ast.
					ex resume: ex unit ] ]
				on: RMDUnresolvedReferenceError
				do: [ :ex | highlights add: ex ast ].
			sourceText highlights: highlights.
			sourceText text: ([ 
				 (taskDefinitionNode actionWith: simulationModel) printString
					 asText ]
					 on: RMDUnresolvedReferenceError
					 do: [ :ex | String new ]) ] ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateTaskDefinition [

	self actionDefinition ifNotNil: [ :actionDefinition | 
		self taskDefinition
			ifNil: [ 
				self taskDefinition: (RMDTaskDefinitionNode
						 subjectIdentifier: self agentName
						 verbIdentifier:
							 (verbIdentifierField text asString trim ifEmpty: [ 
								  actionDefinition identifier ])
						 objectIdentifier:
						 (objectIdentifierField text asString trim ifEmpty: [ nil ])
						 actionIdentifier: actionDefinition identifier
						 nearest: nearestCheckBox state
						 within: rangeField lastValidSyntaxNode
						 guard: nil
						 attributeBinds: Array new) ]
			ifNotNil: [ :taskDefinition | 
				taskDefinition actionIdentifier: actionDefinition identifier.
				(taskDefinition actionWith: simulationModel) object
					ifNil: [ 
						objectIdentifierField syntaxNode
							ifNil: [ objectIdentifierField beOk ]
							ifNotNil: [ objectIdentifierField beError ].
						nearestCheckBox disable.
						rangeField syntaxNode
							ifNil: [ rangeField beOk ]
							ifNotNil: [ rangeField beError ] ]
					ifNotNil: [ 
						objectIdentifierField syntaxNode
							ifNil: [ objectIdentifierField beError ]
							ifNotNil: [ objectIdentifierField beOk ].
						nearestCheckBox enable.
						rangeField syntaxNode
							ifNil: [ rangeField beError ]
							ifNotNil: [ rangeField beOk ] ] ] ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateTemplateText [

	self actionDefinition
		ifNotNil: [ :actionDefinition | 
		templateText syntaxNode: actionDefinition ]
		ifNil: [ templateText text: '' ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateVerbIdentifierField [

	verbIdentifierField text asString trim ifEmpty: [ 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			verbIdentifierField text:
				(taskDefinition verbIdentifier ifNil: [ String new ]) ] ]
]
