Class {
	#name : #RMDAgentDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'modeler',
		'visualizer',
		'animat',
		'rendererList',
		'addRendererButton',
		'removeRendererButton',
		'editRendererButton',
		'sourceText',
		'addTaskButton',
		'taskList',
		'editTaskButton',
		'removeTaskButton',
		'addAttributeButton',
		'editAttributeButton',
		'attributeList',
		'removeAttributeButton'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDAgentDefinitionBrowser class >> defaultLayout [

	^ SpPanedLayout newVertical
		  positionOfSlider: 0.3;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.5;
				   add: (SpBoxLayout newVertical
						    add: 'Attributes' expand: false;
						    add: #attributeList;
						    add: (SpBoxLayout newHorizontal
								     add: #addAttributeButton width: self buttonHeight;
								     add: #removeAttributeButton width: self buttonHeight;
								     add: #editAttributeButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Visualization' expand: false;
						    add: #rendererList;
						    yourself);
				   yourself);
		  add: (SpBoxLayout newVertical
				   add: 'Tasks' expand: false;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.4;
						    add: (SpBoxLayout newVertical
								     add: #taskList;
								     add: (SpBoxLayout newHorizontal
										      add: #addTaskButton width: self buttonHeight;
										      add: #removeTaskButton width: self buttonHeight;
										      add: #editTaskButton width: self buttonHeight;
										      yourself)
								     height: self buttonHeight;
								     yourself);
						    add: #sourceText);
				   yourself);
		  yourself
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addAttribute [

	| attributeNode |
	(attributeNode := RMDAttributeDeclarationNode
		                  identifier: ''
		                  unit: RMDUnit noDimension) asPresenter openDialog
		title: 'Add attribute to ' , self agentName;
		okAction: [ 
			self definitionDo: [ :definition | 
					definition attributeDeclarations:
							(definition attributeDeclarations copyWith: attributeNode).
					self addInitializerWithAttribute: attributeNode animat: animat.
					self updateAttributeList ] ]
]

{ #category : #private }
RMDAgentDefinitionBrowser >> addInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	^ self subclassResponsibility 
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addRenderer [
	^ self notYetImplemented
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addTask [

	| actionDefinitionBrowser |
	actionDefinitionBrowser := (RMDTaskDefinitionBrowser on:
			                            self simulationModel)
		                           taskDefinition: nil;
		                           agentName: self agentName;
		                           yourself.
	actionDefinitionBrowser openDialog okAction: [ 
		actionDefinitionBrowser taskDefinition ifNotNil: [ :taskDefinition | 
			self simulationModel addTaskDefinition: taskDefinition.
			self updateTaskList ] ]
]

{ #category : #accessing }
RMDAgentDefinitionBrowser >> agentName [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAgentDefinitionBrowser >> definitionDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> editAttribute [

	attributeList selection selectedItem ifNotNil: [ 
		:originalAttributeNode | 
		| newAttributeNode |
		newAttributeNode := originalAttributeNode copy.
		newAttributeNode asPresenter openDialog
			title: 'Edit attribute of ' , self agentName;
			okAction: [ 
				self definitionDo: [ :definition | 
						definition attributeDeclarations:
								((definition attributeDeclarations copyWithout:
										  originalAttributeNode) copyWith: newAttributeNode).
						self
							removeInitializerWithAttribute: originalAttributeNode
							animat: animat;
							addInitializerWithAttribute: newAttributeNode animat: animat.
						self updateAttributeList ] ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> editRenderer [
	^ self notYetImplemented
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> editTask [

	taskList selection selectedItem ifNotNil: [ :oldTaskDefinition | 
		oldTaskDefinition isTaskDefinitionNode ifTrue: [ 
			| actionDefinitionBrowser |
			actionDefinitionBrowser := (RMDTaskDefinitionBrowser on:
					                            self simulationModel)
				                           taskDefinition: oldTaskDefinition copy;
				                           agentName: self agentName;
				                           yourself.
			actionDefinitionBrowser openDialog okAction: [ 
				actionDefinitionBrowser taskDefinition ifNotNil: [ :taskDefinition | 
					self simulationModel
						removeTaskDefinition: oldTaskDefinition ifAbsent: [  ];
						addTaskDefinition: taskDefinition.
					self updateTaskList.
					taskList selectItem: taskDefinition.
					self updateSourceText ] ] ] ]
]

{ #category : #initialization }
RMDAgentDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	attributeList := self newTable
		                 beSingleSelection;
		                 beResizable;
		                 showColumnHeaders;
		                 addColumn: (SpStringTableColumn
				                  title: 'name'
				                  evaluated: [ :item | item identifier ]);
		                 addColumn:
			                 (SpStringTableColumn
				                  title: 'unit'
				                  evaluated: [ :item | 
					                  | unit |
					                  unit := item unit.
					                  unit hasDimension
						                  ifTrue: [ unit printString ]
						                  ifFalse: [ '' ] ]);
		                 whenModelChangedDo: [ 
			                 attributeList selectItem: nil ];
		                 whenSelectionChangedDo: [ 
			                 | selected |
			                 selected := attributeList selection selectedItem
				                             notNil.
			                 removeAttributeButton enabled: selected.
			                 editAttributeButton enabled: selected ];
		                 yourself.
	addAttributeButton := self newButton
		                      icon: self addIcon;
		                      action: [ self addAttribute ];
		                      help: 'Add a new attribute';
		                      yourself.
	removeAttributeButton := self newButton
		                         icon: self removeIcon;
		                         action: [ self removeAttribute ];
		                         help: 'Remove the selected attribute';
		                         disable;
		                         yourself.
	editAttributeButton := self newButton
		                       icon: self editIcon;
		                       action: [ self editAttribute ];
		                       help:
			                       'Edit the definition of the selected attribute';
		                       disable;
		                       yourself.
	rendererList := self newComponentList
		                beSingleSelection;
		                whenModelChangedDo: [ rendererList selectItem: nil ];
		                whenSelectionChangedDo: [ 
			                | selected |
			                selected := rendererList selection selectedItem
				                            notNil.
			                removeRendererButton enabled: selected.
			                editRendererButton enabled: selected ];
		                yourself.
	addRendererButton := self newButton
		                     icon: self addIcon;
		                     action: [ self addRenderer ];
		                     help: 'Add a new visualization';
		                     yourself.
	removeRendererButton := self newButton
		                        icon: self removeIcon;
		                        action: [ self removeRenderer ];
		                        help: 'Remove the selected visualization';
		                        disable;
		                        yourself.
	editRendererButton := self newButton
		                      icon: self editIcon;
		                      action: [ self editRenderer ];
		                      help: 'Edit the selected visualization';
		                      disable;
		                      yourself.
	taskList := self newTable
		            beSingleSelection;
		            beResizable;
		            addColumn:
			            (SpStringTableColumn evaluated: [ :item | 
					             item verbIdentifier ]);
		            addColumn: (SpStringTableColumn evaluated: [ :item | 
					             item objectIdentifier
						             ifNotNil: [ :o | 
							             (item nearest
								              ifTrue: [ 'nearest ' ]
								              ifFalse: [ '' ]) , o , ' within '
							             , item range printString ]
						             ifNil: [ '' ] ]);
		            whenModelChangedDo: [ taskList selectItem: nil ];
		            whenSelectionChangedDo: [ 
			            | selected |
			            selected := taskList selection selectedItem notNil.
			            removeTaskButton enabled: selected.
			            editTaskButton enabled: selected.
			            self updateSourceText ];
		            yourself.
	addTaskButton := self newButton
		                 icon: self addIcon;
		                 action: [ self addTask ];
		                 help: 'Add a new task';
		                 yourself.
	removeTaskButton := self newButton
		                    icon: self removeIcon;
		                    action: [ self removeTask ];
		                    help: 'Remove the selected task';
		                    disable;
		                    yourself.
	editTaskButton := self newButton
		                  icon: self editIcon;
		                  action: [ self editTask ];
		                  help: 'Edit the definition of the selected task';
		                  disable;
		                  yourself.
	sourceText := (self newSourceWith: RMDGrammar new actionDefinition)
		              enabled: false;
		              whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		              yourself
]

{ #category : #initialization }
RMDAgentDefinitionBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: self agentName.
	aWindowPresenter initialExtent: 800 @ 600
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeAttribute [
	attributeList selection selectedItem
		ifNotNil: [ :attributeNode | 
			(self newLabel
				label: 'OK to remove ' , attributeNode identifier , '?';
				yourself) openDialogWithSpec
				title: 'Remove attribute from ' , self agentName;
				extent: 400 @ (self class buttonHeight * 3.5);
				okAction: [ self
								definitionDo: [ :definitionNode | 
									definitionNode
										attributeDeclarations: (definitionNode attributeDeclarations copyWithout: attributeNode).
									self
										removeInitializerWithAttribute: attributeNode
										animat: animat.
									self updateAttributeList ] ] ]
]

{ #category : #private }
RMDAgentDefinitionBrowser >> removeInitializerWithAttribute: aRMDAttributeNode animat: anotherString [
	^ self subclassResponsibility 
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeRenderer [

	rendererList selection selectedItem ifNotNil: [ :rendererPresenter | 
		(self newLabel
			 label: 'OK to remove ' , rendererPresenter name , '?';
			 yourself) openDialogWithSpec
			title: 'Remove visualization from ' , self agentName;
			extent: 400 @ (self class buttonHeight * 3.5);
			okAction: [ 
				self simulationModel
					removeRenderer: rendererPresenter renderer
					ifAbsent: [  ].
				self updateRendererList ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeTask [

	taskList selection selectedItem ifNotNil: [ :taskDefinition | 
		self simulationModel
			removeTaskDefinition: taskDefinition
			ifAbsent: [ KeyNotFound signal: taskDefinition ].
		self updateTaskList ]
]

{ #category : #enumerating }
RMDAgentDefinitionBrowser >> renderersDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #private }
RMDAgentDefinitionBrowser >> setModeler: aRMDSimulationModeler [

	modeler := aRMDSimulationModeler.
	self updateAttributeList.
	self updateRendererList.
	self updateTaskList
]

{ #category : #accessing }
RMDAgentDefinitionBrowser >> simulationModel [
	^ modeler ifNotNil: #simulationModel
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateAttributeList [
	self
		definitionDo: [ :definition | attributeList items: definition attributeDeclarations ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateRendererList [

	rendererList items: (Array streamContents: [ :stream | 
			 self renderersDo: [ :renderer | 
				 stream
					 nextPut: renderer asPresenter disableAgentFields;
					 yourself ] ]).
	rendererList items do: [ :item | 
		item withWidgetDo: [ :w | w update: #color: with: { Color white } ] ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateSourceText [

	self simulationModel ifNotNil: [ :model | 
		taskList selection selectedItem
			ifNotNil: [ :taskDefinition | 
				| highlights |
				highlights := Set new: 10.
				[ 
				[ model typecheck: taskDefinition ]
					on: RMDTypeError
					do: [ :ex | 
						highlights add: ex ast.
						ex resume: ex unit ] ]
					on: RMDUnresolvedReferenceError
					do: [ :ex | highlights add: ex ast ].
				sourceText highlights: highlights.
				sourceText text:
					(taskDefinition actionWith: model) printString asText ]
			ifNil: [ sourceText text: '' ] ]
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateTaskList [

	self simulationModel ifNotNil: [ :model | 
		| selectedBehavior |
		selectedBehavior := taskList selection selectedItem.
		taskList
			items: (model taskDefinitions select: [ :behavior | 
						 behavior subjectIdentifier = self agentName ]);
			selectItem: selectedBehavior ]
]
