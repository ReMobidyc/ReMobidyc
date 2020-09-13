Class {
	#name : #RMDSimulationRunner,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'views',
		'runButton',
		'process',
		'visualizer',
		'stepButton',
		'timeLabel',
		'timeSlider'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDSimulationRunner class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #stepButton expand: false;
				add: #runButton expand: false;
				add:
					(SpBoxLayout newVertical
						add: #timeLabel;
						add: #timeSlider;
						yourself);
				yourself)
			height: self buttonHeight;
		add: #views yourself
]

{ #category : #'instance creation' }
RMDSimulationRunner class >> interpreter: aRMDInterpreter [
	^ self new
		setInterpreter: aRMDInterpreter;
		yourself
]

{ #category : #examples }
RMDSimulationRunner class >> sugarScape [
	<script: 'RMDSimulationRunner sugarScape openWithSpec'>
	^ self interpreter: RMDInterpreter sugarScape
]

{ #category : #api }
RMDSimulationRunner >> forceKill [
	self runState: false.
	process ifNotNil: #terminate
]

{ #category : #initialization }
RMDSimulationRunner >> initializePresenters [
	super initializePresenters.
	views := self newNotebook.
	timeLabel := self newLabel
		label: '0';
		yourself.
	timeSlider := self newSlider
		min: 0;
		max: 1;
		value: 0;
		enabled: false;
		yourself.
	runButton := self newButton
		label: 'run';
		action: [ self runState: self runState not ];
		state: false;
		whenStateChangedDo: [ :state | 
			state == true
				ifTrue: [ process := [ stepButton enabled: false.
					[ self runState == true ]
						whileTrue: [ interpreter
								ifNotNil: [ interpreter stepSimulation
										ifFalse: [ self runState: false ].
									0 milliSecond wait ] ].
					process := nil.
					stepButton enabled: true ]
						forkAt: Processor userBackgroundPriority ] ];
		yourself.
	stepButton := self newButton
		label: 'step';
		action: [ self stepSimulation ];
		enabled: true;
		yourself
]

{ #category : #initialization }
RMDSimulationRunner >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Re:Mobidyc - Simulation Runner';
		initialExtent: 800 @ 600
]

{ #category : #api }
RMDSimulationRunner >> resetSimulation [
	interpreter setupSimulation
]

{ #category : #api }
RMDSimulationRunner >> runState [
	^ runButton state == true
]

{ #category : #api }
RMDSimulationRunner >> runState: aBoolean [
	runButton state: aBoolean = true
]

{ #category : #initialization }
RMDSimulationRunner >> setInterpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	visualizer := RMDVisualizer new.
	interpreter simulationModel
		renderersDo: [ :renderer | visualizer addRenderer: renderer ].
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateTimeLabel
		to: self.
	views
		addPage:
			(self newNotebookPage
				presenterProvider: [ visualizer asPresenter
						interpreter: interpreter;
						yourself ];
				title: 'Map').
	timeSlider
		min: 0.0;
		max:
			(interpreter simulationModel simulationDefinition timeDefinition
				duration evalIn: interpreter).
	self updateTimeLabel
]

{ #category : #api }
RMDSimulationRunner >> stepSimulation [
	self runState: false.
	[ process isNil or: [ process isTerminated ] ]
		whileFalse: [ 1 milliSecond wait ].
	interpreter stepSimulation
]

{ #category : #api }
RMDSimulationRunner >> toggleRunPauseSimulation [
	self runState: self runState not
]

{ #category : #updating }
RMDSimulationRunner >> updateTimeLabel [
	interpreter
		ifNotNil: [ timeLabel
				label:
					(String
						streamContents: [ :stream | 
							4 timesRepeat: [ stream space ].
							interpreter simulationModel simulationDefinition timeDefinition
								printOn: stream.
							stream nextPutAll: ' - now '.
							(interpreter simulationDefinition timeDefinition duration type
								fromSI: interpreter time)
								printOn: stream
								showingDecimalPlaces: 3.
							stream nextPutAll: ' [ '.
							interpreter simulationDefinition timeDefinition duration type
								printOn: stream.
							stream nextPutAll: ' ]' ]).
			timeSlider value: (timeSlider scaleValue: interpreter time) ]
]
