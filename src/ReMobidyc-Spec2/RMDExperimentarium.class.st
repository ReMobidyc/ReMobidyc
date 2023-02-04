Class {
	#name : #RMDExperimentarium,
	#superclass : #RMDPresenter,
	#classTraits : 'TRMDLaunchTabular classTrait',
	#instVars : [
		'stepButton',
		'runButton',
		'timeProgressBar',
		'populationInspector',
		'validated',
		'lastServerUpdate',
		'lastDisplayUpdate',
		'metaInterpreter',
		'openTabularButton',
		'openObservatoryButton'
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
		  add: (SpBoxLayout newHorizontal
				   add: #openTabularButton width: self buttonHeight;
				   add: #openObservatoryButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #'instance creation' }
RMDExperimentarium class >> metaInterpreter: aRMDInterpreter [
	^ self new
		setMetaInterpreter: aRMDInterpreter;
		yourself
]

{ #category : #updating }
RMDExperimentarium >> basicInformServer [

	lastServerUpdate := DateAndTime now.
	Smalltalk at: #RMDClient ifPresent: [ :clientClass | 
		clientClass
			informModel: self modelName
			progress: metaInterpreter progress
			from: self ]
]

{ #category : #updating }
RMDExperimentarium >> basicUpdateTimeProgressBar [

	metaInterpreter ifNotNil: [ 
		timeProgressBar fixedAt: metaInterpreter progress ]
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
	openTabularButton := self newButton
		                     disable;
		                     icon: self tabularIcon;
		                     action: [ self openInTabular ];
		                     yourself.
	openObservatoryButton := self newButton
		                         disable;
		                         icon: self observatoryIcon;
		                         action: [ self openInObservatory ];
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
	aWindowPresenter initialExtent: 700 @ 450
]

{ #category : #api }
RMDExperimentarium >> isRunningSimulation [

	^ metaInterpreter isRunningSimulation
]

{ #category : #testing }
RMDExperimentarium >> isValidated [
	^ validated = true
]

{ #category : #accessing }
RMDExperimentarium >> modelName [

	^ metaInterpreter
		  ifNotNil: [ metaInterpreter simulationModel name ]
		  ifNil: [ 'noname' ]
]

{ #category : #operations }
RMDExperimentarium >> openInAttributeTabular [

	(metaInterpreter notNil and: [ 
		 metaInterpreter context isForFileMemory ]) ifTrue: [ 
		(metaInterpreter simulationModel 
			 metaInterpreterOnReadOnlyModelPath:
			 metaInterpreter context modelPath) openInAttributeTabular ]
]

{ #category : #operations }
RMDExperimentarium >> openInObservatory [

	(metaInterpreter notNil and: [ 
		 metaInterpreter context isForFileMemory ]) ifTrue: [ 
		(metaInterpreter simulationModel 
			 metaInterpreterOnReadOnlyModelPath:
			 metaInterpreter context modelPath) openInReplayObservatory ]
]

{ #category : #operations }
RMDExperimentarium >> openInPopulationTabular [

	(metaInterpreter notNil and: [ 
		 metaInterpreter context isForFileMemory ]) ifTrue: [ 
		(metaInterpreter simulationModel 
			 metaInterpreterOnReadOnlyModelPath:
			 metaInterpreter context modelPath) openInPopulationTabular ]
]

{ #category : #operations }
RMDExperimentarium >> openInTabular [

	(self newMenu
		 addGroup: [ :group | 
			 group
				 addItem: [ :item | 
					 item
						 name: 'Population';
						 action: [ self openInPopulationTabular ] ];
				 addItem: [ :item | 
					 item
						 name: 'Attributes';
						 action: [ self openInAttributeTabular ] ] ];
		 yourself) openWithSpecAtPointer
]

{ #category : #api }
RMDExperimentarium >> pauseSimulation [

	metaInterpreter pauseSimulation
]

{ #category : #operations }
RMDExperimentarium >> runButtonPressed [

	metaInterpreter isRunningSimulation
		ifTrue: [ self pauseSimulation ]
		ifFalse: [ self runSimulation ]
]

{ #category : #api }
RMDExperimentarium >> runSimulation [

	self isValidated ifTrue: [ 
		metaInterpreter runSimulationOnError: [ :ex | 
			(RMDActionDebugger on: metaInterpreter exception: ex) open ] ]
]

{ #category : #accessing }
RMDExperimentarium >> serverUpdateInterval [
	^ 10 seconds
]

{ #category : #initialization }
RMDExperimentarium >> setMetaInterpreter: aRMDMetaInterpreter [

	metaInterpreter ifNotNil: [ 
		metaInterpreter announcer unsubscribe: self.
		metaInterpreter interpretersDo: [ :interpreter | 
			interpreter announcer unsubscribe: self ] ].
	metaInterpreter := aRMDMetaInterpreter.
	self typecheck.
	self isValidated ifTrue: [ 
		metaInterpreter setupSimulation.
		populationInspector interpreter: metaInterpreter.
		metaInterpreter announcer weak
			when: RMDSimulationStarted send: #simulationStarted: to: self;
			when: RMDSimulationPaused send: #simulationPaused: to: self.
		metaInterpreter interpretersDo: [ :interpreter | 
			interpreter announcer weak
				when: RMDTimeChanged
				send: #timeChanged:
				to: self ].
		metaInterpreter fastForward.
		self updateButtons ]
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
		[ metaInterpreter stepSimulation ]
			on: RMDSemanticError
			do: [ :ex | (RMDActionDebugger on: metaInterpreter exception: ex) open ] ]
]

{ #category : #updating }
RMDExperimentarium >> timeChanged: anAnnouncement [

	self informServer.
	self updateTimeProgressBar
]

{ #category : #private }
RMDExperimentarium >> title [

	^ 'Experimentarium'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (self isValidated
			   ifTrue: [ '' ]
			   ifFalse: [ ' (INVALID MODEL)' ]) , (metaInterpreter
		   ifNotNil: [ 
			   '[', metaInterpreter memoryName, ']' ]
		   ifNil: [ '' ])
]

{ #category : #api }
RMDExperimentarium >> typecheck [

	[ 
	metaInterpreter typecheck.
	^ validated := true ]
		on: RMDSemanticError
		do: [ :ex | 
			runButton disable.
			stepButton disable.
			UIManager default alert: ex messageText title: 'Invalid Model'.
			^ validated := false ]
]

{ #category : #updating }
RMDExperimentarium >> updateButtons [

	(metaInterpreter notNil and: [ 
		 metaInterpreter context isForFileMemory ])
		ifTrue: [ 
			openTabularButton enable.
			openObservatoryButton enable ]
		ifFalse: [ 
			openTabularButton disable.
			openObservatoryButton disable ]
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

	self window ifNotNil: [ :window | window title: self title ]
]
