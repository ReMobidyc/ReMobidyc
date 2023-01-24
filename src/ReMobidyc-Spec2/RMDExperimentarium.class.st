Class {
	#name : #RMDExperimentarium,
	#superclass : #RMDPresenter,
	#instVars : [
		'modelName',
		'interpreter',
		'validated',
		'runButton',
		'populationInspector',
		'process',
		'visualizer',
		'stepButton',
		'timeLabel',
		'fpsLabel',
		'time',
		'duration',
		'lastServerUpdate',
		'timeProgressBar',
		'lastUpdateTime'
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

{ #category : #utilities }
RMDExperimentarium class >> openOnDryRunFromUser [

	<script: 'RMDExperimentarium openOnDryRunFromUser'>
	RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
		self openOnDryRunOn: repBrowser file ]
]

{ #category : #'instance creation' }
RMDExperimentarium class >> openOnDryRunOn: aFileReference [

	| interpreter |
	interpreter := RMDInterpreter new
		               setMemory: RMDDryMemory new;
		               setContext: RMDActionContext new;
		               simulationModel:
			               (RMDSimulationModel
				                importModel: aFileReference
				                ifError: [ ^ nil ]);
		               yourself.
	^ (self interpreter: interpreter)
		  modelName: aFileReference basename;
		  open;
		  yourself
]

{ #category : #utilities }
RMDExperimentarium class >> openOnFileFromUser [

	<script: 'RMDExperimentarium openOnFileFromUser'>
	RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
		self openOnFileOn: repBrowser file ]
]

{ #category : #'instance creation' }
RMDExperimentarium class >> openOnFileOn: aFileReference [

	| memoryRef interpreter |
	memoryRef := aFileReference / 'memory'.
	memoryRef isDirectory ifTrue: [ 
		(UIManager default
			 confirm:
			 'A simulation result of the model is already stored. Do you want to erase the existing result?'
			 label: 'Simulation result exists'
			 trueChoice: 'Erase & Open'
			 falseChoice: 'Open'
			 cancelChoice: 'Cancel'
			 default: false)
			ifNil: [ ^ self ]
			ifNotNil: [ :choice | choice ifTrue: [ memoryRef ensureDeleteAll ] ] ].
	interpreter := RMDInterpreter new
		               setMemory:
			               (RMDFileMemory on: memoryRef ensureCreateDirectory);
		               setContext: RMDActionContext new;
		               simulationModel:
			               (RMDSimulationModel
				                importModel: aFileReference
				                ifError: [ ^ nil ]);
		               yourself.
	^ (self interpreter: interpreter)
		  modelName: aFileReference basename;
		  open;
		  yourself
]

{ #category : #utilities }
RMDExperimentarium class >> openOnMemoryFromUser [

	<script: 'RMDExperimentarium openOnMemoryFromUser'>
	RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
		self openOnMemoryOn: repBrowser file ]
]

{ #category : #'instance creation' }
RMDExperimentarium class >> openOnMemoryOn: aFileReference [

	| interpreter |
	interpreter := RMDInterpreter new
		               setMemory: RMDOnMemory new;
		               setContext: RMDActionContext new;
		               simulationModel:
			               (RMDSimulationModel
				                importModel: aFileReference
				                ifError: [ ^ nil ]);
		               yourself.
	^ (self interpreter: interpreter)
		  modelName: aFileReference basename;
		  open;
		  yourself
]

{ #category : #menus }
RMDExperimentarium class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Experimentarium)
		parent: 'ReMobidyc';
		order: 9;
		label: 'Experimentarium';
		with: [ 
			(aBuilder item: #ExperimentariumOnDryRun)
				parent: 'Experimentarium';
				order: 1;
				label: 'Dry-run';
				action: [ RMDExperimentarium openOnDryRunFromUser ];
				help: 'Dry-run a model for quick testing'.
			(aBuilder item: #ObservatoryOnMemory)
				parent: 'Experimentarium';
				order: 2;
				label: 'On memory';
				action: [ RMDObservatory openOnMemoryFromUser ];
				help: 'Run a model on memory (for small scale data collection)'.
			(aBuilder item: #ObservatoryOnFile)
				parent: 'Experimentarium';
				order: 3;
				label: 'On file';
				action: [ RMDObservatory openOnFileFromUser ];
				help: 'Run a model and record the simulation results into files' ]
]

{ #category : #examples }
RMDExperimentarium class >> sugarScape [
	<script: 'RMDExperimentarium sugarScape openWithSpec'>
	^ self interpreter: RMDInterpreter sugarScape
]

{ #category : #private }
RMDExperimentarium >> animatInspector: aString [

	^ self newNotebook
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDAnimatTabularInspector new
						   interpreter: interpreter;
						   animat: aString ];
				   whenRetrievedDo: [ :content | content updateObservation ];
				   title: 'Table';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDAnimatPercentileInspector new
								    interpreter: interpreter;
								    animat: aString;
								    updateLayout;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Percentile';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDAnimatHistogramInspector new
								    interpreter: interpreter;
								    animat: aString;
								    updateLayout;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Histogram';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDAnimatTimeSeriesInspector new
								    interpreter: interpreter;
								    animat: aString;
								    updateLayout;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Time series';
				   yourself);
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

{ #category : #api }
RMDExperimentarium >> forceKill [
	self runState: false.
	process ifNotNil: #terminate
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
		             action: [ self runState: self runState not ];
		             help: 'Run the simulation to the end';
		             state: false;
		             whenStateChangedDo: [ :state | 
			             state == true ifTrue: [ self runSimulation ] ];
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

{ #category : #accessing }
RMDExperimentarium >> modelName: aString [

	modelName := aString.
	self updateWindowTitle
]

{ #category : #private }
RMDExperimentarium >> patchInspector [

	^ self newNotebook
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDPatchTabularInspector new interpreter: interpreter ];
				   whenRetrievedDo: [ :content | content updateObservation ];
				   title: 'Table';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDPatchPercentileInspector new
								    interpreter: interpreter;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Percentile';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDPatchHistogramInspector new
								    interpreter: interpreter;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Histogram';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDPatchTimeSeriesInspector new
								    interpreter: interpreter;
								    updateLayout;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Time series';
				   yourself);
		  yourself
]

{ #category : #api }
RMDExperimentarium >> progress [
	^ time / duration
]

{ #category : #api }
RMDExperimentarium >> resetSimulation [

	self isValidated ifTrue: [ interpreter setupSimulation ]
]

{ #category : #api }
RMDExperimentarium >> runSimulation [

	self isValidated ifTrue: [ 
		process := [ 
		           | t |
		           stepButton enabled: false.
		           t := DateAndTime now.
		           [ 
		           self runState == true and: [ 
			           self adapter notNil and: [ 
				           self adapter widget notNil and: [ 
					           self adapter widget world notNil ] ] ] ] whileTrue: [ 
			           interpreter ifNotNil: [ 
				           ([ 
				            | t0 msec result |
				            result := interpreter stepSimulation.
				            t0 := DateAndTime now.
				            msec := (t0 - t) asMilliSeconds.
				            msec > 1.0 ifTrue: [ 
					            fpsLabel label:
						            ' (' , (1000.0 / msec printShowingDecimalPlaces: 3)
						            , ' fps)' ].
				            t := t0.
				            result ]
					            on: RMDSemanticError
					            do: [ :ex | 
						            (RMDActionDebugger on: interpreter exception: ex)
							            open.
						            false ]) ifFalse: [ self runState: false ] ] ].
		           self updateTimeLabel.
		           fpsLabel label: ''.
		           process := nil.
		           stepButton enabled: true ] forkAt:
			           Processor userBackgroundPriority ]
]

{ #category : #api }
RMDExperimentarium >> runState [
	^ runButton state == true
]

{ #category : #api }
RMDExperimentarium >> runState: aBoolean [
	runButton state: aBoolean = true
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
		when: RMDTimeChanged
		send: #timeChanged
		to: self.
	duration := interpreter simulationModel simulationDefinition
		            timeDefinition duration evalIn: interpreter.
	self
		resetSimulation;
		updateTimeLabel
]

{ #category : #api }
RMDExperimentarium >> stepSimulation [

	self isValidated ifTrue: [ 
		self runState: false.
		[ process isNil or: [ process isTerminated ] ] whileFalse: [ 
			1 milliSecond wait ].
		[ 
		interpreter stepSimulation.
		self updateTimeLabel ]
			on: RMDSemanticError
			do: [ :ex | (RMDActionDebugger on: interpreter exception: ex) open ] ]
]

{ #category : #updating }
RMDExperimentarium >> timeChanged [

	| now |
	self informServer.
	now := DateAndTime now.
	(lastUpdateTime isNil or: [ now - lastUpdateTime > 100 milliSecond ]) 
		ifTrue: [ 
			lastUpdateTime := now.
			self updateTimeLabel ]
]

{ #category : #private }
RMDExperimentarium >> timeSeriesInspector [

	^ RMDTimeSeriesInspector new interpreter: interpreter
]

{ #category : #api }
RMDExperimentarium >> toggleRunPauseSimulation [
	self runState: self runState not
]

{ #category : #api }
RMDExperimentarium >> typecheck [

	[ 
	interpreter simulationModel typecheck.
	^ validated := true ]
		on: RMDSemanticError
		do: [ :ex | 
			runButton disable.
			stepButton disable.
			UIManager default alert: ex messageText title: 'Invalid Model'.
			^ validated := false ]
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
				 (interpreter simulationDefinition timeDefinition duration unit 
					  fromSI: time) printOn: stream showingDecimalPlaces: 3.
				 stream nextPutAll: ' [ '.
				 interpreter simulationDefinition timeDefinition duration unit 
					 printOn: stream.
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

{ #category : #private }
RMDExperimentarium >> worldInspector [

	^ self newNotebook
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDWorldTabularInspector new interpreter: interpreter ];
				   whenRetrievedDo: [ :content | content updateObservation ];
				   title: 'Table';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDWorldPercentileInspector new
								    interpreter: interpreter;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Percentile';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDWorldHistogramInspector new
								    interpreter: interpreter updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Histogram';
				   yourself);
		  addPage: (self newNotebookPage
				   presenterProvider: [ 
					   RMDScrollPresenter with: (RMDWorldTimeSeriesInspector new
								    interpreter: interpreter;
								    updateLayout;
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | 
				   content presenter updateObservation ];
				   title: 'Time series';
				   yourself);
		  yourself
]
