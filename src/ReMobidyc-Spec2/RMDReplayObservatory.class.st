Class {
	#name : #RMDReplayObservatory,
	#superclass : #RMDPresenter,
	#traits : 'TRMDLaunchAnalysisTools',
	#classTraits : 'TRMDLaunchAnalysisTools classTrait',
	#instVars : [
		'metaInterpreter',
		'timeSlider',
		'runDropList',
		'timeLabel',
		'image',
		'stepButton',
		'runButton',
		'runProcess',
		'resetButton',
		'reloadButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDReplayObservatory class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add:
					   (SpBoxLayout newVertical
						    add: #reloadButton
						    height: self buttonHeight)
				   width: self buttonHeight;
				   add: '    ' expand: false;
				   add:
					   (SpBoxLayout newVertical
						    add: #resetButton
						    height: self buttonHeight)
				   width: self buttonHeight;
				   add:
					   (SpBoxLayout newVertical
						    add: #stepButton
						    height: self buttonHeight)
				   width: self buttonHeight;
				   add:
					   (SpBoxLayout newVertical
						    add: #runButton
						    height: self buttonHeight)
				   width: self buttonHeight;
				   add: (SpBoxLayout newVertical
						    add: #timeLabel expand: false;
						    add: #timeSlider expand: false;
						    yourself)
				   expand: true;
				   yourself)
		  height: self buttonHeight;
		  add: (SpBoxLayout newHorizontal
				   add: #runDropList width: 200;
				   yourself)
		  expand: false;
		  add: #image;
		  add: (SpBoxLayout newHorizontal
				   add: #openTabularButton width: self buttonHeight;
				   add: #openObservatoryButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #'instance creation' }
RMDReplayObservatory class >> metaInterpreter: aRMDMetaInterpreter [

	^ self new
		  metaInterpreter: aRMDMetaInterpreter;
		  yourself
]

{ #category : #testing }
RMDReplayObservatory >> canOpenAnalysis [

	^ metaInterpreter notNil and: [ 
		  metaInterpreter context isForFileMemory ]
]

{ #category : #accessing }
RMDReplayObservatory >> imageExtent [

	^ 600 @ 600
]

{ #category : #initialization }
RMDReplayObservatory >> initializePresenters [

	super initializePresenters.
	self initializeOpenAnalysisButtonsPresenters.
	runDropList := self newDropList
		               display: [ :runId | 
			               (metaInterpreter
				                interpreterAt: runId
				                ifAbsent: [ nil ])
				               ifNotNil: #shortName
				               ifNil: [ '-' ] ];
		               whenSelectedItemChangedDo: [ self runDropListChanged ];
		               yourself.
	reloadButton := self newButton
		                icon: self updateIcon;
		                action: [ self reloadMemory ];
		                yourself.
	resetButton := self newButton
		               icon: self resetIcon;
		               action: [ self resetSimulation ];
		               yourself.
	runButton := self newButton
		             icon: self runIcon;
		             state: false;
		             action: [ self toggleSimulation ];
		             yourself.
	stepButton := self newButton
		              icon: self stepIcon;
		              action: [ self stepSimulation ];
		              yourself.
	timeSlider := self newSlider
		              disable;
		              min: 0;
		              max: 1;
		              value: 0;
		              whenValueChangedDo: [ self timeSliderChanged ];
		              yourself.
	timeLabel := self newLabel
		             label: '-';
		             yourself.
	image := self newImage
		         autoScale: true;
		         yourself
]

{ #category : #initialization }
RMDReplayObservatory >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 510 @ 600
]

{ #category : #accessing }
RMDReplayObservatory >> interpreterDo: aBlock [

	(metaInterpreter
		 interpreterAt: runDropList selectedItem
		 ifAbsent: [ nil ]) ifNotNil: aBlock
]

{ #category : #private }
RMDReplayObservatory >> metaInterpreter: aRMDMetaInterpreter [

	metaInterpreter := aRMDMetaInterpreter.
	metaInterpreter setupSimulation.
	self metaInterpreterChanged
]

{ #category : #updating }
RMDReplayObservatory >> metaInterpreterChanged [

	self
		updateRunDropList;
		updateTimeSlider;
		updateTimeLabel;
		updateVisual;
		updateOpenAnalysisButtons
]

{ #category : #private }
RMDReplayObservatory >> metaInterpreterForTabularDo: aBlock [

	^ (metaInterpreter notNil and: [ 
		   metaInterpreter context isForFileMemory ]) ifTrue: [ 
		  aBlock value:
			  (metaInterpreter simulationModel 
				   metaInterpreterOnReadOnlyModelPath:
				   metaInterpreter context modelPath) ]
]

{ #category : #operations }
RMDReplayObservatory >> open [

	^ super open
		  whenWillCloseDo: [ 
			  self stopSimulation.
			  runProcess ifNotNil: #terminate ];
		  yourself
]

{ #category : #operations }
RMDReplayObservatory >> reloadMemory [

	metaInterpreter reloadMemory.
	self updateTimeSlider
]

{ #category : #operations }
RMDReplayObservatory >> resetSimulation [

	self interpreterDo: [ :interpreter | timeSlider value: 0 ]
]

{ #category : #updating }
RMDReplayObservatory >> runDropListChanged [

	self interpreterDo: [ :interpreter | 
		timeSlider quantum: interpreter deltaTime / interpreter duration ].
	self
		updateTimeLabel;
		updateVisual
]

{ #category : #operations }
RMDReplayObservatory >> runSimulation [

	runButton state: true.
	self updateButtons.
	(runProcess isNil or: [ runProcess isRunning not ]) ifTrue: [ 
		runProcess := [ 
		              [ runButton state ] whileTrue: [ 
			              self stepSimulation.
			              100 milliSecond wait ].
		              runButton state: false.
		              self updateButtons.
		              runProcess := nil ] forkAt:
			              Processor userBackgroundPriority ]
]

{ #category : #private }
RMDReplayObservatory >> selectRunId: anInteger [

	runDropList selectItem: anInteger
]

{ #category : #private }
RMDReplayObservatory >> selectTime: aNumber [

	aNumber ifNil: [ ^ self ].
	self stopSimulation.
	self interpreterDo: [ :interpreter | 
		timeSlider value:
			(aNumber / metaInterpreter simulationModel deltaTime) rounded
				asFloat / (interpreter memory latestTime max: 1) ]
]

{ #category : #private }
RMDReplayObservatory >> selectedIndividual [

	^ nil
]

{ #category : #private }
RMDReplayObservatory >> selectedRunId [

	^ runDropList selectedItem
]

{ #category : #private }
RMDReplayObservatory >> selectedTime [

	^ (metaInterpreter
		   interpreterAt: runDropList selectedItem
		   ifAbsent: [ nil ]) ifNotNil: [ :interpreter | interpreter time ]
]

{ #category : #accessing }
RMDReplayObservatory >> simulationModelDo: aBlock [

	(metaInterpreter
		 interpreterAt: runDropList selectedItem
		 ifAbsent: [ nil ]) ifNotNil: [ :interpreter | 
		aBlock value: interpreter simulationModel ]
]

{ #category : #operations }
RMDReplayObservatory >> stepSimulation [

	self interpreterDo: [ :interpreter | 
		interpreter memory time < interpreter memory latestTime
			ifTrue: [ 
				timeSlider value:
					timeSlider value
					+ interpreter memory latestTime asFloat reciprocal ]
			ifFalse: [ self stopSimulation ] ]
]

{ #category : #operations }
RMDReplayObservatory >> stopSimulation [

	runButton state: false
]

{ #category : #updating }
RMDReplayObservatory >> timeSliderChanged [

	self interpreterDo: [ :interpreter | 
		interpreter memory time:
			(timeSlider value * interpreter memory latestTime) rounded ].
	self
		updateTimeLabel;
		updateVisual
]

{ #category : #accessing }
RMDReplayObservatory >> title [

	^ 'Replay Observatory' , ((metaInterpreter ifNotNil: #modelName)
		   ifNil: [ '' ]
		   ifNotNil: [ :name | ' @ ' , name ]) , (metaInterpreter
		   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
		   ifNil: [ '' ])
]

{ #category : #operations }
RMDReplayObservatory >> toggleSimulation [

	runButton state
		ifTrue: [ self stopSimulation ]
		ifFalse: [ self runSimulation ]
]

{ #category : #operations }
RMDReplayObservatory >> updateButtons [

	runButton state
		ifTrue: [ 
			resetButton disable.
			stepButton disable.
			reloadButton disable.
			timeSlider disable ]
		ifFalse: [ 
			resetButton enable.
			stepButton enable.
			reloadButton enable.
			timeSlider enable ]
]

{ #category : #updating }
RMDReplayObservatory >> updateRunDropList [

	| selection items |
	selection := runDropList selectedItem.
	items := metaInterpreter runIds.
	runDropList
		items: items;
		selectItem: ((items includes: selection)
				 ifTrue: [ selection ]
				 ifFalse: [ items ifNotEmpty: #first ifEmpty: [ nil ] ])
]

{ #category : #updating }
RMDReplayObservatory >> updateTimeLabel [

	self interpreterDo: [ :interpreter | 
		| time |
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
				 stream nextPutAll: ' steps.' ]) ]
]

{ #category : #updating }
RMDReplayObservatory >> updateTimeSlider [

	self interpreterDo: [ :interpreter | 
		timeSlider
			value: interpreter memory time asFloat
				/ (interpreter memory latestTime max: 1);
			enable.
		^ self ].
	timeSlider
		disable;
		value: 0
]

{ #category : #updating }
RMDReplayObservatory >> updateVisual [

	self interpreterDo: [ :interpreter | 
		| visualizer |
		visualizer := RMDVisualizer new.
		interpreter simulationModel renderersDo: [ :renderer | 
			visualizer addRenderer: renderer ].
		visualizer extent: self imageExtent.
		image image: (visualizer visualize: interpreter) ]
]
