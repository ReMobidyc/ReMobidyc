Class {
	#name : #RMDTaskDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'agentName',
		'repositoryList',
		'actionList',
		'templateText',
		'addRepositoryButton',
		'removeRepositoryButton',
		'editRepositoryButton',
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
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDTaskDefinitionBrowser class >> defaultSpec [

	^ SpPanedLayout newVertical
		  positionOfSlider: 0.5;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.6;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.4;
						    add: (SpBoxLayout newVertical
								     add: 'Repositories' expand: false;
								     add: #repositoryList;
								     add: (SpBoxLayout newHorizontal
										      add: #addRepositoryButton width: self buttonHeight;
										      add: #removeRepositoryButton width: self buttonHeight;
										      add: #editRepositoryButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: 'Actions' expand: false;
								     add: #actionList;
								     add: (SpBoxLayout newHorizontal
										      add: #addActionButton width: self buttonHeight;
										      add: #removeActionButton width: self buttonHeight;
										      add: #editActionButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Template' expand: false;
						    add: #templateText;
						    yourself));
		  add: (SpBoxLayout newVertical
				   add: 'Task Specialization' expand: false;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.4;
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
	^ self actionIdentifier
		ifNotNil: [ :actionIdentifier | 
			self simulationModel
				ifNotNil: [ :model | actionIdentifier resolveWith: simulationModel ] ]
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> actionIdentifier [ 
	^ actionList selection selectedItem
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> addAction [

	| newActionDef |
	newActionDef := RMDActionDefinitionNode template.
	newActionDef asPresenter openDialogWithSpec okAction: [ 
		self simulationModel ifNotNil: [ :model | 
			self actionIdentifier
				ifNil: [ 
					| actionIdentifier |
					actionIdentifier := RMDLocalActionIdentifierNode identifier:
						                    newActionDef identifier.
					actionIdentifier writeActionDefinition: newActionDef in: model ]
				ifNotNil: [ :actionIdentifier | 
					actionIdentifier writeActionDefinition: newActionDef in: model ].
			self taskDefinition ifNotNil: #resetAction.
			self
				updateActionList;
				updateActionButtons;
				updateTemplateText;
				updateSourceText ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> addReplacement [

	self taskDefinition ifNotNil: [ :taskDefinition | 
		| bindEditor |
		(bindEditor := RMDPropertyBindEditor
			               actionDefinition:
			               (taskDefinition actionIdentifier resolveWith:
				                simulationModel)
			               except:
			               (taskDefinition propertyBinds collect: #placeholder))
			openDialogWithSpec okAction: [ 
			bindEditor propertyBindNode ifNotNil: [ :bindNode | 
				taskDefinition propertyBinds:
					(taskDefinition propertyBinds copyWith: bindNode).
				self
					updateReplacementList;
					updateSourceText ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> addRepository [
	^ self notYetImplemented
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
			self actionIdentifier ifNotNil: [ :actionIdentifier | 
				self simulationModel ifNotNil: [ :model | 
					actionIdentifier
						updateActionDefinition: oldActionDef
						to: newActionDef
						in: model.
					self taskDefinition ifNotNil: #resetAction.
					self
						updateActionList;
						updateActionButtons;
						updateTemplateText;
						updateSourceText ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> editReplacement [

	replacementList selection selectedItem ifNotNil: [ :oldBind | 
		self taskDefinition ifNotNil: [ :taskModel | 
			| bindEditor |
			bindEditor := RMDPropertyBindEditor
				              actionDefinition:
				              (taskModel actionIdentifier resolveWith:
					               simulationModel)
				              except: (taskModel propertyBinds
						               select: [ :bind | bind ~= oldBind ]
						               thenCollect: #placeholder).
			bindEditor propertyBindNode: oldBind.
			bindEditor openDialogWithSpec okAction: [ 
				bindEditor propertyBindNode ifNotNil: [ :newBind | 
					| index |
					index := taskModel propertyBinds indexOf: oldBind.
					index > 0
						ifTrue: [ 
							taskModel propertyBinds at: index put: newBind.
							taskModel resetAction ]
						ifFalse: [ 
							taskModel propertyBinds:
								(taskModel propertyBinds copyWith: newBind) ].
					self
						updateReplacementList;
						updateSourceText ] ] ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> editRepository [
	^ self notYetImplemented
]

{ #category : #initialization }
RMDTaskDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	repositoryList := self newList
		                  beSingleSelection;
		                  whenModelChangedDo: [ 
			                  repositoryList selectItem: nil ];
		                  whenSelectionChangedDo: [ 
			                  self
				                  updateActionList;
				                  updateActionButtons ];
		                  display: [ :item | item repositoryName ];
		                  yourself.
	addRepositoryButton := self newButton
		                       icon: self addIcon;
		                       action: [ self addRepository ];
		                       yourself.
	removeRepositoryButton := self newButton
		                          icon: self removeIcon;
		                          action: [ self removeRepository ];
		                          disable;
		                          yourself.
	editRepositoryButton := self newButton
		                        icon: self editIcon;
		                        action: [ self editRepository ];
		                        disable;
		                        yourself.
	actionList := self newTable
		              beSingleSelection;
		              beResizable;
		              showColumnHeaders;
		              addColumn: (SpStringTableColumn
				               title: 'verb'
				               evaluated: [ :item | 
					               (item resolveWith: simulationModel) identifier ]);
		              addColumn: (SpStringTableColumn
				               title: 'object'
				               evaluated: [ :item | 
					               (item resolveWith: simulationModel) object ifNil: [ 
							               '' ] ]);
		              whenModelChangedDo: [ actionList selectItem: nil ];
		              whenSelectionChangedDo: [ 
			              self updateActionButtons.
			              self updateTaskDefinition.
			              self taskDefinition ifNotNil: [ :taskDefinition | 
					              self actionIdentifier ifNotNil: [ :actionIdentifier | 
							              self updateVerbIdentifierField.
							              self updateObjectIdentifierField.
							              self updateNearestCheckBox.
							              self updateRangeField ].
					              self
						              updateTemplateText;
						              updateReplacementList;
						              updateSourceText ] ];
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
					                     | actionProperty actionDefinition |
					                     actionProperty := item placeholder
						                                       printString asText.
					                     actionDefinition := self actionDefinition.
					                     (actionDefinition isNil or: [ 
							                      (actionDefinition includesNode:
									                       item placeholder) not ]) ifTrue: [ 
							                     actionProperty makeAllColor: Color red ].
					                     actionProperty ])
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
	self updateRepositoryList
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
				self actionIdentifier ifNotNil: [ :actionIdentifier | 
					self simulationModel ifNotNil: [ :model | 
						actionIdentifier removeActionDefinition: oldActionDef in: model.
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
					task propertyBinds: (task propertyBinds copyWithout: bind).
					self
						updateReplacementList;
						updateSourceText ] ]
]

{ #category : #operations }
RMDTaskDefinitionBrowser >> removeRepository [
	^ self notYetImplemented
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> repositories [
	^ Array
		streamContents: [ :stream | 
			stream nextPut: RMDBuiltinRepository current.
			simulationModel
				ifNotNil: [ stream nextPut: (RMDModelRepository on: simulationModel) ] ]
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> repository [
	^ repositoryList selection selectedItem
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> simulationModel [
	^ simulationModel
]

{ #category : #accessing }
RMDTaskDefinitionBrowser >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel.
	self updateRepositoryList
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
	taskDefinitionNode
		ifNotNil: [ taskDefinitionNode actionIdentifier
				ifNotNil: [ :actionIdentifier | 
					actionIdentifier selectRepositoryList: repositoryList.
					actionList
						selectItem:
							(actionList items
								detect: [ :action | actionIdentifier = action ]
								ifNone: [ nil ]) ]
				ifNil: [ repositoryList selectItem: nil ] ]
		ifNil: [ repositoryList selectItem: nil ].
	self updateReplacementList.

]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateActionButtons [

	(self repository notNil and: [ self repository isModifiable ])
		ifTrue: [ 
			| selected |
			selected := actionList selection selectedItem notNil.
			addActionButton enable.
			removeActionButton enabled: selected.
			editActionButton enabled: selected ]
		ifFalse: [ 
			addActionButton disable.
			removeActionButton disable.
			editActionButton disable ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateActionList [
	actionList
		items:
			(self repository
				ifNotNil: [ :repository | repository actionIdentifiers ]
				ifNil: [ #() ])
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
			 ifNotNil: [ :taskDefinition | taskDefinition propertyBinds ]
			 ifNil: [ Array new ])
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateRepositoryList [
	repositoryList items: self repositories
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

	self actionIdentifier ifNotNil: [ :actionIdentifier | 
		self taskDefinition
			ifNil: [ 
				self taskDefinition: (RMDTaskDefinitionNode
						 subjectIdentifier: self agentName
						 verbIdentifier:
							 (verbIdentifierField text asString trim ifEmpty: [ 
								  actionIdentifier shortName ])
						 objectIdentifier:
						 (objectIdentifierField text asString trim ifEmpty: [ nil ])
						 actionIdentifier: actionIdentifier
						 nearest: nearestCheckBox state
						 within: rangeField lastValidSyntaxNode
						 guard: nil
						 propertyBinds: Array new) ]
			ifNotNil: [ :taskDefinition | 
				taskDefinition actionIdentifier: actionIdentifier.
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

	self actionIdentifier
		ifNotNil: [ :actionIdentifier | 
			templateText syntaxNode:
				(actionIdentifier resolveWith: simulationModel) ]
		ifNil: [ templateText text: '' ]
]

{ #category : #updating }
RMDTaskDefinitionBrowser >> updateVerbIdentifierField [

	verbIdentifierField text asString trim ifEmpty: [ 
		self taskDefinition ifNotNil: [ :taskDefinition | 
			verbIdentifierField text:
				(taskDefinition verbIdentifier ifNil: [ String new ]) ] ]
]
