Class {
	#name : #RMDExperimentarium,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'validated',
		'runButton',
		'populationInspector',
		'stepButton',
		'timeLabel',
		'fpsLabel',
		'time',
		'duration',
		'lastServerUpdate',
		'timeProgressBar',
		'lastUpdateTime',
		'lastTimeChanged'
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
				   add: (SpBoxLayout newVertical
						    add: (SpBoxLayout newHorizontal
								     add: #timeLabel expand: false;
								     add: #fpsLabel expand: false;
								     yourself);
						    add:
						    (SpBoxLayout newHorizontal add: #timeProgressBar expand: true)
						    expand: false;
						    yourself)
				   expand: true;
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
			progress: time / duration asFloat
			from: self ]
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
	timeLabel := self newLabel
		             label: '0';
		             yourself.
	fpsLabel := self newLabel
		            label: '';
		            yourself.
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
		initialExtent: 700 @ 400
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

{ #category : #api }
RMDExperimentarium >> progress [
	^ time / duration
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
	duration := interpreter simulationModel simulationDefinition
		            timeDefinition duration evalIn: interpreter.
	self isValidated ifTrue: [ 
		interpreter
			setupSimulation;
			fastForward ]
]

{ #category : #updating }
RMDExperimentarium >> simulationPaused: aRMDSimulationPaused [

	runButton state: false.
	stepButton enable.
	self updateFpsLabel.
	self updateTimeLabel.
	lastUpdateTime := nil
]

{ #category : #updating }
RMDExperimentarium >> simulationStarted: aRMDSimulationStarted [

	runButton state: true.
	stepButton disable.
	lastTimeChanged := DateAndTime now
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

	| now |
	self informServer.
	self updateFpsLabel.
	now := DateAndTime now.
	(lastUpdateTime isNil or: [ now - lastUpdateTime > 100 milliSecond ]) 
		ifTrue: [ 
			lastUpdateTime := now.
			self updateTimeLabel ]
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
RMDExperimentarium >> updateFpsLabel [

	interpreter ifNotNil: [ 
		| now |
		now := DateAndTime now.
		lastTimeChanged
			ifNotNil: [ 
				| dt |
				dt := (now - lastTimeChanged) asMilliSeconds.
				dt > 1.0 ifTrue: [ 
					fpsLabel label:
						' (' , (1000.0 / dt asFloat printShowingDecimalPlaces: 3)
						, ' fps)' ] ]
			ifNil: [ fpsLabel label: '' ].
		lastTimeChanged := now ]
]

{ #category : #updating }
RMDExperimentarium >> updateTimeLabel [

	interpreter ifNotNil: [ 
		time := interpreter time.
		timeLabel label: (String streamContents: [ :stream | 
				 4 timesRepeat: [ stream space ].
				 interpreter simulationModel simulationDefinition timeDefinition 
					 printOn: stream.
				 stream nextPutAll: ' - now '.
				 (interpreter simulationModel simulationDefinition timeDefinition
					  duration unit fromSI: time)
					 printOn: stream
					 showingDecimalPlaces: 3.
				 stream nextPutAll: ' [ '.
				 interpreter simulationModel simulationDefinition timeDefinition
					 duration unit printOn: stream.
				 stream nextPutAll: ' ], '.
				 interpreter ticks printOn: stream.
				 stream nextPutAll: ' steps.' ]).
		timeProgressBar fixedAt: time / duration ]
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
