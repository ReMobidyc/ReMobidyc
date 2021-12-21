Class {
	#name : #RMDObservatory,
	#superclass : #RMDPresenter,
	#instVars : [
		'modelName',
		'interpreter',
		'views',
		'runButton',
		'process',
		'visualizer',
		'stepButton',
		'timeLabel',
		'timeSlider',
		'time',
		'duration',
		'lastServerUpdate'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDObservatory class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #stepButton expand: false;
				add: #runButton expand: false;
				add:
					(SpBoxLayout newVertical
						add: #timeLabel;
						add: (SpBoxLayout newHorizontal add: #timeSlider width: 500);
						yourself);
				yourself)
			height: self buttonHeight;
		add: #views yourself
]

{ #category : #'instance creation' }
RMDObservatory class >> interpreter: aRMDInterpreter [
	^ self new
		setInterpreter: aRMDInterpreter;
		yourself
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
								    updateObservation;
								    yourself) ];
				   whenRetrievedDo: [ :content | content presenter updateObservation ];
				   title: 'Percentile';
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

{ #category : #private }
RMDObservatory >> cellInspector [
	^ self newNotebook
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDCellTabularInspector new interpreter: interpreter ];
				whenRetrievedDo: [ :content | content updateObservation ];
				title: 'Table';
				yourself);
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDCellPercentileInspector new
						interpreter: interpreter;
						updateObservation;
						yourself ];
				whenRetrievedDo: [ :content | content updateObservation ];
				title: 'Percentile';
				yourself);
		yourself
]

{ #category : #api }
RMDObservatory >> forceKill [
	self runState: false.
	process ifNotNil: #terminate
]

{ #category : #updating }
RMDObservatory >> informServer [
	(lastServerUpdate isNil
		or: [ DateAndTime now - lastServerUpdate >= self serverUpdateInterval ])
		ifTrue: [ self basicInformServer ]
]

{ #category : #initialization }
RMDObservatory >> initializePresenters [
	super initializePresenters.
	views := self newNotebook.
	timeLabel := self newLabel
		label: '0';
		yourself.
	timeSlider := self newSlider
		min: 0;
		max: 1;
		value: 0;
		whenValueChangedDo: [ interpreter
				ifNotNil: [ runButton state
						ifFalse: [ (time / duration - timeSlider value) abs > 1.0e-8
								ifTrue: [ interpreter time: timeSlider value * duration ] ] ] ];
		yourself.
	runButton := self newButton
		label: 'run';
		action: [ self runState: self runState not ];
		state: false;
		whenStateChangedDo: [ :state | 
			state == true
				ifTrue: [ process := [ stepButton enabled: false.
					timeSlider enabled: false.
					[ self runState == true ]
						whileTrue: [ interpreter
								ifNotNil: [ interpreter stepSimulation
										ifFalse: [ self runState: false ].
									0 milliSecond wait ] ].
					process := nil.
					stepButton enabled: true.
					timeSlider enabled: true ]
						forkAt: Processor userBackgroundPriority ] ];
		yourself.
	stepButton := self newButton
		label: 'step';
		action: [ self stepSimulation ];
		enabled: true;
		yourself.
	self whenDisplayDo: [ (views pageAt: 1) activePresenter updateImage ]
]

{ #category : #initialization }
RMDObservatory >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Re:Mobidyc - Observatory';
		initialExtent: 800 @ 600
]

{ #category : #accessing }
RMDObservatory >> modelName [
	^ modelName ifNil: [ modelName := self requestModelName ]
]

{ #category : #accessing }
RMDObservatory >> modelName: aString [
	modelName := aString
]

{ #category : #api }
RMDObservatory >> progress [
	^ time / duration
]

{ #category : #accessing }
RMDObservatory >> requestModelName [
	^ UIManager default request: 'model name' initialAnswer: 'Sugar Scape'
]

{ #category : #api }
RMDObservatory >> resetSimulation [
	interpreter setupSimulation
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
	visualizer := RMDVisualizer new.
	interpreter simulationModel
		renderersDo: [ :renderer | visualizer addRenderer: renderer ].
	interpreter announcer weak
		when: RMDTimeChanged
		send: #timeChanged
		to: self.
	views
		pages:
			(Array
				streamContents: [ :stream | 
					stream
						nextPut:
							(self newNotebookPage
								presenterProvider: [ visualizer asPresenter
										interpreter: interpreter;
										updateImage;
										yourself ];
								whenRetrievedDo: [ :content | content updateImage ];
								title: 'Map').
					interpreter worldDefinition allPropertyDeclarations
						ifNotEmpty: [ stream
								nextPut:
									(self newNotebookPage
										presenterProvider: [ self worldInspector ];
										title: 'World') ].
					interpreter cellDefinition allPropertyDeclarations
						ifNotEmpty: [ stream
								nextPut:
									(self newNotebookPage
										presenterProvider: [ self cellInspector ];
										title: 'Cell') ].
					interpreter animatNames
						do: [ :animat | 
							stream
								nextPut:
									(self newNotebookPage
										presenterProvider: [ self animatInspector: animat ];
										title: animat) ] ]).
	duration := interpreter simulationModel simulationDefinition
		timeDefinition duration evalIn: interpreter.
	timeSlider quantum: interpreter deltaTime / interpreter duration.
	self
		updateTimeLabel;
		resetSimulation
]

{ #category : #api }
RMDObservatory >> stepSimulation [
	self runState: false.
	[ process isNil or: [ process isTerminated ] ]
		whileFalse: [ 1 milliSecond wait ].
	interpreter stepSimulation
]

{ #category : #updating }
RMDObservatory >> timeChanged [
	self
		informServer;
		updateTimeLabel
]

{ #category : #api }
RMDObservatory >> toggleRunPauseSimulation [
	self runState: self runState not
]

{ #category : #updating }
RMDObservatory >> updateTimeLabel [
	interpreter
		ifNotNil: [ time := interpreter time.
			timeLabel
				label:
					(String
						streamContents: [ :stream | 
							4 timesRepeat: [ stream space ].
							interpreter simulationModel simulationDefinition timeDefinition
								printOn: stream.
							stream nextPutAll: ' - now '.
							(interpreter simulationDefinition timeDefinition duration unit
								fromSI: time) printOn: stream showingDecimalPlaces: 3.
							stream nextPutAll: ' [ '.
							interpreter simulationDefinition timeDefinition duration unit
								printOn: stream.
							stream nextPutAll: ' ]' ]).
			timeSlider value: time / duration ]
]

{ #category : #private }
RMDObservatory >> worldInspector [
	^ self newNotebook
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDWorldTabularInspector new interpreter: interpreter ];
				whenRetrievedDo: [ :content | content updateObservation ];
				title: 'Table';
				yourself);
		addPage:
			(self newNotebookPage
				presenterProvider: [ RMDWorldPercentileInspector new
						interpreter: interpreter updateObservation;
						yourself ];
				whenRetrievedDo: [ :content | content updateObservation ];
				title: 'Percentile';
				yourself);
		yourself
]
