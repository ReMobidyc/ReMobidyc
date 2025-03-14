Class {
	#name : 'RMDRepositoryLauncher',
	#superclass : 'RMDRepositoryModelsBrowser',
	#traits : 'TRMDLaunchAnalysisTools',
	#classTraits : 'TRMDLaunchAnalysisTools classTrait',
	#instVars : [
		'modelerButton',
		'experimentariumMenuButton',
		'experimentariumButton',
		'modelerMenuButton'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'layout' }
RMDRepositoryLauncher class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: (SpBoxLayout newVertical
				   add: #repositoryList expand: true;
				   add: (SpBoxLayout newHorizontal
						    add: #updateRepositoryListButton width: self buttonHeight;
						    add: #addRepositoryButton width: self buttonHeight;
						    add: #removeRepositoryButton width: self buttonHeight;
						    add: #editRepositoryButton width: self buttonHeight;
						    yourself)
				   expand: false;
				   yourself);
		  add: (SpPanedLayout newVertical
				   add: (SpBoxLayout newVertical
						    add: #itemList;
						    add: (SpBoxLayout newHorizontal
								     add: #updateItemListButton width: self buttonHeight;
								     add: #newItemButton width: self buttonHeight;
								     add: #removeItemButton width: self buttonHeight;
								     add: #editItemButton width: self buttonHeight;
								     add: #exportItemButton width: self buttonHeight;
								     yourself)
						    expand: false;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: #descriptionText;
						    add: (SpBoxLayout newHorizontal
								     addButton: #modelerButton
								     dropdownButton: #modelerMenuButton;
								     addSpace;
								     addButton: #experimentariumButton
								     dropdownButton: #experimentariumMenuButton;
								     addSpace;
								     add: #openTabularButton width: self buttonHeight;
								     addSpace;
								     add: #openObservatoryButton width: self buttonHeight;
								     yourself)
						    expand: false;
						    yourself);
				   yourself);
		  yourself
]

{ #category : 'testing' }
RMDRepositoryLauncher >> canOpenAnalysis [

	^ self item notNil and: [ self repository isRunsRepository ]
]

{ #category : 'private' }
RMDRepositoryLauncher >> getRepositories [

	^ super getRepositories copyWith: RMDRunsRepository current
]

{ #category : 'initialization' }
RMDRepositoryLauncher >> initializePresenters [

	self initializeOpenAnalysisButtonsPresenters.
	modelerButton := self newButton
		                 icon: self modelerIcon;
		                 action: [ self openInModeler ];
		                 help: 'Open the model in a modeler.';
		                 disable;
		                 yourself.
	modelerMenuButton := self newButton
		                     icon: self dropdownIcon;
		                     action: [
			                     self openModelerMenu openWithSpecAtPointer ];
		                     help: 'Open the model in a selected modeler.';
		                     disable;
		                     yourself.
	experimentariumButton := self newButton
		                         icon: self experimentariumIcon;
		                         action: [ self openInExperimentariumOnFile ];
		                         help:
			                         'Run the model in an experimentarium.';
		                         disable;
		                         yourself.
	experimentariumMenuButton := self newButton
		                             icon: self dropdownIcon;
		                             action: [ self openInExperimentarium ];
		                             help:
			                             'Run the model in an experimentarium with selected memory model.';
		                             disable;
		                             yourself.
	super initializePresenters
]

{ #category : 'menus' }
RMDRepositoryLauncher >> itemListMenu [

	| selectedItem |
	selectedItem := self item.
	^ self newMenu
		  addGroup: [ :g |
			  g
				  addItem: [ :item |
					  item
						  name: 'Modeler';
						  icon: self modelerIcon;
						  enabled: modelerMenuButton isEnabled;
						  subMenu: self openModelerMenu ];
				  addItem: [ :item |
					  item
						  name: 'Experimentarium';
						  icon: self experimentariumIcon;
						  enabled: experimentariumMenuButton isEnabled;
						  subMenu: self openInExperimentariumMenu ];
				  addItem: [ :item |
					  item
						  name: 'Tabular';
						  icon: self tabularIcon;
						  enabled: openTabularButton isEnabled;
						  subMenu: self tabularMenu ];
				  addItem: [ :item |
					  item
						  name: 'Observatory';
						  icon: self observatoryIcon;
						  enabled: openObservatoryButton isEnabled;
						  action: [ self openInReplayObservatory ] ] ];
		  addGroup: [ :g |
			  g
				  addItem: [ :item |
					  item
						  name: 'Add...';
						  icon: self addIcon;
						  enabled: newItemButton isEnabled;
						  action: [ self addItem ] ];
				  addItem: [ :item |
					  item
						  name: 'Rename...';
						  icon: self editIcon;
						  enabled: editItemButton isEnabled;
						  action: [ self editItem ] ];
				  addItem: [ :item |
					  item
						  name: 'Remove';
						  icon: self removeIcon;
						  enabled: removeItemButton isEnabled;
						  action: [ self removeItem ] ];
				  addItem: [ :item |
					  item
						  name: 'Export...';
						  icon: self exportIcon;
						  enabled: exportItemButton isEnabled;
						  action: [ self exportItem ] ] ]
]

{ #category : 'private' }
RMDRepositoryLauncher >> metaInterpreterForTabularDo: aBlock [

	^ self load ifNotNil: [ :model | 
		  self repository isRunsRepository ifTrue: [ 
			  (model metaInterpreterOnReadOnlyModelPath: self file) ifNotNil:
				  aBlock ] ]
]

{ #category : 'operations' }
RMDRepositoryLauncher >> openInExperimentarium [

	self repository isRunsRepository
		ifTrue: [ self openInExperimentariumOnFile ]
		ifFalse: [ self openInExperimentariumMenu openWithSpecAtPointer ]
]

{ #category : 'operations' }
RMDRepositoryLauncher >> openInExperimentariumForDryRun [

	self load ifNotNil: [ :model | 
		model metaInterpreterForDryRun ifNotNil: #openInExperimentarium ]
]

{ #category : 'operations' }
RMDRepositoryLauncher >> openInExperimentariumMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Dry-run';
						  action: [ self openInExperimentariumForDryRun ] ];
				  addItem: [ :item | 
					  item
						  name: 'On file';
						  action: [ self openInExperimentariumOnFile ] ] ];
		  yourself
]

{ #category : 'operations' }
RMDRepositoryLauncher >> openInExperimentariumOnFile [

	self load ifNotNil: [ :model | 
		self repository isRunsRepository
			ifTrue: [ 
				(model metaInterpreterOnModelPath: self file) ifNotNil:
					#openInExperimentarium ]
			ifFalse: [ 
			model metaInterpreterOnFile ifNotNil: #openInExperimentarium ] ]
]

{ #category : 'operations' }
RMDRepositoryLauncher >> openInModeler [

	self load
		ifNotNil: [ :model | 
			self repository isRunsRepository
				ifTrue: [ model openInModeler ]
				ifFalse: [ model openInModeler modelFileReference: self file ] ]
		ifNil: [ 
			self file ifNotNil: [ :fileRef | 
				(RMDModelFileTextBrowser on: fileRef) open ] ]
]

{ #category : 'operations' }
RMDRepositoryLauncher >> openInTextModeler [

	self repository isRunsRepository ifFalse: [ 
		self file ifNotNil: [ :fileRef | 
			(RMDModelFileTextBrowser on: fileRef) open ] ]
]

{ #category : 'operations' }
RMDRepositoryLauncher >> openModelerMenu [

	^ self newMenu addGroup: [ :group |
		  group
			  addItem: [ :item |
				  item
					  name: 'Modeler';
					  action: [ self openInModeler ] ];
			  addItem: [ :item |
				  item
					  name: 'Text-based Modeler';
					  action: [ self openInTextModeler ] ] ]
]

{ #category : 'operations' }
RMDRepositoryLauncher >> removeItem [

	| items |
	self repository ifNotNil: [ :repo | 
		(self repository isRunsRepository and: [ 
			 items := itemList selectedItems.
			 items size > 1 ])
			ifTrue: [ 
				(UIManager default confirm:
					 'Remove ' , items size printString , ' runs from ' , repo name
					 , ' repository?') ifTrue: [ 
					Cursor wait showWhile: [ 
						items do: [ :item | repo removeModelNamed: item ifAbsent: [  ] ] ].
					self updateItemList ] ]
			ifFalse: [ super removeItem ] ]
]

{ #category : 'accessing' }
RMDRepositoryLauncher >> selectedIndividual [

	^ nil
]

{ #category : 'accessing' }
RMDRepositoryLauncher >> selectedRunId [

	^ nil
]

{ #category : 'accessing' }
RMDRepositoryLauncher >> selectedTime [

	^ nil
]

{ #category : 'initialization' }
RMDRepositoryLauncher >> title [
	^ 'Launcher'
]

{ #category : 'updating' }
RMDRepositoryLauncher >> updateButtons [

	super updateButtons.
	self item
		ifNotNil: [ 
			modelerButton enable.
			modelerMenuButton enabled: self repository isRunsRepository not.
			experimentariumButton enable.
			experimentariumMenuButton enabled:
				self repository isRunsRepository not ]
		ifNil: [ 
			modelerButton disable.
			modelerMenuButton disable.
			experimentariumButton disable.
			experimentariumMenuButton disable ].
	self updateOpenAnalysisButtons
]

{ #category : 'updating' }
RMDRepositoryLauncher >> updateItemList [

	super updateItemList.
	self repository ifNotNil: [ :repo | 
		repo isRunsRepository
			ifTrue: [ 
				itemList beMultipleSelection.
				itemList withAdapterDo: [ :a | 
					a widgetDo: [ :w | w beMultipleSelection ] ] ]
			ifFalse: [ 
				itemList beSingleSelection.
				itemList withAdapterDo: [ :a | 
					a widgetDo: [ :w | w beSingleSelection ] ] ] ]
]
