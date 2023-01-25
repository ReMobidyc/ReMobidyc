Class {
	#name : #RMDLauncher,
	#superclass : #RMDRepositoryModelsBrowser,
	#instVars : [
		'modelerButton',
		'observatoryButton',
		'experimentariumMenuButton',
		'experimentariumButton',
		'observatoryMenuButton',
		'modelerMenuButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDLauncher class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: (SpBoxLayout newVertical
				   add: #repositoryList expand: true;
				   add: (SpBoxLayout newHorizontal
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
								     addButton: #observatoryButton
								     dropdownButton: #observatoryMenuButton;
								     yourself)
						    expand: false;
						    yourself);
				   yourself);
		  yourself
]

{ #category : #menus }
RMDLauncher class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidycLauncher)
		parent: 'ReMobidyc';
		order: 0;
		label: 'Launcher';
		action: [ RMDLauncher new open ];
		help: 'Open a model launcher'
]

{ #category : #private }
RMDLauncher >> getRepositories [

	^ super getRepositories copyWith: RMDRunsRepository current
]

{ #category : #initialization }
RMDLauncher >> initializePresenters [

	modelerButton := self newButton
		                 icon: self modelerIcon;
		                 action: [ self openInModeler ];
		                 help: 'Open the model in a modeler.';
		                 disable;
		                 yourself.
	modelerMenuButton := self newButton
		                     icon: self dropdownIcon;
		                     action: [ self openModelerMenu ];
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

	observatoryButton := self newButton
		                     icon: self observatoryIcon;
		                     action: [ self openInObservatoryOnFile ];
		                     help: 'Run the model in an observatory.';
		                     disable;
		                     yourself.
	observatoryMenuButton := self newButton
		                         icon: self dropdownIcon;
		                         action: [ self openInObservatory ];
		                         help:
			                         'Run the model in an observatory with selected memory model.';
		                         disable;
		                         yourself.
	super initializePresenters
]

{ #category : #operations }
RMDLauncher >> openInExperimentarium [

	self repository isRunsRepository
		ifTrue: [ self openInExperimentariumOnFile ]
		ifFalse: [ self openInExperimentariumMenu openWithSpecAtPointer ]
]

{ #category : #operations }
RMDLauncher >> openInExperimentariumForDryRun [

	self load ifNotNil: [ :model | 
		model interpreterForDryRun ifNotNil: #openInExperimentarium ]
]

{ #category : #operations }
RMDLauncher >> openInExperimentariumMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Dry-run';
						  action: [ self openInExperimentariumForDryRun ] ];
				  addItem: [ :item | 
					  item
						  name: 'On memory';
						  action: [ self openInExperimentariumOnMemory ] ];
				  addItem: [ :item | 
					  item
						  name: 'On file';
						  action: [ self openInExperimentariumOnFile ] ] ];
		  yourself
]

{ #category : #operations }
RMDLauncher >> openInExperimentariumOnFile [

	self load ifNotNil: [ :model | 
		self repository isRunsRepository
			ifTrue: [ 
				(model
					 interpreterOnExistingFile: self file / 'run'
					 modelPath: self file) ifNotNil: #openInExperimentarium ]
			ifFalse: [ 
			model interpreterOnFile ifNotNil: #openInExperimentarium ] ]
]

{ #category : #operations }
RMDLauncher >> openInExperimentariumOnMemory [

	self load ifNotNil: [ :model | 
		model interpreterOnMemory ifNotNil: #openInExperimentarium ]
]

{ #category : #operations }
RMDLauncher >> openInModeler [

	self load
		ifNotNil: [ :model | 
			self repository isRunsRepository
				ifTrue: [ model openInModeler ]
				ifFalse: [ model openInModeler modelFileReference: self file ] ]
		ifNil: [ 
			self file ifNotNil: [ :fileRef | 
				(RMDModelFileTextBrowser on: fileRef) open ] ]
]

{ #category : #operations }
RMDLauncher >> openInObservatory [

	self repository isRunsRepository
		ifTrue: [ self openInObservatoryOnFile ]
		ifFalse: [ self openInObservatoryMenu openWithSpecAtPointer ]
]

{ #category : #operations }
RMDLauncher >> openInObservatoryForDryRun [

	self load ifNotNil: [ :model | 
		model interpreterForDryRun ifNotNil: #openInObservatory ]
]

{ #category : #operations }
RMDLauncher >> openInObservatoryMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Dry-run';
						  action: [ self openInObservatoryForDryRun ] ];
				  addItem: [ :item | 
					  item
						  name: 'On memory';
						  action: [ self openInObservatoryOnMemory ] ];
				  addItem: [ :item | 
					  item
						  name: 'On file';
						  action: [ self openInObservatoryOnFile ] ] ];
		  yourself
]

{ #category : #operations }
RMDLauncher >> openInObservatoryOnFile [

	self load ifNotNil: [ :model | 
		self repository isRunsRepository
			ifTrue: [ 
				(model
					 interpreterOnExistingFile: self file / 'run'
					 modelPath: self file) ifNotNil: #openInObservatory ]
			ifFalse: [ model interpreterOnFile ifNotNil: #openInObservatory ] ]
]

{ #category : #operations }
RMDLauncher >> openInObservatoryOnMemory [

	self load ifNotNil: [ :model | 
		model interpreterOnMemory ifNotNil: #openInObservatory ]
]

{ #category : #operations }
RMDLauncher >> openInTextModeler [

	self repository isRunsRepository ifFalse: [ 
		self file ifNotNil: [ :fileRef | 
			(RMDModelFileTextBrowser on: fileRef) open ] ]
]

{ #category : #operations }
RMDLauncher >> openModelerMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Modeler';
						  action: [ self openInModeler ] ];
				  addItem: [ :item | 
					  item
						  name: 'Text-based Modeler';
						  action: [ self openInTextModeler ] ] ];
		  openWithSpecAtPointer
]

{ #category : #initialization }
RMDLauncher >> title [
	^ 'Launcher'
]

{ #category : #updating }
RMDLauncher >> updateButtons [

	super updateButtons.
	self item
		ifNotNil: [ 
			modelerButton enable.
			modelerMenuButton enabled: self repository isRunsRepository not.
			experimentariumButton enable.
			experimentariumMenuButton enabled:
				self repository isRunsRepository not.
			observatoryButton enable.
			observatoryMenuButton enabled: self repository isRunsRepository not ]
		ifNil: [ 
			modelerButton disable.
			modelerMenuButton disable.
			experimentariumButton disable.
			experimentariumMenuButton disable.
			observatoryButton disable.
			observatoryMenuButton disable ]
]
