Class {
	#name : #RMDObservatory,
	#superclass : #RMDPresenter,
	#instVars : [
		'modelName',
		'interpreter',
		'validated',
		'views',
		'runButton',
		'process',
		'visualizer',
		'stepButton',
		'timeLabel',
		'fpsLabel',
		'timeSlider',
		'time',
		'duration',
		'lastServerUpdate',
		'recordAnimatedPngButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDObservatory class >> defaultLayout [

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
						    (SpBoxLayout newHorizontal add: #timeSlider expand: true)
						    expand: false;
						    yourself)
				   expand: true;
				   add: #recordAnimatedPngButton width: 32;
				   yourself)
		  height: self buttonHeight + 4;
		  add: #views yourself
]

{ #category : #'instance creation' }
RMDObservatory class >> interpreter: aRMDInterpreter [
	^ self new
		setInterpreter: aRMDInterpreter;
		yourself
]

{ #category : #utilities }
RMDObservatory class >> openOnDryRunFromUser [

	<script: 'RMDObservatory openOnDryRunFromUser'>
	RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
		self openOnDryRunOn: repBrowser file ]
]

{ #category : #'instance creation' }
RMDObservatory class >> openOnDryRunOn: aFileReference [

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
RMDObservatory class >> openOnFileFromUser [

	<script: 'RMDObservatory openOnFileFromUser'>
	RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
		self openOnFileOn: repBrowser file ]
]

{ #category : #'instance creation' }
RMDObservatory class >> openOnFileOn: aFileReference [

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
RMDObservatory class >> openOnMemoryFromUser [

	<script: 'RMDObservatory openOnMemoryFromUser'>
	RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
		self openOnMemoryOn: repBrowser file ]
]

{ #category : #'instance creation' }
RMDObservatory class >> openOnMemoryOn: aFileReference [

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
RMDObservatory class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidycObservatory)
		parent: 'ReMobidyc';
		order: 10;
		label: 'Observatory';
		with: [ 
			(aBuilder item: #ObservatoryOnDryRun)
				parent: 'ReMobidycObservatory';
				order: 10;
				label: 'Dry-run';
				action: [ RMDObservatory openOnDryRunFromUser ];
				help: 'Dry-run and visualize a model'.
			(aBuilder item: #ObservatoryOnMemory)
				parent: 'ReMobidycObservatory';
				order: 10;
				label: 'On memory';
				action: [ RMDObservatory openOnMemoryFromUser ];
				help: 'Run and visualize a model on memory (for small scale data collection)'.
			(aBuilder item: #ObservatoryOnFile)
				parent: 'ReMobidycObservatory';
				order: 11;
				label: 'On file';
				action: [ RMDObservatory openOnFileFromUser ];
				help:
					'Run and visualize a model recorded on files' ]
]

{ #category : #examples }
RMDObservatory class >> sugarScape [
	<script: 'RMDObservatory sugarScape openWithSpec'>
	^ self interpreter: RMDInterpreter sugarScape
]

{ #category : #private }
RMDObservatory >> animatInspector: aString [

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
RMDObservatory >> basicInformServer [

	lastServerUpdate := DateAndTime now.
	Smalltalk at: #RMDClient ifPresent: [ :clientClass | 
		clientClass
			informModel: self modelName
			progress: time / duration asFloat
			from: self ]
]

{ #category : #api }
RMDObservatory >> forceKill [
	self runState: false.
	process ifNotNil: #terminate
]

{ #category : #controlling }
RMDObservatory >> ifValidated: aBlock [

	^ validated = true ifTrue: [ aBlock cull: self ]
]

{ #category : #updating }
RMDObservatory >> informServer [
	(lastServerUpdate isNil
		or: [ DateAndTime now - lastServerUpdate >= self serverUpdateInterval ])
		ifTrue: [ self basicInformServer ]
]

{ #category : #initialization }
RMDObservatory >> initialize [

	super initialize.
	validated := false
]

{ #category : #initialization }
RMDObservatory >> initializePresenters [

	super initializePresenters.
	views := self newNotebook.
	timeLabel := self newLabel
		             label: '0';
		             yourself.
	fpsLabel := self newLabel
		            label: '';
		            yourself.
	timeSlider := self newSlider
		              min: 0;
		              max: 1;
		              value: 0;
		              whenValueChangedDo: [ 
			              interpreter ifNotNil: [ 
					              self isValidated ifTrue: [ 
							              runButton state ifFalse: [ 
									              (time / duration - timeSlider value) abs
									              > 1.0e-8 ifTrue: [ 
											              [ 
											              interpreter time: timeSlider value * duration ]
												              on: RMDSemanticError
												              do: [ :ex | 
													              (RMDActionDebugger
														               on: interpreter
														               exception: ex) open ] ] ] ] ] ];
		              yourself.
	runButton := self newButton
		             label: 'run';
		             action: [ self runState: self runState not ];
		             help: 'Run the simulation to the end';
		             state: false;
		             whenStateChangedDo: [ :state | 
			             state == true ifTrue: [ self runSimulation ] ];
		             yourself.
	stepButton := self newButton
		              label: 'step';
		              action: [ self stepSimulation ];
		              help: 'Run the simulation just one step forward';
		              enabled: true;
		              yourself.
	recordAnimatedPngButton := self newButton
		                           icon: Smalltalk ui icons smallScreenshot;
		                           action: [ self recordAPNG ];
		                           help:
			                           'Create an animated PNG file (warning: this takes a loooong time!)';
		                           enabled: true;
		                           yourself.
	self whenDisplayDo: [ (views pageAt: 1) activePresenter updateImage ]
]

{ #category : #initialization }
RMDObservatory >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: self windowTitle;
		initialExtent: 1100 @ 600
]

{ #category : #testing }
RMDObservatory >> isValidated [
	^ validated = true
]

{ #category : #accessing }
RMDObservatory >> modelName [
	^ modelName ifNil: [ modelName := self requestModelName ]
]

{ #category : #accessing }
RMDObservatory >> modelName: aString [

	modelName := aString.
	self updateWindowTitle
]

{ #category : #private }
RMDObservatory >> patchInspector [

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
RMDObservatory >> progress [
	^ time / duration
]

{ #category : #api }
RMDObservatory >> recordAPNG [

	(UIManager default
		 chooseForSaveFileReference: 'export animation PNG'
		 extensions: #( 'png' )
		 path: FileLocator desktop absolutePath) ifNotNil: [ :ref | 
		interpreter ifNotNil: [ 
			[ interpreter exportAPNG: ref ]
				on: RMDSemanticError
				do: [ :ex | (RMDActionDebugger on: interpreter exception: ex) open ] ] ]
]

{ #category : #accessing }
RMDObservatory >> requestModelName [
	^ UIManager default request: 'model name' initialAnswer: 're:mobidyc'
]

{ #category : #api }
RMDObservatory >> resetSimulation [

	self isValidated ifTrue: [ interpreter setupSimulation ]
]

{ #category : #api }
RMDObservatory >> runSimulation [

	self isValidated ifTrue: [ 
		process := [ 
		           | t |
		           stepButton enabled: false.
		           timeSlider enabled: false.
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
		           fpsLabel label: ''.
		           process := nil.
		           stepButton enabled: true.
		           timeSlider enabled: interpreter memory isRewindable ] 
			           forkAt: Processor userBackgroundPriority ]
]

{ #category : #api }
RMDObservatory >> runState [
	^ runButton state == true
]

{ #category : #api }
RMDObservatory >> runState: aBoolean [
	runButton state: aBoolean = true
]

{ #category : #accessing }
RMDObservatory >> serverUpdateInterval [
	^ 10 seconds
]

{ #category : #initialization }
RMDObservatory >> setInterpreter: aRMDInterpreter [

	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	self typecheck.
	visualizer := RMDVisualizer new.
	interpreter simulationModel renderersDo: [ :renderer | 
		visualizer addRenderer: renderer ].
	timeSlider enabled: interpreter memory isRewindable.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #timeChanged
		to: self.
	views pages: (Array streamContents: [ :stream | 
			 stream nextPut: (self newNotebookPage
					  presenterProvider: [ 
						  visualizer asPresenter
							  interpreter: interpreter;
							  updateImage;
							  yourself ];
					  whenRetrievedDo: [ :content | content updateImage ];
					  title: 'Map').
			 interpreter worldDefinition allAttributeDeclarations ifNotEmpty: [ 
				 stream nextPut: (self newNotebookPage
						  presenterProvider: [ self worldInspector ];
						  title: 'World') ].
			 interpreter patchDefinition allAttributeDeclarations ifNotEmpty: [ 
				 stream nextPut: (self newNotebookPage
						  presenterProvider: [ self patchInspector ];
						  title: 'Patch') ].
			 interpreter animatNames do: [ :animat | 
				 stream nextPut: (self newNotebookPage
						  presenterProvider: [ self animatInspector: animat ];
						  title: animat) ] ]).
	duration := interpreter simulationModel simulationDefinition
		            timeDefinition duration evalIn: interpreter.
	timeSlider quantum: interpreter deltaTime / interpreter duration.
	self
		resetSimulation;
		updateTimeLabel
]

{ #category : #api }
RMDObservatory >> stepSimulation [

	self isValidated ifTrue: [ 
		self runState: false.
		[ process isNil or: [ process isTerminated ] ] whileFalse: [ 
			1 milliSecond wait ].
		[ interpreter stepSimulation ]
			on: RMDSemanticError
			do: [ :ex | (RMDActionDebugger on: interpreter exception: ex) open ] ]
]

{ #category : #updating }
RMDObservatory >> timeChanged [
	self
		informServer;
		updateTimeLabel
]

{ #category : #private }
RMDObservatory >> timeSeriesInspector [

	^ RMDTimeSeriesInspector new interpreter: interpreter
]

{ #category : #api }
RMDObservatory >> toggleRunPauseSimulation [
	self runState: self runState not
]

{ #category : #api }
RMDObservatory >> typecheck [

	[ 
	interpreter simulationModel typecheck.
	^ validated := true ]
		on: RMDSemanticError
		do: [ :ex | 
			runButton disable.
			stepButton disable.
			timeSlider disable.
			UIManager default alert: ex messageText title: 'Invalid Model'.
			^ validated := false ]
]

{ #category : #updating }
RMDObservatory >> updateTimeLabel [

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
		timeSlider value: time / duration ]
]

{ #category : #private }
RMDObservatory >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self windowTitle ]
]

{ #category : #private }
RMDObservatory >> windowTitle [

	^ 'Observatory'
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
RMDObservatory >> worldInspector [

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
