Class {
	#name : 'RMDLauncher',
	#superclass : 'RMDPresenter',
	#instVars : [
		'notebook'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'layout' }
RMDLauncher class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #notebook;
		  yourself
]

{ #category : 'menus' }
RMDLauncher class >> remobidycMenuOn: aBuilder [

	<remobidycMenu>
	(aBuilder item: #ReMobidycModels)
		order: 1;
		label: 'Models';
		icon: BaselineOfReMobidyc icon;
		with: [
				(aBuilder item: #ReMobidycLauncher)
					order: 1;
					label: 'Launcher';
					iconName: #open;
					action: [ RMDLauncher new open ];
					help: 'Open a model launcher' ]
]

{ #category : 'menus' }
RMDLauncher class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidycLauncher)
		parent: 'ReMobidyc';
		order: 1;
		label: 'Launcher';
		action: [ RMDLauncher new open ];
		help: 'Open a model launcher'
]

{ #category : 'initialization' }
RMDLauncher >> initializePresenters [

	super initializePresenters.
	notebook := self newNotebook
		            addPage: (SpNotebookPage
				             title: 'Folders'
				             provider: [ RMDRepositoryLauncher new ]);
		            addPage: (SpNotebookPage
				             title: 'Archives'
				             provider: [ RMDChronicleModelBrowser new ]);
		            yourself
]

{ #category : 'initialization' }
RMDLauncher >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		title: 'Launcher';
		initialExtent: 800 @ 400
]
