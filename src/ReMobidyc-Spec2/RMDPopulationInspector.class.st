Class {
	#name : #RMDPopulationInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'metaInterpreter',
		'interpreterDropList',
		'timeLabel',
		'populationTable',
		'populationChart',
		'currentPopulation',
		'maxPopulation',
		'minPopulation',
		'populationByTime',
		'lastUpdateTime'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #layout }
RMDPopulationInspector class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.3;
				   add: #interpreterDropList;
				   add: #timeLabel)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: #populationTable;
				   add: #populationChart width: 400;
				   yourself)
		  height: 300;
		  yourself
]

{ #category : #'instance creation' }
RMDPopulationInspector class >> on: aRMDInterpreter [

	^ self new
		  interpreter: aRMDInterpreter;
		  yourself
]

{ #category : #initialization }
RMDPopulationInspector >> initialize [

	super initialize.
	currentPopulation := Dictionary new.
	maxPopulation := Dictionary new.
	minPopulation := Dictionary new.
	populationByTime := Dictionary new
]

{ #category : #initialization }
RMDPopulationInspector >> initializePresenters [

	super initializePresenters.
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
		                   whenSelectionChangedDo: [ 
			                   self updatePopulationChart ];
		                   yourself.
	populationChart := self newImage
		                   autoScale: true;
		                   image: (Form extent: 400 @ 300 depth: 32);
		                   yourself
]

{ #category : #accessing }
RMDPopulationInspector >> interpreter: aRMDInterpreter [

	metaInterpreter ifNotNil: [ 
		metaInterpreter isMetaInterpreter
			ifTrue: [ 
				metaInterpreter interpretersDo: [ :i | 
					i announcer unsubscribe: self ] ]
			ifFalse: [ metaInterpreter announcer unsubscribe: self ] ].
	metaInterpreter := aRMDInterpreter.
	currentPopulation := Dictionary new.
	maxPopulation := Dictionary new.
	minPopulation := Dictionary new.
	populationByTime := Dictionary new.
	metaInterpreter isMetaInterpreter
		ifTrue: [ 
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
				enable ]
		ifFalse: [ 
			| runId |
			runId := metaInterpreter runId.
			currentPopulation at: runId put: Dictionary new.
			maxPopulation at: runId put: Dictionary new.
			minPopulation at: runId put: Dictionary new.
			populationByTime at: runId put: (OrderedCollection new: 1024).
			metaInterpreter announcer weak
				when: RMDSimulationStarted send: #simulationStarted: to: self;
				when: RMDTimeChanged send: #timeChanged: to: self;
				when: RMDSimulationPaused send: #simulationPaused: to: self.
			interpreterDropList
				items: #(  );
				disable ].
	self
		updateTableItems;
		updateDisplay
]

{ #category : #accessing }
RMDPopulationInspector >> interpreterDo: aBlock [

	metaInterpreter isMetaInterpreter
		ifTrue: [ 
			(metaInterpreter
				 interpreterAt: self runId
				 ifAbsent: [ nil ]) ifNotNil: aBlock ]
		ifFalse: [ metaInterpreter ifNotNil: aBlock ]
]

{ #category : #printing }
RMDPopulationInspector >> printNat: anInteger [

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

{ #category : #accessing }
RMDPopulationInspector >> runId [

	^ interpreterDropList selectedItem ifNil: [ 1 ]
]

{ #category : #updating }
RMDPopulationInspector >> simulationPaused: aRMDSimulationStarted [

	self updateDisplay
]

{ #category : #updating }
RMDPopulationInspector >> simulationStarted: aRMDSimulationStarted [
]

{ #category : #accessing }
RMDPopulationInspector >> stagePrefix [
	^ '  '
]

{ #category : #updating }
RMDPopulationInspector >> timeChanged: aRMDTimeChanged [

	self updateObservation: aRMDTimeChanged.
	self interpreterDo: [ :interpreter | 
		| now |
		interpreter = aRMDTimeChanged interpreter ifTrue: [ 
			now := DateAndTime now.
			(lastUpdateTime isNil or: [ now - lastUpdateTime > 200 milliSecond ]) 
				ifTrue: [ 
					lastUpdateTime := now.
					self updateDisplay ] ] ]
]

{ #category : #updating }
RMDPopulationInspector >> updateDisplay [

	populationTable ifNotNil: #refresh.
	self
		updatePopulationChart;
		updateTimeLabel
]

{ #category : #updating }
RMDPopulationInspector >> updateObservation: aRMDTimeChanged [

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

{ #category : #updating }
RMDPopulationInspector >> updatePopulationChart [

	| form |
	self interpreterDo: [ :interpreter | 
		| runId canvas byTime |
		runId := interpreter runId.
		form := populationChart image.
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
				          / (interpreter duration / interpreter deltaTime) ceiling.
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
				timeUnit := interpreter simulationModel simulationDefinition
					            timeDefinition duration unit.
				timeString := ((timeUnit fromSI: time) printShowingDecimalPlaces:
					               1) , ' [' , timeUnit printString , ']'.
				canvas
					drawString: timeString
					at: chartWidth - (font widthOfString: timeString) @ chartHeight
					font: font
					color: Color gray ].
			populationChart image: form ] ].
	^ form
]

{ #category : #updating }
RMDPopulationInspector >> updateTableItems [

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

{ #category : #updating }
RMDPopulationInspector >> updateTimeLabel [

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
