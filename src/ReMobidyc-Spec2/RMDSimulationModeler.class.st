Class {
	#name : #RMDSimulationModeler,
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
RMDSimulationModeler class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #runButton height: self buttonHeight;
		add: #views yourself
]

{ #category : #menus }
RMDSimulationModeler class >> golapMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ReMobidyc)
		label: 're:Mobidyc';
		order: 1;
		with: [ (aBuilder item: #OpenNew)
				parent: 'ReMobidyc';
				label: 'Modeler';
				action: [ (RMDSimulationModeler on: RMDSimulationModel new) openWithSpec ];
				help: 'Open a modeler window with a new simulation model'.
			(aBuilder item: #Examples)
				parent: 'ReMobidyc';
				label: 'Examples';
				with: [ (aBuilder item: #SugarScape)
						parent: #Examples;
						label: 'sugar scape';
						action: [ RMDSimulationModeler sugarScape openWithSpec ];
						help: 'A simple simulation of an energy cycle.' ] ]
]

{ #category : #'instance creation' }
RMDSimulationModeler class >> on: aRMDSimulationModel [
	^ self new
		setSimulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #examples }
RMDSimulationModeler class >> sugarScape [
	<script: 'RMDSimulationModeler sugarScape openWithSpec'>
	^ RMDSimulationModeler on: RMDSimulationModel sugarScape
]

{ #category : #private }
RMDSimulationModeler >> addAnimatPages [
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
RMDSimulationModeler >> addCellPage [
	views
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDCellDefinitionBrowser on: simulationModel ];
				title: 'Cell')
]

{ #category : #private }
RMDSimulationModeler >> addWorldPage [
	views
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDWorldDefinitionBrowser on: simulationModel ];
				title: 'World')
]

{ #category : #initialization }
RMDSimulationModeler >> initialize [
	super initialize.

]

{ #category : #initialization }
RMDSimulationModeler >> initializePresenters [
	super initializePresenters.
	views := self newNotebook
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDScrollPresenter
						with:
							(simulationDefinitionPresenter := RMDSimulationDefinitionPresenter
								on: (simulationModel ifNotNil: #simulationDefinition)) ];
				title: 'Time & Space');
		whenSelectedPageChangedDo: [ simulationDefinitionPresenter ifNotNil: #nodeChanged ];
		yourself.
	runButton := self newButton
		label: 'run';
		action: [ self openSimulationRunner ];
		state: false;
		yourself
]

{ #category : #initialization }
RMDSimulationModeler >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Re:Mobidyc - Simulation Modeler';
		initialExtent: 800 @ 600
]

{ #category : #api }
RMDSimulationModeler >> openSimulationRunner [
	| interpreter |
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		simulationModel: simulationModel;
		yourself.
	interpreter setupSimulation.
	^ (RMDObservatory interpreter: interpreter)
		openWithSpec;
		yourself
]

{ #category : #private }
RMDSimulationModeler >> setSimulationModel: aRMDSimulationModel [
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
RMDSimulationModeler >> whenRunStateChangedDo: aBlock [
	runButton whenStateChangedDo: aBlock
]
