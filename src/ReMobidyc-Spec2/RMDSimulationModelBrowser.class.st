Class {
	#name : #RMDSimulationModelBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'views',
		'runButton',
		'simulationDefinitionPresenter'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDSimulationModelBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #runButton height: self buttonHeight;
		add: #views yourself
]

{ #category : #'instance creation' }
RMDSimulationModelBrowser class >> on: aRMDSimulationModel [
	^ self new
		setSimulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #examples }
RMDSimulationModelBrowser class >> sugarScape [
	<script: 'RMDSimulationModelBrowser sugarScape openWithSpec'>
	^ RMDSimulationModelBrowser on: RMDSimulationModel sugarScape
]

{ #category : #private }
RMDSimulationModelBrowser >> addAnimatPages [
	simulationModel animatNames
		do: [ :animat | 
			views
				addPage:
					(self newNotebookPage
						presenterProvider:
								[ RMDAnimatDefinitionBrowser on: simulationModel animat: animat ];
						title: animat) ]
]

{ #category : #private }
RMDSimulationModelBrowser >> addCellPage [
	views
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDCellDefinitionBrowser on: simulationModel ];
				title: 'Cell')
]

{ #category : #private }
RMDSimulationModelBrowser >> addWorldPage [
	views
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDWorldDefinitionBrowser on: simulationModel ];
				title: 'World')
]

{ #category : #initialization }
RMDSimulationModelBrowser >> initialize [
	super initialize.

]

{ #category : #initialization }
RMDSimulationModelBrowser >> initializePresenters [
	super initializePresenters.
	views := self newNotebook
		addPage:
			(self newNotebookPage
				presenterProvider: [ simulationDefinitionPresenter := RMDSimulationDefinitionPresenter
						on: (simulationModel ifNotNil: #simulationDefinition) ];
				title: 'Time & Space');
		yourself.
	runButton := self newButton
		label: 'run';
		action: [ self openSimulationRunner ];
		state: false;
		yourself
]

{ #category : #initialization }
RMDSimulationModelBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Re:Mobidyc - Simulation Modeler';
		initialExtent: 800 @ 600
]

{ #category : #api }
RMDSimulationModelBrowser >> openSimulationRunner [
	| interpreter |
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		simulationModel: RMDSimulationModel sugarScape;
		yourself.
	interpreter setupSimulation.
	^ (RMDSimulationRunner interpreter: interpreter)
		openWithSpec;
		yourself
]

{ #category : #private }
RMDSimulationModelBrowser >> setSimulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel.
	simulationDefinitionPresenter
		ifNotNil: [ simulationDefinitionPresenter
				node: (simulationModel ifNotNil: #simulationDefinition) ].
	self
		addWorldPage;
		addCellPage;
		addAnimatPages
]

{ #category : #'api-events' }
RMDSimulationModelBrowser >> whenRunStateChangedDo: aBlock [
	runButton whenStateChangedDo: aBlock
]
