Class {
	#name : #RMDLauncher,
	#superclass : #RMDRepositoryModelsBrowser,
	#instVars : [
		'modelerButton',
		'experimentariumButton',
		'observatoryButton'
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
								     add: #modelerButton width: self buttonHeight;
								     add: #experimentariumButton width: self buttonHeight;
								     add: #observatoryButton width: self buttonHeight;
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

{ #category : #initialization }
RMDLauncher >> initializePresenters [

	modelerButton := self newButton
		                 icon: self modelerIcon;
		                 action: [ self openInModeler ];
		                 help: 'Open the model in a modeler.';
		                 disable;
		                 yourself.
	experimentariumButton := self newButton
		                         icon: self experimentariumIcon;
		                         action: [ self openInExperimentarium ];
		                         help:
			                         'Run the model in an experimentarium.';
		                         disable;
		                         yourself.
	observatoryButton := self newButton
		                         icon: self observatoryIcon;
		                         action: [ self openInObservatory ];
		                         help:
			                         'Run the model in an observatory.';
		                         disable;
		                         yourself.
	super initializePresenters
]

{ #category : #operations }
RMDLauncher >> openInExperimentarium [

	self openInExperimentariumMenu openWithSpecAtPointer
]

{ #category : #operations }
RMDLauncher >> openInExperimentariumForDryRun [

	self load ifNotNil: [ :model | 
		model interpreterForDryRun openInExperimentarium ]
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
		model interpreterOnFile openInExperimentarium ]
]

{ #category : #operations }
RMDLauncher >> openInExperimentariumOnMemory [

	self load ifNotNil: [ :model | 
		model interpreterOnMemory openInExperimentarium ]
]

{ #category : #operations }
RMDLauncher >> openInModeler [
	self load ifNotNil: #openInModeler 
]

{ #category : #operations }
RMDLauncher >> openInObservatory [

	self openInObservatoryMenu openWithSpecAtPointer
]

{ #category : #operations }
RMDLauncher >> openInObservatoryForDryRun [

	self load ifNotNil: [ :model | 
		model interpreterForDryRun openInObservatory ]
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
		model interpreterOnFile openInObservatory ]
]

{ #category : #operations }
RMDLauncher >> openInObservatoryOnMemory [

	self load ifNotNil: [ :model | 
		model interpreterOnMemory openInObservatory ]
]

{ #category : #updating }
RMDLauncher >> updateButtons [

	super updateButtons.
	self item
		ifNotNil: [ 
			modelerButton enable.
			experimentariumButton enable.
			observatoryButton enable ]
		ifNil: [ 
			modelerButton disable.
			experimentariumButton disable.
			observatoryButton disable ]
]
