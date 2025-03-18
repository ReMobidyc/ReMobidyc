Class {
	#name : 'RMDExperimentarium',
	#superclass : 'RMDPresenter',
	#traits : 'TRMDLaunchAnalysisTools',
	#classTraits : 'TRMDLaunchAnalysisTools classTrait',
	#instVars : [
		'stepButton',
		'runButton',
		'saveRunAsButton',
		'removeRunButton',
		'timeProgressBar',
		'limitsNumberOfIndividualsCheckBox',
		'numberOfIndividualField',
		'interpreterDropList',
		'timeLabel',
		'populationTable',
		'currentPopulation',
		'maxPopulation',
		'minPopulation',
		'populationByTime',
		'validated',
		'lastServerUpdate',
		'lastDisplayUpdate',
		'metaInterpreter',
		'visualizationImage',
		'showPopulationChartRadioButton',
		'showVisualMapRadioButton',
		'chronicleModel'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'layout' }
RMDExperimentarium class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: #stepButton expand: false;
				   add: #runButton expand: false;
				   add: #timeProgressBar expand: true;
				   yourself)
		  height: self buttonHeight * 2;
		  add: (SpBoxLayout newHorizontal
				   add: #limitsNumberOfIndividualsCheckBox expand: false;
				   add: #numberOfIndividualField width: 100;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newVertical
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.3;
						    add: #interpreterDropList;
						    add: #timeLabel)
				   expand: false;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.45;
						    add: #populationTable;
						    add: (SpBoxLayout newVertical
								     add: (SpBoxLayout newHorizontal
										      add: (SpBoxLayout newVertical
												       add: #showPopulationChartRadioButton
												       height: self buttonHeight)
										      expand: false;
										      add: (SpBoxLayout newVertical
												       add: #showVisualMapRadioButton
												       height: self buttonHeight)
										      expand: false;
										      yourself)
								     height: self buttonHeight;
								     add: #visualizationImage;
								     yourself);
						    yourself);
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: #openTabularButton width: self buttonHeight;
				   add: #openObservatoryButton width: self buttonHeight;
				   add: '    ' width: self buttonHeight;
				   add: #saveRunAsButton width: self buttonHeight;
				   add: #removeRunButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'instance creation' }
RMDExperimentarium class >> metaInterpreter: aRMDInterpreter [

	^ self new
		  setMetaInterpreter: aRMDInterpreter;
		  recordInChronicle;
		  yourself
]

{ #category : 'updating' }
RMDExperimentarium >> basicInformServer [

	lastServerUpdate := DateAndTime now.
	Smalltalk at: #RMDClient ifPresent: [ :clientClass | 
		clientClass
			informModel: self modelName
			progress: metaInterpreter progress
			from: self ]
]

{ #category : 'updating' }
RMDExperimentarium >> basicUpdateTimeProgressBar [

	metaInterpreter ifNotNil: [ 
		timeProgressBar fixedAt: metaInterpreter progress ]
]

{ #category : 'testing' }
RMDExperimentarium >> canOpenAnalysis [

	^ metaInterpreter notNil and: [ 
		  metaInterpreter context isForFileMemory ]
]

{ #category : 'testing' }
RMDExperimentarium >> canProceed: aRMDInterpreter [

	^ limitsNumberOfIndividualsCheckBox state not or: [ 
		  aRMDInterpreter numberOfIndividuals
		  <= numberOfIndividualField number ]
]

{ #category : 'controlling' }
RMDExperimentarium >> ifValidated: aBlock [

	^ validated = true ifTrue: [ aBlock cull: self ]
]

{ #category : 'updating' }
RMDExperimentarium >> informServer [
	(lastServerUpdate isNil
		or: [ DateAndTime now - lastServerUpdate >= self serverUpdateInterval ])
		ifTrue: [ self basicInformServer ]
]

{ #category : 'initialization' }
RMDExperimentarium >> initialize [

	super initialize.
	validated := false.
	currentPopulation := Dictionary new.
	maxPopulation := Dictionary new.
	minPopulation := Dictionary new.
	populationByTime := Dictionary new
]

{ #category : 'initialization' }
RMDExperimentarium >> initializePresenters [

	super initializePresenters.
	self initializeOpenAnalysisButtonsPresenters.
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
	removeRunButton := self newButton
		                   icon: self removeIcon;
		                   action: [ self removeRun ];
		                   help: 'Remove the run from the repository';
		                   enabled: true;
		                   yourself.
	saveRunAsButton := self newButton
		                   icon: self saveIcon;
		                   action: [ self saveRunAs ];
		                   help:
			                   'Rename and save the run into the repository';
		                   enabled: true;
		                   yourself.

	timeProgressBar := self newProgressBar
		                   fixedAt: 0.0;
		                   yourself.
	limitsNumberOfIndividualsCheckBox := self newCheckBox
		                                     label:
			                                     'Limit max individuals to';
		                                     labelClickable: true;
		                                     state: false;
		                                     whenChangedDo: [
			                                     self
				                                     limitsNumberOfIndividualsChanged ];
		                                     yourself.
	numberOfIndividualField := self newNumberInput
		                           beInteger;
		                           disable;
		                           color: (Color gray: 0.75);
		                           number: 100000;
		                           climbRate: 10000;
		                           whenBuiltDo: [
			                           numberOfIndividualField color:
					                           (Color gray: 0.75) ];
		                           yourself.
	interpreterDropList := self newDropList
		                       display: [ :runId |
			                       (metaInterpreter
				                        interpreterAt: runId
				                        ifAbsent: [ nil ])
				                       ifNotNil: #shortName
				                       ifNil: [ '-' ] ];
		                       whenSelectedItemChangedDo: [
			                       self updateDisplay ];
		                       yourself.
	timeLabel := self newLabel
		             label: '';
		             yourself.
	populationTable := self newTable
		                   beResizable;
		                   addColumn:
			                   (SpStringTableColumn
				                    title: 'name'
				                    evaluated: #yourself);
		                   addColumn:
			                   (SpStringTableColumn
				                    title: 'min'
				                    evaluated: [ :name |
					                    self printNat: (minPopulation
								                     at: self runId
								                     ifPresent: [ :dict |
									                     dict at: name ifAbsent: [ nil ] ]
								                     ifAbsent: [ nil ]) ]);
		                   addColumn:
			                   (SpStringTableColumn
				                    title: 'max'
				                    evaluated: [ :name |
					                    self printNat: (maxPopulation
								                     at: self runId
								                     ifPresent: [ :dict |
									                     dict at: name ifAbsent: [ nil ] ]
								                     ifAbsent: [ nil ]) ]);
		                   addColumn:
			                   (SpStringTableColumn
				                    title: 'now'
				                    evaluated: [ :name |
					                    self printNat: (currentPopulation
								                     at: self runId
								                     ifPresent: [ :dict |
									                     dict at: name ifAbsent: [ nil ] ]
								                     ifAbsent: [ nil ]) ]);
		                   whenSelectionChangedDo: [ self updateDisplay ];
		                   yourself.
	showPopulationChartRadioButton := self newRadioButton
		                                  label: 'Population chart';
		                                  whenChangedDo: [
			                                  self updateDisplay ];
		                                  yourself.
	showVisualMapRadioButton := self newRadioButton
		                            label: 'Visual map';
		                            whenChangedDo: [ self updateDisplay ];
		                            associatedRadioButtons:
			                            { showPopulationChartRadioButton };
		                            yourself.
	showPopulationChartRadioButton state: true.
	visualizationImage := self newImage
		                      autoScale: false;
		                      yourself.
	self whenDisplayDo: [ self updateDisplay ]
]

{ #category : 'initialization' }
RMDExperimentarium >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 700 @ 480
]

{ #category : 'accessing' }
RMDExperimentarium >> interpreterDo: aBlock [

	(metaInterpreter interpreterAt: self runId ifAbsent: [ nil ]) 
		ifNotNil: aBlock
]

{ #category : 'api' }
RMDExperimentarium >> isRunningSimulation [

	^ metaInterpreter isRunningSimulation
]

{ #category : 'testing' }
RMDExperimentarium >> isValidated [
	^ validated = true
]

{ #category : 'updating' }
RMDExperimentarium >> limitsNumberOfIndividualsChanged [

	limitsNumberOfIndividualsCheckBox state
		ifTrue: [ 
			numberOfIndividualField
				enable;
				color: Color white ]
		ifFalse: [ 
			numberOfIndividualField
				disable;
				color: (Color gray: 0.75) ]
]

{ #category : 'private' }
RMDExperimentarium >> metaInterpreterForTabularDo: aBlock [

	^ (metaInterpreter notNil and: [ 
		   metaInterpreter context isForFileMemory ]) ifTrue: [ 
		  aBlock value:
			  (metaInterpreter simulationModel 
				   metaInterpreterOnReadOnlyModelPath:
				   metaInterpreter context modelPath) ]
]

{ #category : 'accessing' }
RMDExperimentarium >> modelName [

	^ metaInterpreter
		  ifNotNil: [ metaInterpreter simulationModel name ]
		  ifNil: [ 'noname' ]
]

{ #category : 'api' }
RMDExperimentarium >> pauseSimulation [

	metaInterpreter pauseSimulation
]

{ #category : 'private' }
RMDExperimentarium >> printNat: anInteger [

	^ anInteger
		  ifNotNil: [ 
			  anInteger > 0
				  ifTrue: [ 
					  | nat str |
					  nat := anInteger.
					  str := ',' join: (Array streamContents: [ :stream | 
							          [ nat > 0 ] whileTrue: [ 
								          | n |
								          n := nat % 1000.
								          stream nextPut: (n < 100
										           ifTrue: [ 
											           n < 10
												           ifTrue: [ '00' , n printString ]
												           ifFalse: [ '0' , n printString ] ]
										           ifFalse: [ n printString ]).
								          nat := nat // 1000 ] ]) reversed.
					  [ str first = $0 ] whileTrue: [ str := str allButFirst ].
					  str ]
				  ifFalse: [ '0' ] ]
		  ifNil: [ '-' ]
]

{ #category : 'operations' }
RMDExperimentarium >> recordInChronicle [

	chronicleModel
		ifNil: [
			metaInterpreter ifNotNil: [ :interpreter |
				chronicleModel := interpreter simulationModel recordInChronicle:
					                  (interpreter modelPath ifNotNil: #basename).
				chronicleModel hideMetadata addTag: 'run'.
				chronicleModel hideSave ] ]
		ifNotNil: [ :cm | cm hideSave ]
]

{ #category : 'operations' }
RMDExperimentarium >> removeRun [

	(metaInterpreter ifNotNil: #modelPath) ifNotNil: [ :modelPath |
		(UIManager default
			 confirm: 'Remove this run from the repository?'
			 label: 'Remove run') ifTrue: [
			modelPath ensureDeleteAll.
			self setMetaInterpreter: nil.
			self updateButtons ] ]
]

{ #category : 'operations' }
RMDExperimentarium >> runButtonPressed [

	metaInterpreter isRunningSimulation
		ifTrue: [ self pauseSimulation ]
		ifFalse: [ self runSimulation ]
]

{ #category : 'accessing' }
RMDExperimentarium >> runId [

	^ interpreterDropList selectedItem ifNil: [ 1 ]
]

{ #category : 'api' }
RMDExperimentarium >> runSimulation [

	self isValidated ifTrue: [ 
		metaInterpreter runSimulationOnError: [ :ex | 
			(RMDActionDebugger exception: ex) open ] ]
]

{ #category : 'operations' }
RMDExperimentarium >> saveRunAs [

	(metaInterpreter ifNotNil: #modelPath) ifNotNil: [ :modelPath |
		(UIManager default
			 request: 'New name of this run'
			 initialAnswer: modelPath basename
			 title: 'Save this run as...') ifNotNil: [ :string |
			string trim ifNotEmpty: [ :name |
				| ref |
				ref := RMDRunsRepository runsDirectory / name.
				ref exists ifTrue: [
					^ UIManager default alert:
						  'A run named "' , name , '" already exists.' ].
				modelPath moveTo: ref.
				self setMetaInterpreter: (RMDMetaInterpreter onModelPath: ref) ] ] ]
]

{ #category : 'accessing' }
RMDExperimentarium >> selectedIndividual [

	^ nil
]

{ #category : 'accessing' }
RMDExperimentarium >> selectedRunId [

	^ nil
]

{ #category : 'accessing' }
RMDExperimentarium >> selectedTime [

	| time |
	time := nil.
	metaInterpreter interpretersDo: [ :interpreter | 
		| t |
		t := interpreter time.
		(time isNil or: [ time > t ]) ifTrue: [ time := t ] ].
	^ time
]

{ #category : 'accessing' }
RMDExperimentarium >> serverUpdateInterval [
	^ 10 seconds
]

{ #category : 'initialization' }
RMDExperimentarium >> setMetaInterpreter: aRMDMetaInterpreter [

	metaInterpreter ifNotNil: [
		metaInterpreter announcer unsubscribe: self.
		metaInterpreter interpretersDo: [ :interpreter |
			interpreter announcer unsubscribe: self ] ].
	metaInterpreter := aRMDMetaInterpreter.
	self window ifNotNil: [ :window | window title: self title ].
	metaInterpreter ifNotNil: [
		self typecheck.
		self isValidated ifTrue: [
			metaInterpreter setupSimulation.
			metaInterpreter guard: [ :interpreter |
				self canProceed: interpreter ].
			currentPopulation := Dictionary new.
			maxPopulation := Dictionary new.
			minPopulation := Dictionary new.
			populationByTime := Dictionary new.
			metaInterpreter interpretersDo: [ :i |
				| runId |
				runId := i runId.
				currentPopulation at: runId put: Dictionary new.
				maxPopulation at: runId put: Dictionary new.
				minPopulation at: runId put: Dictionary new.
				populationByTime at: runId put: (OrderedCollection new: 1024).
				i announcer weak
					when: RMDSimulationStarted send: #simulationStarted: to: self;
					when: RMDTimeChanged send: #timeChanged: to: self;
					when: RMDSimulationPaused send: #simulationPaused: to: self ].
			interpreterDropList
				items: metaInterpreter runIds;
				selectIndex: 1;
				enable.
			metaInterpreter fastForward.
			self
				updateTableItems;
				updateDisplay ] ].
	self updateButtons
]

{ #category : 'updating' }
RMDExperimentarium >> simulationPaused: aRMDSimulationPaused [

	metaInterpreter isRunningSimulation ifFalse: [ 
		runButton state: false.
		stepButton enable.
		self updateDisplay.
		lastDisplayUpdate := nil ]
]

{ #category : 'updating' }
RMDExperimentarium >> simulationStarted: aRMDSimulationStarted [

	runButton state: true.
	stepButton disable.
	lastDisplayUpdate := DateAndTime now
]

{ #category : 'accessing' }
RMDExperimentarium >> stagePrefix [
	^ '  '
]

{ #category : 'api' }
RMDExperimentarium >> stepSimulation [

	self isValidated ifTrue: [ 
		[ metaInterpreter stepSimulation ]
			on: RMDSemanticError
			do: [ :ex | (RMDActionDebugger exception: ex) open ] ]
]

{ #category : 'updating' }
RMDExperimentarium >> timeChanged: aRMDTimeChanged [

	| now |
	self informServer.
	self updateObservation: aRMDTimeChanged.
	now := DateAndTime now.
	(lastDisplayUpdate isNil or: [ 
		 now - lastDisplayUpdate > 200 milliSecond ]) ifFalse: [ ^ self ].
	self interpreterDo: [ :interpreter | 
		interpreter == aRMDTimeChanged interpreter ifTrue: [ 
			lastDisplayUpdate := now.
			self updateDisplay ] ]
]

{ #category : 'accessing' }
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

{ #category : 'api' }
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

{ #category : 'updating' }
RMDExperimentarium >> updateButtons [

	metaInterpreter
		ifNil: [
			stepButton disable.
			runButton disable.
			saveRunAsButton disable.
			removeRunButton disable.
			limitsNumberOfIndividualsCheckBox disable.
			numberOfIndividualField disable.
			interpreterDropList disable.
			populationTable disable.
			showPopulationChartRadioButton disable.
			showVisualMapRadioButton disable.
			openTabularButton disable.
			openObservatoryButton disable ]
		ifNotNil: [
			saveRunAsButton enabled: metaInterpreter modelPath notNil.
			removeRunButton enabled: metaInterpreter modelPath notNil.
			self updateOpenAnalysisButtons ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateDisplay [

	metaInterpreter ifNil: [ ^ self ].
	populationTable ifNotNil: #refresh.
	timeProgressBar fixedAt: metaInterpreter progress.
	self
		updatePopulationChart;
		updateVisualMap;
		updateTimeLabel
]

{ #category : 'updating' }
RMDExperimentarium >> updateObservation: aRMDTimeChanged [

	| interpreter model runId speciesPopulations |
	interpreter := aRMDTimeChanged interpreter.
	model := interpreter simulationModel.
	runId := interpreter runId.
	speciesPopulations := Dictionary new.
	model animatDefinitionsDo: [ :animat | 
		| population stage |
		population := interpreter numberOfIndividualsOf: animat.
		speciesPopulations
			at: animat species
			put:
			(speciesPopulations at: animat species ifAbsent: [ 0 ])
			+ population.
		stage := self stagePrefix , animat name.
		currentPopulation
			at: runId
			ifPresent: [ :current | current at: stage put: population ].
		minPopulation at: runId ifPresent: [ :mins | 
			mins
				at: stage
				put:
				((mins at: stage ifAbsent: [ Float infinity ]) min: population) ].
		maxPopulation at: runId ifPresent: [ :maxs | 
			maxs
				at: stage
				put: ((maxs at: stage ifAbsent: [ 0 ]) max: population) ] ].
	speciesPopulations keysAndValuesDo: [ :species :population | 
		currentPopulation
			at: runId
			ifPresent: [ :current | current at: species put: population ].
		minPopulation at: runId ifPresent: [ :mins | 
			mins
				at: species
				put:
				((mins at: species ifAbsent: [ Float infinity ]) min: population) ].
		maxPopulation at: runId ifPresent: [ :maxs | 
			maxs
				at: species
				put: ((maxs at: species ifAbsent: [ 0 ]) max: population) ] ].
	populationByTime at: runId ifPresent: [ :byTime | 
		currentPopulation
			at: runId
			ifPresent: [ :current | byTime add: current copy ] ]
]

{ #category : 'updating' }
RMDExperimentarium >> updatePopulationChart [

	(showPopulationChartRadioButton state and: [
		 visualizationImage adapter notNil ]) ifTrue: [
		| form |
		self interpreterDo: [ :interpreter |
			| runId canvas byTime |
			runId := interpreter runId.
			form := Form extent: visualizationImage adapter extent depth: 32.
			canvas := form getCanvas.
			canvas fillColor: Color white.
			byTime := populationByTime at: runId ifAbsent: [ ^ self ].
			byTime ifEmpty: [ ^ self ].
			populationTable selectedItem ifNotNil: [ :animat |
				| chartWidth chartHeight font fontHeight min max |
				font := TextStyle defaultFont.
				fontHeight := font height.
				chartWidth := form width.
				chartHeight := form height - (fontHeight * 2).
				min := (minPopulation at: runId ifAbsent: [ ^ self ])
					       at: animat
					       ifAbsent: [ ^ self ].
				max := (maxPopulation at: runId ifAbsent: [ ^ self ])
					       at: animat
					       ifAbsent: [ ^ self ].
				min < max ifTrue: [
					| xScale yScale minString maxString |
					xScale := chartWidth
					          /
					          (interpreter duration / interpreter deltaTime) ceiling.
					yScale := chartHeight / (max - min).
					minString := 'min = ' , min printString.
					maxString := 'max = ' , max printString.
					canvas
						drawString: minString
						at: 0 @ (chartHeight - fontHeight)
						font: font
						color: Color gray.
					canvas
						drawString: maxString
						at: 0 @ 0
						font: font
						color: Color gray.
					canvas
						line: interpreter time * xScale @ 0
						to: interpreter time * xScale @ chartHeight
						width: 1
						color: Color red.
					1 to: byTime size - 1 do: [ :time1 |
						| time2 value1 value2 |
						time2 := time1 + 1.
						value1 := (byTime at: time1) at: animat.
						value2 := (byTime at: time2) at: animat.
						canvas
							line: (time1 * xScale) rounded
								@ (chartHeight - (value1 - min * yScale) rounded)
							to: (time2 * xScale) rounded
								@ (chartHeight - (value2 - min * yScale) rounded)
							width: 1
							color: Color black ] ].
				canvas
					drawString: '0'
					at: 0 @ chartHeight
					font: font
					color: Color gray.
				byTime size > 1 ifTrue: [
					| time timeUnit timeString |
					time := byTime size - 1 * interpreter deltaTime.
					timeUnit := interpreter durationUnit.
					timeString := ((timeUnit fromSI: time)
						               printShowingDecimalPlaces: 1) , ' ['
					              , timeUnit printString , ']'.
					canvas
						drawString: timeString
						at: chartWidth - (font widthOfString: timeString) @ chartHeight
						font: font
						color: Color gray ].
				visualizationImage image: form ] ] ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateTableItems [

	populationTable items: (Array streamContents: [ :stream | 
			 self interpreterDo: [ :interpreter | 
				 | model |
				 model := interpreter simulationModel.
				 model speciesNames do: [ :species | 
					 stream nextPut: species.
					 model animatDefinitionsDo: [ :animat | 
						 animat species = species ifTrue: [ 
							 stream nextPut: self stagePrefix , animat name ] ] ] ] ]).
	populationTable items ifNotEmpty: [ populationTable selectIndex: 1 ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateTimeLabel [

	self interpreterDo: [ :interpreter | 
		| time |
		time := interpreter time.
		timeLabel label: (String streamContents: [ :stream | 
				 4 timesRepeat: [ stream space ].
				 interpreter simulationModel simulationDefinition timeDefinition 
					 printOn: stream.
				 stream nextPutAll: ' - now '.
				 (interpreter durationUnit fromSI: time)
					 printOn: stream
					 showingDecimalPlaces: 1.
				 stream nextPutAll: ' [ '.
				 interpreter durationUnit printOn: stream.
				 stream nextPutAll: ' ], '.
				 interpreter ticks printOn: stream.
				 stream nextPutAll: ' steps.' ]) ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateTimeProgressBar [

	| now |
	now := DateAndTime now.
	(lastDisplayUpdate isNil or: [ 
		 now - lastDisplayUpdate > 100 milliSecond ]) ifTrue: [ 
		lastDisplayUpdate := now.
		self basicUpdateTimeProgressBar ]
]

{ #category : 'updating' }
RMDExperimentarium >> updateVisualMap [

	(showVisualMapRadioButton state and: [ 
		 visualizationImage adapter notNil ]) ifTrue: [ 
		self interpreterDo: [ :interpreter | 
			| visualizer |
			visualizer := RMDVisualizer new.
			interpreter simulationModel renderersDo: [ :renderer | 
				visualizer addRenderer: renderer ].
			visualizer extent: visualizationImage adapter extent.
			visualizationImage image: (visualizer visualize: interpreter) ] ]
]

{ #category : 'private' }
RMDExperimentarium >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self title ]
]
