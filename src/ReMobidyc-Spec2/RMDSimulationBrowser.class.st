Class {
	#name : #RMDSimulationBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'views',
		'resetButton',
		'runButton',
		'time',
		'process',
		'timeUnit',
		'actionBrowser',
		'behaviorBrowser',
		'animatBrowser',
		'simulationDefinition',
		'visualizer'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDSimulationBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #time width: 100;
				add: #timeUnit width: 60;
				add: #resetButton expand: false;
				add: #runButton expand: false)
			height: self buttonHeight;
		add: #views
		yourself
]

{ #category : #examples }
RMDSimulationBrowser class >> exampleSugarScape [
	^ (RMDSimulationBrowser
		on: RMDInterpreter sugarScape
		visualizer: RMDVisualizer sugarScape) openWithSpec
]

{ #category : #'instance creation' }
RMDSimulationBrowser class >> on: aRMDInterpreter visualizer: aRMDVisualizer [
	^ self new
		setInterpreter: aRMDInterpreter visualizer: aRMDVisualizer;
		yourself
]

{ #category : #private }
RMDSimulationBrowser >> addAnimatPages [
	interpreter animatNames
		do: [ :animat | 
			views
				addPage:
					(self newNotebookPage
						presenterProvider: [ RMDAnimatDefinitionBrowser
								on: interpreter
								visualizer: visualizer
								animat: animat ];
						title: animat) ]
]

{ #category : #private }
RMDSimulationBrowser >> addCellPage [
	views
		addPage:
			(self newNotebookPage
				presenterProvider:
						[ RMDCellDefinitionBrowser on: interpreter visualizer: visualizer ];
				title: 'Cell')
]

{ #category : #private }
RMDSimulationBrowser >> addVisualizerPage [
	views
		addPage:
			(self newNotebookPage
				presenterProvider: [ visualizer asPresenter
						interpreter: interpreter;
						yourself ];
				title: 'Visualization')
]

{ #category : #private }
RMDSimulationBrowser >> addWorldPage [
	views
		addPage:
			(self newNotebookPage
				presenterProvider:
						[ RMDWorldDefinitionBrowser on: interpreter visualizer: visualizer ];
				title: 'World')
]

{ #category : #api }
RMDSimulationBrowser >> forceKill [
	self runState: false.
	process ifNotNil: #terminate
]

{ #category : #initialization }
RMDSimulationBrowser >> initialize [
	super initialize.

]

{ #category : #initialization }
RMDSimulationBrowser >> initializePresenters [
	super initializePresenters.
	views := self newNotebook
		addPage:
			(self newNotebookPage
				presenterProvider: [ simulationDefinition := RMDSimulationDefinitionPresenter
						on: (interpreter ifNotNil: #simulationDefinition) ];
				title: 'Conditions');
		yourself.
	time := self newLabel
		label: '0';
		yourself.
	timeUnit := self newLabel
		label: '[]';
		yourself.
	runButton := self newButton
		label: 'run';
		action: [ self runState: self runState not ];
		state: false;
		whenStateChangedDo: [ :state | 
			state == true
				ifTrue: [ process := [ [ self runState == true ]
						whileTrue: [ interpreter
								ifNotNil: [ interpreter stepSimulation
										ifFalse: [ self runState: false ].
									0 milliSecond wait ] ] ]
						forkAt: Processor userBackgroundPriority ] ];
		yourself.
	resetButton := self newButton
		label: 'reset';
		action: [ self resetSimulation ];
		enabled: true;
		yourself
]

{ #category : #initialization }
RMDSimulationBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Remobidyc';
		initialExtent: 800 @ 600
]

{ #category : #accessing }
RMDSimulationBrowser >> interpreter [
	^ interpreter
]

{ #category : #api }
RMDSimulationBrowser >> resetSimulation [
	interpreter setupSimulation
]

{ #category : #api }
RMDSimulationBrowser >> runState [
	^ runButton state == true
]

{ #category : #api }
RMDSimulationBrowser >> runState: aBoolean [
	runButton state: aBoolean = true
]

{ #category : #private }
RMDSimulationBrowser >> setInterpreter: aRMDInterpreter visualizer: aRMDVisualizer [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateTime
		to: self.
	self
		updateSimulationDefinition;
		updateTime;
		updateTimeUnit.
	visualizer := aRMDVisualizer.
	self
		addWorldPage;
		addCellPage;
		addAnimatPages;
		addVisualizerPage
]

{ #category : #api }
RMDSimulationBrowser >> toggleRunPauseSimulation [
	self runState: self runState not
]

{ #category : #accessing }
RMDSimulationBrowser >> updateSimulationDefinition [
	simulationDefinition
		ifNotNil: [ simulationDefinition
				node: (interpreter ifNotNil: #simulationDefinition) ]
]

{ #category : #accessing }
RMDSimulationBrowser >> updateTime [
	interpreter
		ifNotNil: [ time
				label:
					((interpreter simulationDefinition timeDefinition duration type
						fromSI: interpreter time) printShowingDecimalPlaces: 3) ]
]

{ #category : #accessing }
RMDSimulationBrowser >> updateTimeUnit [
	interpreter
		ifNotNil: [ timeUnit
				label:
					interpreter simulationDefinition timeDefinition duration type
						printString ]
]

{ #category : #'api-events' }
RMDSimulationBrowser >> whenRunStateChangedDo: aBlock [
	runButton whenStateChangedDo: aBlock
]
