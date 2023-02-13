Class {
	#name : #RMDIndividualByTimeTabular,
	#superclass : #RMDTimeSeriesTabular,
	#instVars : [
		'stageDropList'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #layout }
RMDIndividualByTimeTabular class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignEnd;
				   add:
					   (SpBoxLayout newVertical
						    add: #reloadButton
						    height: self buttonHeight)
				   width: self buttonHeight;
				   addSpace;
				   add: (SpBoxLayout newVertical
						    add: 'Run';
						    add: #runDropList);
				   add: (SpBoxLayout newVertical
						    add: 'Stage';
						    add: #stageDropList);
				   yourself)
		  expand: false;
		  add: #table;
		  add: (SpBoxLayout newHorizontal
				   add: #openTabularButton width: self buttonHeight;
				   add: #openObservatoryButton width: self buttonHeight;
				   add: '    ' expand: false;
				   add: #exportCSVButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #'instance creation' }
RMDIndividualByTimeTabular class >> on: aRMDMetaInterpreter runId: runId individual: id time: secondsSinceEpoch [

	^ (self on: aRMDMetaInterpreter)
		  initializeWithRunId: runId
		  animat: id
		  time: secondsSinceEpoch
]

{ #category : #initialization }
RMDIndividualByTimeTabular >> initializePresenters [

	super initializePresenters.
	runDropList disable.
	stageDropList := self newDropList
		                 display: [ :assoc | 
			                 assoc value first , ' ('
			                 , assoc value second printString , ')' ];
		                 whenSelectedItemChangedDo: [ self stageChanged ];
		                 yourself
]

{ #category : #initialization }
RMDIndividualByTimeTabular >> initializeWithRunId: runId animat: animatId time: secondsSinceEpoch [

	(metaInterpreter interpreterAt: runId ifAbsent: [ nil ]) ifNotNil: [ 
		:interpreter | 
		| memory t0 timeIntervalsAndIds |
		runDropList
			items: { runId };
			selectIndex: 1.
		memory := interpreter memory.
		t0 := (secondsSinceEpoch / interpreter deltaTime) rounded.
		memory time: t0.
		timeIntervalsAndIds := OrderedCollection with: (t0 to: t0) -> { 
				                       (memory
					                        animatOfIndividual: animatId
					                        ifAbsent: [ ^ self ]).
				                       animatId }.
		self searchHistoryBackward: timeIntervalsAndIds memory: memory.
		self searchHistoryForward: timeIntervalsAndIds memory: memory.
		stageDropList
			items: timeIntervalsAndIds;
			selectItem: (timeIntervalsAndIds
					 detect: [ :assoc | assoc key includes: t0 ]
					 ifNone: [ nil ]) ]
]

{ #category : #private }
RMDIndividualByTimeTabular >> searchHistoryBackward: anOrderedCollectionOfTimeIntervalAndAnimatId memory: memory [

	| t animat id prevId |
	t := anOrderedCollectionOfTimeIntervalAndAnimatId first key first.
	animat := anOrderedCollectionOfTimeIntervalAndAnimatId first value
		          first.
	id := anOrderedCollectionOfTimeIntervalAndAnimatId first value second.
	memory time: t.
	prevId := memory previousStageOf: id.
	[ 
	[ 
	t >= 0 and: [ 
		memory time: t.
		memory animat: animat includes: id ] ] whileTrue: [ t := t - 1 ].
	anOrderedCollectionOfTimeIntervalAndAnimatId
		at: 1
		put:
			(t + 1 to:
			 anOrderedCollectionOfTimeIntervalAndAnimatId first key last)
			-> { 
					animat.
					id }.
	t >= 0 and: [ prevId notNil ] ] whileTrue: [ 
		id := prevId.
		prevId := memory previousStageOf: id.
		animat := memory
			          animatOfIndividual: id
			          ifAbsent: [ 
			          ^ self error: 'Link and Animats do not agree.' ].
		anOrderedCollectionOfTimeIntervalAndAnimatId addFirst:
			(t to: t) -> { 
				animat.
				id } ]
]

{ #category : #private }
RMDIndividualByTimeTabular >> searchHistoryForward: anOrderedCollectionOfTimeIntervalAndAnimatId memory: memory [

	| t animat id |
	t := anOrderedCollectionOfTimeIntervalAndAnimatId last key last.
	animat := anOrderedCollectionOfTimeIntervalAndAnimatId last value
		          first.
	id := anOrderedCollectionOfTimeIntervalAndAnimatId last value second.
	memory time: t.
	[ 
	[ 
	t <= memory latestTime and: [ 
		memory time: t.
		memory animat: animat includes: id ] ] whileTrue: [ t := t + 1 ].
	anOrderedCollectionOfTimeIntervalAndAnimatId
		at: anOrderedCollectionOfTimeIntervalAndAnimatId size
		put:
			(anOrderedCollectionOfTimeIntervalAndAnimatId last key first to:
			 t - 1) -> { 
				animat.
				id }.
	t >= 0 and: [ 
		id := memory previously: id.
		id notNil ] ] whileTrue: [ 
		animat := memory
			          animatOfIndividual: id
			          ifAbsent: [ 
			          ^ self error: 'Link and Animats do not agree.' ].
		anOrderedCollectionOfTimeIntervalAndAnimatId addLast:
			(t to: t) -> { 
				animat.
				id } ]
]

{ #category : #accessing }
RMDIndividualByTimeTabular >> selectTime: anInteger [

	| t |
	t := (anInteger / metaInterpreter simulationModel deltaTime) rounded.
	stageDropList selectItem: (stageDropList items
			 detect: [ :assoc | assoc key includes: t ]
			 ifNone: [ nil ])
]

{ #category : #private }
RMDIndividualByTimeTabular >> selectedIndividual [

	^ stageDropList selectedItem ifNotNil: [ :assoc | assoc value second ]
]

{ #category : #private }
RMDIndividualByTimeTabular >> selectedTime [

	| t0 t |
	t0 := stageDropList selectedItem
		      ifNotNil: [ :assoc | assoc key first ]
		      ifNil: [ ^ nil ].
	t := table selection selectedIndex - baseRowIndex max: 0.
	^ t0 + t * metaInterpreter simulationModel deltaTime
]

{ #category : #updating }
RMDIndividualByTimeTabular >> stageChanged [

	self
		updateTable
]

{ #category : #initialization }
RMDIndividualByTimeTabular >> title [

	^ 'Individual''s Attributes Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : #updating }
RMDIndividualByTimeTabular >> updateColumns [

	table columns: (Array streamContents: [ :stream | 
			 stageDropList selectedItem ifNotNil: [ :assoc | 
				 (metaInterpreter
					  interpreterAt: runDropList selectedItem
					  ifAbsent: [ nil ]) ifNotNil: [ :interpreter | 
					 (interpreter simulationModel
						  animatDefinitionAt: assoc value first
						  ifAbsent: [ nil ]) ifNotNil: [ :stage | 
						 stream nextPut:
							 (RMDTimeColumn unit: interpreter simulationModel durationUnit).
						 stage allAttributeDeclarationsDo: [ :attribute | 
							 stream nextPut: (RMDAttributeColumn attribute: attribute) ] ] ] ] ])
]

{ #category : #enumerating }
RMDIndividualByTimeTabular >> updateRows [

	table
		items: (Array streamContents: [ :stream | 
					 (metaInterpreter
						  interpreterAt: runDropList selectedItem
						  ifAbsent: [ nil ]) ifNotNil: [ :interpreter | 
							 | simulationModel memory |
							 simulationModel := interpreter simulationModel.
							 memory := interpreter memory.
							 stageDropList selectedItem ifNotNil: [ :assoc | 
									 | interval stageName individual |
									 interval := assoc key.
									 stageName := assoc value first.
									 individual := assoc value second.
									 (interpreter simulationModel
										  animatDefinitionAt: stageName
										  ifAbsent: [ nil ]) ifNotNil: [ :animat | 
											 'Collecting data from the run record'
												 displayProgressFrom: interval first
												 to: interval last
												 during: [ :progress | 
													 interval do: [ :time | 
															 | row |
															 row := Dictionary new.
															 memory time: time.
															 row at: #time put: interpreter time.
															 animat attributeOffsetsDo: [ :attribute :offset | 
																	 row
																		 at: attribute
																		 put: (memory at: individual + offset) ].
															 stream nextPut: row.
															 progress value: time ] ] ] ] ] ]);
		refresh
]

{ #category : #updating }
RMDIndividualByTimeTabular >> updateTable [

	self
		updateRows;
		updateColumns
]
