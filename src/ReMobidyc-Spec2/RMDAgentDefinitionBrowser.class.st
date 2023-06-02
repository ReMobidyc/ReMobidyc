Class {
	#name : #RMDAgentDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'modeler',
		'animat',
		'attributeList',
		'addAttributeButton',
		'removeAttributeButton',
		'moveUpAttributeButton',
		'moveDownAttributeButton',
		'editAttributeButton',
		'utilityList',
		'addUtilityButton',
		'removeUtilityButton',
		'moveUpUtilityButton',
		'moveDownUtilityButton',
		'editUtilityButton',
		'rendererList',
		'addRendererButton',
		'removeRendererButton',
		'editRendererButton',
		'sourceText',
		'taskList',
		'addTaskButton',
		'removeTaskButton',
		'moveUpTaskButton',
		'moveDownTaskButton',
		'editTaskButton'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDAgentDefinitionBrowser class >> defaultLayout [

	^ SpPanedLayout newVertical
		  positionOfSlider: 0.4;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.6;
				   add: (SpBoxLayout newVertical
						    add: 'Attributes' expand: false;
						    add: #attributeList;
						    add: (SpBoxLayout newHorizontal
								     add: #addAttributeButton width: self buttonHeight;
								     add: #removeAttributeButton width: self buttonHeight;
								     add: #moveUpAttributeButton width: self buttonHeight;
								     add: #moveDownAttributeButton width: self buttonHeight;
								     add: #editAttributeButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'where' expand: false;
						    add: #utilityList;
						    add: (SpBoxLayout newHorizontal
								     add: #addUtilityButton width: self buttonHeight;
								     add: #removeUtilityButton width: self buttonHeight;
								     add: #moveUpUtilityButton width: self buttonHeight;
								     add: #moveDownUtilityButton width: self buttonHeight;
								     add: #editUtilityButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   yourself);
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.75;
				   add: (SpBoxLayout newVertical
						    add: 'Tasks' expand: false;
						    add: (SpPanedLayout newHorizontal
								     positionOfSlider: 0.3;
								     add: (SpBoxLayout newVertical
										      add: #taskList;
										      add: (SpBoxLayout newHorizontal
												       add: #addTaskButton width: self buttonHeight;
												       add: #removeTaskButton width: self buttonHeight;
												       add: #moveUpTaskButton width: self buttonHeight;
												       add: #moveDownTaskButton width: self buttonHeight;
												       add: #editTaskButton width: self buttonHeight;
												       yourself)
										      height: self buttonHeight;
										      yourself);
								     add: #sourceText);
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Visualization' expand: false;
						    add: #rendererList;
						    add: (SpBoxLayout newHorizontal
								     add: #addRendererButton width: self buttonHeight;
								     add: #removeRendererButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   yourself) yourself
]

{ #category : #testing }
RMDAgentDefinitionBrowser class >> isAbstract [

	^ self = RMDAgentDefinitionBrowser
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> addAttribute [

	| attributeNode |
	((attributeNode := RMDAttributeDeclarationNode
		                   identifier: ''
		                   unit: RMDUnit noDimension) asPresenter
		 simulationModel: self simulationModel;
		 agentName: self agentName;
		 utilities: self agentDefinition utilityDefinitions;
		 yourself) openDialog
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

	self addRendererMenu openWithSpecAtPointer
]

{ #category : #menus }
RMDAgentDefinitionBrowser >> addRenderer: aRMDRenderer [

	modeler simulationModel addRenderer: aRMDRenderer.
	self updateRendererList
]

{ #category : #menus }
RMDAgentDefinitionBrowser >> addRendererMenu [

	^ self subclassResponsibility
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

{ #category : #operations }
RMDAgentDefinitionBrowser >> addUtility [

	| newDefinition |
	newDefinition := RMDUtilityDefinitionNode template.
	newDefinition asPresenter openDialog okAction: [ 
		self definitionDo: [ :definition | 
			definition utilityDefinitions:
				(definition utilityDefinitions copyWith: newDefinition).
			self updateUtilityList ] ]
]

{ #category : #accessing }
RMDAgentDefinitionBrowser >> agentDefinition [

	^ self simulationModel ifNotNil: [ :model |
		  model agentDefinitionAt: self agentName ifAbsent: [ nil ] ]
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
		(newAttributeNode asPresenter
			 simulationModel: self simulationModel;
			 agentName: self agentName;
			 utilities: self agentDefinition utilityDefinitions;
			 yourself) openDialog
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

{ #category : #operations }
RMDAgentDefinitionBrowser >> editUtility [

	utilityList selectedItem ifNotNil: [ :oldDefinition | 
		| newDefinition index |
		newDefinition := oldDefinition copy.
		newDefinition asPresenter openDialog okAction: [ 
			self definitionDo: [ :definition | 
				definition utilityDefinitions
					at:
					(index := definition utilityDefinitions indexOf: oldDefinition)
					put: newDefinition.
				self updateUtilityList.
				utilityList selectIndex: index ] ] ]
]

{ #category : #initialization }
RMDAgentDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	attributeList := self newTable
		                 beSingleSelection;
		                 beResizable;
		                 showColumnHeaders;
		                 addColumn: ((SpStringTableColumn
				                   title: 'name'
				                   evaluated: [ :item | item identifier ])
				                  width: 150;
				                  yourself);
		                 addColumn:
			                 ((SpStringTableColumn
				                   title: 'unit'
				                   evaluated: [ :item |
					                   | unit |
					                   unit := item unit.
					                   unit hasDimension
						                   ifTrue: [ unit printString ]
						                   ifFalse: [ '' ] ])
				                  width: 100;
				                  yourself);
		                 addColumn:
			                 (SpStringTableColumn
				                  title: 'initial value'
				                  evaluated: [ :item |
					                  | expr |
					                  expr := item initializerExpression.
					                  expr
						                  ifNotNil: [ expr printString ]
						                  ifNil: [ '' ] ]);
		                 whenModelChangedDo: [
		                 attributeList selectItem: nil ];
		                 whenSelectionChangedDo: [
			                 | selected index |
			                 selected := attributeList selection selectedItem
				                             notNil.
			                 index := attributeList selection selectedIndex.
			                 removeAttributeButton enabled: selected.
			                 moveUpAttributeButton enabled:
				                 (selected and: [ index > 1 ]).
			                 moveDownAttributeButton enabled:
				                 (selected and: [
					                  index < attributeList items size ]).
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
	moveUpAttributeButton := self newButton
		                         icon: self upIcon;
		                         action: [ self moveUpAttribute ];
		                         help: 'Move the selected attribute up';
		                         disable;
		                         yourself.
	moveDownAttributeButton := self newButton
		                           icon: self downIcon;
		                           action: [ self moveDownAttribute ];
		                           help: 'Move the selected attribute down';
		                           disable;
		                           yourself.
	editAttributeButton := self newButton
		                       icon: self editIcon;
		                       action: [ self editAttribute ];
		                       help:
			                       'Edit the definition of the selected attribute';
		                       disable;
		                       yourself.
	utilityList := self newTable
		               beSingleSelection;
		               beResizable;
		               showColumnHeaders;
		               addColumn: ((SpStringTableColumn
				                 title: 'name'
				                 evaluated: [ :item | item variable identifier ])
				                width: 150;
				                yourself);
		               addColumn:
			               (SpStringTableColumn
				                title: 'value'
				                evaluated: [ :item |
					                | expr |
					                expr := item definitionBody.
					                expr ifNotNil: [ expr printString ] ifNil: [ '' ] ]);
		               whenModelChangedDo: [ utilityList selectItem: nil ];
		               whenSelectionChangedDo: [
			               | selected index |
			               selected := utilityList selection selectedItem
				                           notNil.
			               index := utilityList selection selectedIndex.
			               removeUtilityButton enabled: selected.
			               moveUpUtilityButton enabled:
				               (selected and: [ index > 1 ]).
			               moveDownUtilityButton enabled:
				               (selected and: [ index < utilityList items size ]).
			               editUtilityButton enabled: selected ];
		               yourself.
	addUtilityButton := self newButton
		                    icon: self addIcon;
		                    action: [ self addUtility ];
		                    help: 'Add a new utility definition';
		                    yourself.
	removeUtilityButton := self newButton
		                       icon: self removeIcon;
		                       action: [ self removeUtility ];
		                       help:
			                       'Remove the selected utility definition';
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
		                     icon: self editIcon;
		                     action: [ self editUtility ];
		                     help:
			                     'Edit the definition of the selected utility definition';
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
		            addColumn: (SpStringTableColumn
				             title: 'verb'
				             evaluated: [ :item | item verbIdentifier ]);
		            addColumn:
			            (SpStringTableColumn
				             title: 'object'
				             evaluated: [ :item |
					             item objectIdentifier
						             ifNotNil: [ :o |
							             (item nearest
								              ifTrue: [ 'nearest ' ]
								              ifFalse: [ '' ]) , o , ' within '
							             , item range printString ]
						             ifNil: [ '' ] ]);
		            addColumn: ((SpCheckBoxTableColumn
				              title: ''
				              evaluated: [ :item | item enabled ])
				             beNotExpandable;
				             onActivation: #beEnabled;
				             onDeactivation: #beDisabled);
		            whenModelChangedDo: [ taskList selectItem: nil ];
		            whenSelectionChangedDo: [
			            | selected index |
			            selected := taskList selection selectedItem notNil.
			            index := taskList selection selectedIndex.
			            removeTaskButton enabled: selected.
			            moveUpTaskButton enabled: (selected and: [ index > 1 ]).
			            moveDownTaskButton enabled:
				            (selected and: [ index < taskList items size ]).
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
	moveUpTaskButton := self newButton
		                    icon: self upIcon;
		                    action: [ self moveUpTask ];
		                    help: 'Move the selected task up';
		                    disable;
		                    yourself.
	moveDownTaskButton := self newButton
		                      icon: self downIcon;
		                      action: [ self moveDownTask ];
		                      help: 'Move the selected task down';
		                      disable;
		                      yourself.
	editTaskButton := self newButton
		                  icon: self editIcon;
		                  action: [ self editTask ];
		                  help: 'Edit the definition of the selected task';
		                  disable;
		                  yourself.
	sourceText := (self newSourceWith: RMDGrammar new actionDefinition)
		              beNotEditable;
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
RMDAgentDefinitionBrowser >> moveDownAttribute [

	attributeList selection selectedItem ifNotNil: [ :attributeNode | 
		self definitionDo: [ :definition | 
			| attributeDeclarations index |
			attributeDeclarations := definition attributeDeclarations copy.
			index := attributeDeclarations
				         indexOf: attributeNode
				         ifAbsent: attributeDeclarations size + 1.
			index <= (attributeDeclarations size - 1) ifTrue: [ 
				attributeDeclarations
					at: index
					put: (attributeDeclarations at: index + 1).
				attributeDeclarations at: index + 1 put: attributeNode.
				definition attributeDeclarations: attributeDeclarations.
				self updateAttributeList.
				attributeList selectIndex: index + 1 ] ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> moveDownTask [

	self simulationModel ifNotNil: [ :simulationModel | 
		| tasks selectionIndex |
		tasks := taskList items.
		selectionIndex := taskList selection selectedIndex.
		(selectionIndex between: 1 and: tasks size - 1) ifTrue: [ 
			simulationModel
				swapTasks: (tasks at: selectionIndex)
				and: (tasks at: selectionIndex + 1).
			self updateTaskList.
			taskList selectIndex: selectionIndex + 1 ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> moveDownUtility [

	utilityList selection selectedItem ifNotNil: [ :utilityNode | 
		self definitionDo: [ :definition | 
			| utilityDeclarations index |
			utilityDeclarations := definition utilityDefinitions copy.
			index := utilityDeclarations
				         indexOf: utilityNode
				         ifAbsent: utilityDeclarations size + 1.
			index <= (utilityDeclarations size - 1) ifTrue: [ 
				utilityDeclarations
					at: index
					put: (utilityDeclarations at: index + 1).
				utilityDeclarations at: index + 1 put: utilityNode.
				definition utilityDefinitions: utilityDeclarations.
				self updateUtilityList.
				utilityList selectIndex: index + 1 ] ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> moveUpAttribute [

	attributeList selection selectedItem ifNotNil: [ :attributeNode | 
		self definitionDo: [ :definition | 
			| attributeDeclarations index |
			attributeDeclarations := definition attributeDeclarations copy.
			index := attributeDeclarations indexOf: attributeNode ifAbsent: 0.
			index >= 2 ifTrue: [ 
				attributeDeclarations
					at: index
					put: (attributeDeclarations at: index - 1).
				attributeDeclarations at: index - 1 put: attributeNode.
				definition attributeDeclarations: attributeDeclarations.
				self updateAttributeList.
				attributeList selectIndex: index - 1 ] ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> moveUpTask [

	self simulationModel ifNotNil: [ :simulationModel | 
		| tasks selectionIndex |
		tasks := taskList items.
		selectionIndex := taskList selection selectedIndex.
		(selectionIndex between: 2 and: tasks size) ifTrue: [ 
			simulationModel
				swapTasks: (tasks at: selectionIndex)
				and: (tasks at: selectionIndex - 1).
			self updateTaskList.
			taskList selectIndex: selectionIndex - 1 ] ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> moveUpUtility [

	utilityList selection selectedItem ifNotNil: [ :utilityNode | 
		self definitionDo: [ :definition | 
			| utilityDefinitions index |
			utilityDefinitions := definition utilityDefinitions copy.
			index := utilityDefinitions indexOf: utilityNode ifAbsent: 0.
			index >= 2 ifTrue: [ 
				utilityDefinitions
					at: index
					put: (utilityDefinitions at: index - 1).
				utilityDefinitions at: index - 1 put: utilityNode.
				definition utilityDefinitions: utilityDefinitions.
				self updateUtilityList.
				utilityList selectIndex: index - 1 ] ] ]
]

{ #category : #widgets }
RMDAgentDefinitionBrowser >> newHighlightingSyntaxNodeTextInput [

	^ super newHighlightingSyntaxNodeTextInput
		  simulationModelBlock: [ self simulationModel ];
		  yourself
]

{ #category : #widgets }
RMDAgentDefinitionBrowser >> newSourceWith: aPP2Node [

	^ (super newSourceWith: aPP2Node)
		  simulationModelBlock: [ self simulationModel ];
		  subjectBlock: [ self agentName ];
		  objectBlock: [ 
			  taskList selection selectedItem ifNotNil: #objectIdentifier ];
		  yourself
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeAttribute [

	attributeList selection selectedItem ifNotNil: [ :attributeNode | 
		(self newLabel
			 label: 'OK to remove ' , attributeNode identifier , '?';
			 yourself) openDialog
			title: 'Remove attribute from ' , self agentName;
			extent: 400 @ (self class buttonHeight * 3.5);
			okAction: [ 
				self definitionDo: [ :definitionNode | 
					definitionNode attributeDeclarations:
						(definitionNode attributeDeclarations copyWithout: attributeNode).
					self removeInitializerWithAttribute: attributeNode animat: animat.
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
			 yourself) openDialog
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
			ifAbsent: [  ].
		self updateTaskList ]
]

{ #category : #operations }
RMDAgentDefinitionBrowser >> removeUtility [

	utilityList selectedItem ifNotNil: [ :oldDefinition | 
		(UIManager default confirm:
			 'Sure to remove `' , oldDefinition printString , '''?') ifTrue: [ 
			self definitionDo: [ :definition | 
				definition utilityDefinitions:
					(definition utilityDefinitions copyWithout: oldDefinition).
				self updateUtilityList ] ] ]
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

{ #category : #accessing }
RMDAgentDefinitionBrowser >> typechecker [

	^ self simulationModel ifNotNil: #typechecker
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateAttributeList [

	self definitionDo: [ :definition | 
		attributeList items: definition attributeDeclarations.
		definition complementUtilityDefinitions ].
	self updateUtilityList
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateRendererList [

	rendererList items: (Array streamContents: [ :stream | 
			 self renderersDo: [ :renderer | 
				 stream nextPut: (renderer asPresenter
						  simulationModel: modeler simulationModel;
						  disableAgentFields;
						  yourself) ] ])
]

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateSourceText [

	self simulationModel ifNotNil: [ :model | 
		taskList selection selectedItem
			ifNotNil: [ :taskDefinition | 
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

{ #category : #updating }
RMDAgentDefinitionBrowser >> updateUtilityList [

	self definitionDo: [ :definition | 
		utilityList items: definition utilityDefinitions ]
]
