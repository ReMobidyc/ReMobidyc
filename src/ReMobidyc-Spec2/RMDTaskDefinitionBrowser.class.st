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
		'parameterInstantiationList',
		'sourceText',
		'taskDefinitionNode',
		'rangeField',
		'nearestCheckBox',
		'addParameterInstantiationButton',
		'editParameterInstantiationButton',
		'removeParameterInstantiationButton',
		'viewParameterInstantiationButton'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDTaskDefinitionBrowser class >> defaultLayout [

	^ SpPanedLayout newVertical
		  positionOfSlider: 0.4;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.6;
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
						    positionOfSlider: 0.6;
						    add: (SpBoxLayout newVertical
								     add: (SpBoxLayout newHorizontal
										      vAlignCenter;
										      add: #verbIdentifierField expand: true;
										      add: #nearestCheckBox width: 80;
										      add: #objectIdentifierField width: 120;
										      add: (SpBoxLayout newHorizontal
												       vAlignCenter;
												       add: 'within ' expand: false;
												       add: #rangeField width: 100) expand: false)
								     height: self inputTextHeight;
								     add: #parameterInstantiationList;
								     add: (SpBoxLayout newHorizontal
										      add: #addParameterInstantiationButton width: self buttonHeight;
										      add: #removeParameterInstantiationButton
										      width: self buttonHeight;
										      add: #editParameterInstantiationButton width: self buttonHeight;
										      add: #viewParameterInstantiationButton width: self buttonHeight;
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

	self taskDefinition ifNotNil: [ :task | 
		| newObjectIdentifier |
		newObjectIdentifier := (objectIdentifierField lastValidSyntaxNode 
			                        ifNil: [ '' ]) ifEmpty: [ nil ].
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

{ #category : #menus }
RMDTaskDefinitionBrowser >> actionListMenu [

	^ self newMenu
		  addGroup: [ :group |
			  group
				  addItem: [ :item |
					  item
						  name: 'Import...';
						  icon: self repositoryIcon;
						  enabled: importActionButton isEnabled;
						  action: [ self importAction ] ];
				  addItem: [ :item |
					  item
						  name: 'New...';
						  icon: self addIcon;
						  enabled: addActionButton isEnabled;
						  action: [ self addAction ] ];
				  addItem: [ :item |
					  item
						  name: 'Edit...';
						  icon: self editIcon;
						  enabled: editActionButton isEnabled;
						  action: [ self editAction ] ];
				  addItem: [ :item |
					  item
						  name: 'Remove';
						  icon: self removeIcon;
						  enabled: removeActionButton isEnabled;
						  action: [ self removeAction ] ] ];
		  yourself
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> addAction [

	| newActionDef |
	newActionDef := RMDActionDefinitionNode template.
	(newActionDef asPresenter
		 simulationModel: simulationModel;
		 subjectAgent: (taskDefinitionNode ifNotNil: #subjectIdentifier);
		 yourself) openDialog okAction: [ 
		newActionDef identifier ifNotEmpty: [ 
			self simulationModel ifNotNil: [ :model | 
				model addActionDefinition: newActionDef.
				self taskDefinition ifNotNil: #resetAction.
				self updateActionList.
				actionList selectItem: newActionDef.
				self
					updateActionButtons;
					updateTemplateText;
					updateSourceText ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> addParameterInstantiation [

	self simulationModel ifNotNil: [ :model | 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			(model
				 actionDefinitionAt: taskDefinition actionIdentifier
				 ifAbsent: [ nil ]) ifNotNil: [ :actionDefinition | 
				| bindEditor |
				(bindEditor := RMDParameterInstantiationEditor
					               actionDefinition: actionDefinition
					               except:
					               (taskDefinition parameterInstantiations collect:
						                #placeholder)) openDialog okAction: [ 
					bindEditor parameterInstantiationNode ifNotNil: [ :bindNode | 
						taskDefinition parameterInstantiations:
							(taskDefinition parameterInstantiations copyWith: bindNode).
						self
							updateParameterInstantiationList;
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
		(newActionDef asPresenter
			 simulationModel: self simulationModel;
			 subjectAgent: (taskDefinitionNode ifNotNil: #subjectIdentifier);
			 yourself) openDialog okAction: [ 
			self actionDefinition ifNotNil: [ :actionDefinition | 
				self simulationModel ifNotNil: [ :model | 
					model
						removeActionDefinition: oldActionDef ifAbsent: [  ];
						addActionDefinition: newActionDef.
					self taskDefinition ifNotNil: #resetAction.
					self updateActionList.
					actionList selectItem: newActionDef.
					self
						updateActionButtons;
						updateTemplateText;
						updateSourceText ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> editParameterInstantiation [

	self simulationModel ifNotNil: [ :model | 
		parameterInstantiationList selection selectedItem ifNotNil: [ :oldBind | 
			self taskDefinition ifNotNil: [ :taskDefinition | 
				(model
					 actionDefinitionAt: taskDefinition actionIdentifier
					 ifAbsent: [ nil ]) ifNotNil: [ :actionDefinition | 
					| bindEditor |
					bindEditor := RMDParameterInstantiationEditor
						              actionDefinition: actionDefinition
						              except: (taskDefinition parameterInstantiations
								               select: [ :bind | bind ~= oldBind ]
								               thenCollect: #placeholder).
					bindEditor parameterInstantiationNode: oldBind.
					bindEditor openDialog okAction: [ 
						bindEditor parameterInstantiationNode ifNotNil: [ :newBind | 
							| index |
							index := taskDefinition parameterInstantiations indexOf: oldBind.
							index > 0
								ifTrue: [ 
									taskDefinition parameterInstantiations at: index put: newBind.
									taskDefinition resetAction ]
								ifFalse: [ 
									taskDefinition parameterInstantiations:
										(taskDefinition parameterInstantiations copyWith: newBind) ].
							self
								updateParameterInstantiationList;
								updateSourceText ] ] ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> importAction [

	RMDRepositoryActionsBrowser openToLoadDo: [ :action | 
		self simulationModel ifNotNil: [ :model | 
			| newAction |
			newAction := action copy.
			model load: newAction.
			self updateActionList.
			actionList selectItem: newAction.
			self
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
						              updateParameterInstantiationList;
						              updateSourceText ] ];
		              contextMenu: [ self actionListMenu ];
		              yourself.
	importActionButton := self newButton
		                      icon: self repositoryIcon;
		                      action: [ self importAction ];
		                      help: 'Import an action from repository';
		                      yourself.
	addActionButton := self newButton
		                   icon: self addIcon;
		                   action: [ self addAction ];
		                   help: 'Define a new action';
		                   yourself.
	removeActionButton := self newButton
		                      icon: self removeIcon;
		                      action: [ self removeAction ];
		                      help: 'Remove the selected action';
		                      disable;
		                      yourself.
	editActionButton := self newButton
		                    icon: self editIcon;
		                    action: [ self editAction ];
		                    help:
			                    'Edit the definition of the selected action';
		                    disable;
		                    yourself.
	templateText := (self newSourceWith:
			                 RMDGrammar current actionDefinition)
		                permitUnresolvedAttributeReference;
		                enabled: false;
		                beNotEditable;
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
	rangeField := self newHighlightingSyntaxNodeTextInput
		              beLiteral;
		              allowEmpty;
		              expectedType: RMDType length;
		              whenLastValidSyntaxNodeChangedDo: [
			              self acceptRangeField ];
		              yourself.
	parameterInstantiationList := self newTable
		                              beSingleSelection;
		                              beResizable;
		                              addColumn:
			                              ((SpStringTableColumn
				                                title: 'placeholder'
				                                evaluated: [ :item |
					                                | actionAttribute actionDefinition |
					                                actionAttribute := item
						                                                   placeholder
						                                                   printString
						                                                   asText.
					                                actionDefinition := self
						                                                    actionDefinition.
					                                (actionDefinition isNil or: [
							                                 (actionDefinition
								                                  includesNode:
									                                  item placeholder) not ])
						                                ifTrue: [
							                                actionAttribute makeAllColor:
									                                Color red ].
					                                actionAttribute ])
				                               beExpandable;
				                               yourself);
		                              addColumn:
			                              ((SpImageTableColumn evaluated: [
					                                :item | self replacementIcon ])
				                               width: 20;
				                               beNotExpandable);
		                              addColumn: ((SpStringTableColumn
				                                title: 'specialized'
				                                evaluated: [ :item |
					                                item replacement printString ])
				                               beExpandable;
				                               yourself);
		                              whenModelChangedDo: [
		                              parameterInstantiationList
			                              selectItem: nil ];
		                              whenSelectionChangedDo: [
			                              | selected |
			                              selected := parameterInstantiationList
				                                          selection selectedItem
				                                          notNil.
			                              removeParameterInstantiationButton
				                              enabled: selected.
			                              editParameterInstantiationButton
				                              enabled: selected.
			                              viewParameterInstantiationButton
				                              enabled: selected ];
		                              contextMenu: [
		                              self parameterInstiationListMenu ];
		                              yourself.
	addParameterInstantiationButton := self newButton
		                                   icon: self addIcon;
		                                   action: [
			                                   self addParameterInstantiation ];
		                                   help:
			                                   'Add a new replacement rule with a placeholder';
		                                   yourself.
	removeParameterInstantiationButton := self newButton
		                                      icon: self removeIcon;
		                                      action: [
			                                      self
				                                      removeParameterInstantiation ];
		                                      help:
			                                      'Remove the selected replacement rule';
		                                      disable;
		                                      yourself.
	editParameterInstantiationButton := self newButton
		                                    icon: self editIcon;
		                                    action: [
			                                    self editParameterInstantiation ];
		                                    help:
			                                    'Edit the selected replacement rule';
		                                    disable;
		                                    yourself.
	viewParameterInstantiationButton := self newButton
		                                    icon: self validatoriumIcon;
		                                    action: [
			                                    self viewParameterInstantiation ];
		                                    disable;
		                                    help: 'View the definition';
		                                    yourself.
	sourceText := (self newSourceWith:
			               RMDGrammar current actionDefinition)
		              enabled: false;
		              beNotEditable;
		              whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		              yourself.
	self updateActionList
]

{ #category : #initialization }
RMDTaskDefinitionBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: self title.
	aWindowPresenter initialExtent: 900 @ 600
]

{ #category : #widgets }
RMDTaskDefinitionBrowser >> newHighlightingSyntaxNodeTextInput [

	^ super newHighlightingSyntaxNodeTextInput
		  simulationModelBlock: [ self simulationModel ];
		  yourself
]

{ #category : #widgets }
RMDTaskDefinitionBrowser >> newSourceWith: aPP2Node [

	^ (super newSourceWith: aPP2Node)
		  simulationModelBlock: [ self simulationModel ];
		  subjectBlock: [ taskDefinitionNode ifNotNil: #subjectIdentifier ];
		  objectBlock: [ taskDefinitionNode ifNotNil: #objectIdentifier ];
		  yourself
]

{ #category : #menus }
RMDTaskDefinitionBrowser >> parameterInstiationListMenu [

	^ self newMenu
		  addGroup: [ :group |
			  group
				  addItem: [ :item |
					  item
						  name: 'Add...';
						  icon: self addIcon;
						  enabled: addParameterInstantiationButton isEnabled;
						  action: [ self addParameterInstantiation ] ];
				  addItem: [ :item |
					  item
						  name: 'Edit...';
						  icon: self editIcon;
						  enabled: editParameterInstantiationButton isEnabled;
						  action: [ self editParameterInstantiation ] ];
				  addItem: [ :item |
					  item
						  name: 'Remove';
						  icon: self removeIcon;
						  enabled: removeParameterInstantiationButton isEnabled;
						  action: [ self removeParameterInstantiation ] ] ];
		  yourself
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
RMDTaskDefinitionBrowser >> removeParameterInstantiation [

	parameterInstantiationList selection selectedItem ifNotNil: [ :bind | 
		self taskDefinition ifNotNil: [ :task | 
			task parameterInstantiations:
				(task parameterInstantiations copyWithout: bind).
			self
				updateParameterInstantiationList;
				updateSourceText ] ]
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> simulationModel [
	^ simulationModel
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> simulationModel: aRMDSimulationModel [

	simulationModel := aRMDSimulationModel.
	self updateActionList.
	templateText text ifNotEmpty: [ self updateTemplateText ].
	sourceText text ifNotEmpty: [ self updateSourceText ]
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
	self
		updateParameterInstantiationList;
		updateTitle
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> title [

	^ 'Task definition' , (self taskDefinition
		   ifNil: [ '' ]
		   ifNotNil: [ :task | ' of ' , task name ])
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

	| selection |
	selection := actionList selectedItem.
	simulationModel
		ifNotNil: [ 
			actionList
				items: (simulationModel actionNames
						 collect: [ :name | 
							 simulationModel actionDefinitionAt: name ifAbsent: [  ] ]
						 thenSelect: #notNil);
				selectItem: selection ]
		ifNil: [ actionList items: Array new ]
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
RMDTaskDefinitionBrowser >> updateParameterInstantiationList [

	parameterInstantiationList items: (self taskDefinition
			 ifNotNil: [ :taskDefinition | 
			 taskDefinition parameterInstantiations ]
			 ifNil: [ Array new ])
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
RMDTaskDefinitionBrowser >> updateSourceText [

	simulationModel ifNotNil: [
		self taskDefinition ifNotNil: [ :taskDefinition |
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
						 enabled: true
						 guard: nil
						 parameterInstantiations: Array new) ]
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
			templateText text: actionDefinition printString asText ]
		ifNil: [ templateText text: '' ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateTitle [

	self window ifNotNil: [ :w | w title: self title ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateVerbIdentifierField [

	verbIdentifierField text asString trim ifEmpty: [ 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			verbIdentifierField text:
				(taskDefinition verbIdentifier ifNil: [ String new ]) ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> viewParameterInstantiation [

	self simulationModel ifNotNil: [ :model |
		parameterInstantiationList selection selectedItem ifNotNil: [ :bind |
			| n |
			n := bind replacement.
			(n isExpressionNode or: [ n isConditionNode ]) ifTrue: [
				n asPrettyPrintNode openTitle:
					'definition of ' , bind placeholder printString ] ] ]
]
