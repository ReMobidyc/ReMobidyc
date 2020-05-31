Class {
	#name : #RMDInterpreterPresenter,
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
		'behaviorBrowser'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDInterpreterPresenter class >> defaultSpec [
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
RMDInterpreterPresenter class >> exampleSugarScape [
	^ RMDInterpreter sugarScape asPresenter
		addVisualizer: RMDVisualizer sugarScape;
		openWithSpec
]

{ #category : #'instance creation' }
RMDInterpreterPresenter class >> on: aRMDInterpreter [
	^ self new
		interpreter: aRMDInterpreter;
		yourself
]

{ #category : #api }
RMDInterpreterPresenter >> addVisualizer: aRMDVisualizer [
	views
		addPage:
			(self newNotebookPage
				presenterProvider: [ aRMDVisualizer asPresenter
						interpreter: interpreter;
						yourself ];
				title: 'Visualization')
]

{ #category : #api }
RMDInterpreterPresenter >> forceKill [
	self runState: false.
	process ifNotNil: #terminate
]

{ #category : #initialization }
RMDInterpreterPresenter >> initialize [
	super initialize.

]

{ #category : #initialization }
RMDInterpreterPresenter >> initializePresenters [
	super initializePresenters.
	views := self newNotebook
		addPage:
			(self newNotebookPage
				presenterProvider: [ behaviorBrowser := RMDBehaviorBrowser on: interpreter ];
				title: 'Behaviors');
		addPage:
			(self newNotebookPage
				presenterProvider: [ actionBrowser := RMDActionBrowser on: interpreter ];
				title: 'Actions');
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
									10 milliSecond wait ] ] ]
						forkAt: Processor userBackgroundPriority ] ];
		yourself.
	resetButton := self newButton
		label: 'reset';
		action: [ self resetSimulation ];
		enabled: true;
		yourself
]

{ #category : #accessing }
RMDInterpreterPresenter >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDInterpreterPresenter >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateTime
		to: self.
	self interpreterChanged
]

{ #category : #accessing }
RMDInterpreterPresenter >> interpreterChanged [
	self
		updateActionBrowser;
		updateTime;
		updateTimeUnit
]

{ #category : #api }
RMDInterpreterPresenter >> resetSimulation [
	interpreter setupSimulation
]

{ #category : #api }
RMDInterpreterPresenter >> runState [
	^ runButton state == true
]

{ #category : #api }
RMDInterpreterPresenter >> runState: aBoolean [
	runButton state: aBoolean = true
]

{ #category : #api }
RMDInterpreterPresenter >> toggleRunPauseSimulation [
	self runState: self runState not
]

{ #category : #accessing }
RMDInterpreterPresenter >> updateActionBrowser [
	actionBrowser ifNotNil: [ actionBrowser interpreter: interpreter ]
]

{ #category : #accessing }
RMDInterpreterPresenter >> updateTime [
	interpreter
		ifNotNil: [ time
				label:
					((interpreter simulationDefinition timeDefinition duration type
						fromSI: interpreter time) printShowingDecimalPlaces: 3) ]
]

{ #category : #accessing }
RMDInterpreterPresenter >> updateTimeUnit [
	interpreter
		ifNotNil: [ timeUnit
				label:
					interpreter simulationDefinition timeDefinition duration type
						printString ]
]

{ #category : #'api-events' }
RMDInterpreterPresenter >> whenRunStateChangedDo: aBlock [
	runButton whenStateChangedDo: aBlock
]
