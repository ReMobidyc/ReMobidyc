Class {
	#name : #RMDExperimentarium,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'stepButton',
		'runButton',
		'timeProgressBar',
		'populationInspector',
		'validated',
		'lastServerUpdate',
		'lastDisplayUpdate'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDExperimentarium class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: #stepButton expand: false;
				   add: #runButton expand: false;
				   add: #timeProgressBar expand: true;
				   yourself)
		  height: self buttonHeight * 2;
		  add: #populationInspector;
		  yourself
]

{ #category : #'instance creation' }
RMDExperimentarium class >> interpreter: aRMDInterpreter [
	^ self new
		setInterpreter: aRMDInterpreter;
		yourself
]

{ #category : #updating }
RMDExperimentarium >> basicInformServer [

	lastServerUpdate := DateAndTime now.
	Smalltalk at: #RMDClient ifPresent: [ :clientClass | 
		clientClass
			informModel: self modelName
			progress: interpreter progress
			from: self ]
]

{ #category : #updating }
RMDExperimentarium >> basicUpdateTimeProgressBar [

	interpreter ifNotNil: [ 
		timeProgressBar fixedAt: interpreter progress ]
]

{ #category : #controlling }
RMDExperimentarium >> ifValidated: aBlock [

	^ validated = true ifTrue: [ aBlock cull: self ]
]

{ #category : #updating }
RMDExperimentarium >> informServer [
	(lastServerUpdate isNil
		or: [ DateAndTime now - lastServerUpdate >= self serverUpdateInterval ])
		ifTrue: [ self basicInformServer ]
]

{ #category : #initialization }
RMDExperimentarium >> initialize [

	super initialize.
	validated := false
]

{ #category : #initialization }
RMDExperimentarium >> initializePresenters [

	super initializePresenters.
	timeProgressBar := self newProgressBar
		                   fixedAt: 0.0;
		                   yourself.
	runButton := self newButton
		             icon: self runIcon;
		             action: [ self runButtonPressed ];
		             help: 'Run the simulation to the end';
		             state: false;
		             yourself.
	stepButton := self newButton
		              icon: self stepIcon;
		              action: [ self stepSimulation ];
		              help: 'Run the simulation just one step forward';
		              enabled: true;
		              yourself.
	populationInspector := self instantiate: RMDPopulationInspector
]

{ #category : #initialization }
RMDExperimentarium >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: self windowTitle;
		initialExtent: 700 @ 450
]

{ #category : #api }
RMDExperimentarium >> isRunningSimulation [

	^ interpreter isRunningSimulation
]

{ #category : #testing }
RMDExperimentarium >> isValidated [
	^ validated = true
]

{ #category : #accessing }
RMDExperimentarium >> modelName [

	^ interpreter
		  ifNotNil: [ interpreter simulationModel name ]
		  ifNil: [ 'noname' ]
]

{ #category : #api }
RMDExperimentarium >> pauseSimulation [

	interpreter pauseSimulation
]

{ #category : #updating }
RMDExperimentarium >> runButtonPressed [

	interpreter isRunningSimulation
		ifTrue: [ self pauseSimulation ]
		ifFalse: [ self runSimulation ]
]

{ #category : #api }
RMDExperimentarium >> runSimulation [

	self isValidated ifTrue: [ 
		interpreter runSimulationOnError: [ :ex | 
			(RMDActionDebugger on: interpreter exception: ex) open ] ]
]

{ #category : #accessing }
RMDExperimentarium >> serverUpdateInterval [
	^ 10 seconds
]

{ #category : #initialization }
RMDExperimentarium >> setInterpreter: aRMDInterpreter [

	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	self typecheck.
	populationInspector interpreter: interpreter.
	interpreter announcer weak
		when: RMDSimulationStarted send: #simulationStarted: to: self;
		when: RMDTimeChanged send: #timeChanged: to: self;
		when: RMDSimulationPaused send: #simulationPaused: to: self.
	self isValidated ifTrue: [ 
		interpreter
			setupSimulation;
			fastForward ]
]

{ #category : #updating }
RMDExperimentarium >> simulationPaused: aRMDSimulationPaused [

	runButton state: false.
	stepButton enable.
	self updateTimeProgressBar.
	lastDisplayUpdate := nil
]

{ #category : #updating }
RMDExperimentarium >> simulationStarted: aRMDSimulationStarted [

	runButton state: true.
	stepButton disable.
	lastDisplayUpdate := DateAndTime now
]

{ #category : #api }
RMDExperimentarium >> stepSimulation [

	self isValidated ifTrue: [ 
		[ interpreter stepSimulation ]
			on: RMDSemanticError
			do: [ :ex | (RMDActionDebugger on: interpreter exception: ex) open ] ]
]

{ #category : #updating }
RMDExperimentarium >> timeChanged: anAnnouncement [

	self informServer.
	self updateTimeProgressBar
]

{ #category : #api }
RMDExperimentarium >> typecheck [

	[ 
	interpreter typecheck.
	^ validated := true ]
		on: RMDSemanticError
		do: [ :ex | 
			runButton disable.
			stepButton disable.
			UIManager default alert: ex messageText title: 'Invalid Model'.
			^ validated := false ]
]

{ #category : #updating }
RMDExperimentarium >> updateTimeProgressBar [

	| now |
	now := DateAndTime now.
	(lastDisplayUpdate isNil or: [ 
		 now - lastDisplayUpdate > 100 milliSecond ]) ifTrue: [ 
		lastDisplayUpdate := now.
		self basicUpdateTimeProgressBar ]
]

{ #category : #private }
RMDExperimentarium >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self windowTitle ]
]

{ #category : #private }
RMDExperimentarium >> windowTitle [

	^ 'Experimentarium'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (self isValidated
			   ifTrue: [ '' ]
			   ifFalse: [ ' (INVALID MODEL)' ]) , (interpreter
		   ifNotNil: [ 
			   interpreter memory
				   ifNotNil: [ :memory | ' [' , memory name , ']' ]
				   ifNil: [ '' ] ]
		   ifNil: [ '' ])
]
