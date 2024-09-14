Class {
	#name : #RMDPopulationByTimeTabular,
	#superclass : #RMDTimeSeriesTabular,
	#instVars : [
		'runAggregationDropList',
		'animatAggregationDropList',
		'animatDropList',
		'speciesDropList',
		'stageDropList',
		'openLineChartButton'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #layout }
RMDPopulationByTimeTabular class >> defaultLayout [

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
						    add: 'Run Aggregation';
						    add: #runAggregationDropList);
				   add: (SpBoxLayout newVertical
						    add: 'meta-parameters';
						    add: #runDropList);
				   add: (SpBoxLayout newVertical
						    add: 'Animat Aggregation';
						    add: #animatAggregationDropList);
				   add: (SpBoxLayout newVertical
						    add: 'Species';
						    add: #animatDropList);
				   yourself)
		  expand: false;
		  add: #table;
		  add: (SpBoxLayout newHorizontal
				   add: #openTabularButton width: self buttonHeight;
				   add: #openObservatoryButton width: self buttonHeight;
				   add: '    ' expand: false;
				   add: #openLineChartButton width: self buttonHeight;
				   add: #exportCSVButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #aggregating }
RMDPopulationByTimeTabular >> aggregateAllAnimats [

	^ Array streamContents: [ :stream | 
		  stream nextPut: 'all'
			  ->
				  { ('all'
				   -> (metaInterpreter simulationModel animatDefinitions collect:
						    #identifier)) } ]
]

{ #category : #aggregating }
RMDPopulationByTimeTabular >> aggregateAllRuns [

	^ Array streamContents: [ :stream | 
		  stream nextPut: 'all' -> { ('' -> metaInterpreter runIds) } ]
]

{ #category : #aggregating }
RMDPopulationByTimeTabular >> aggregateByMetaparameters [

	| groups |
	groups := OrderedDictionary new.
	metaInterpreter interpretersDo: [ :interpreter | 
		(groups
			 at: interpreter metaparametersString
			 ifAbsentPut: [ OrderedCollection new ]) add: interpreter runId ].

	^ Array streamContents: [ :stream | 
		  stream nextPut: 'all' -> groups associations.
		  groups keysAndValuesDo: [ :metaparameters :runIds | 
			  stream nextPut: metaparameters -> { (metaparameters -> runIds) } ] ]
]

{ #category : #aggregating }
RMDPopulationByTimeTabular >> aggregateByRuns [

	| groups lister |
	groups := OrderedDictionary new.
	metaInterpreter interpretersDo: [ :interpreter | 
		(groups
			 at: interpreter metaparametersString
			 ifAbsentPut: [ OrderedCollection new ]) add: interpreter runId ].

	lister := [ :runs | 
	          runs
		          collect: [ :runId | 
			          (metaInterpreter interpreterAt: runId ifAbsent: [ nil ]) 
				          ifNotNil: [ :interpreter | 
				          interpreter shortName -> { runId } ] ]
		          thenSelect: #notNil ].

	^ Array streamContents: [ :stream | 
		  stream nextPut: 'all' -> (lister value: metaInterpreter runIds).
		  groups keysAndValuesDo: [ :metaparameters :runIds | 
			  stream nextPut: metaparameters -> (lister value: runIds) ] ]
]

{ #category : #aggregating }
RMDPopulationByTimeTabular >> aggregateBySpecies [

	| simulationModel groups |
	simulationModel := metaInterpreter simulationModel.
	groups := OrderedDictionary new.
	simulationModel animatDefinitionsDo: [ :animatDef | 
		(groups at: animatDef species ifAbsentPut: [ OrderedCollection new ]) 
			add: animatDef identifier ].
	^ Array streamContents: [ :stream | 
		  stream nextPut: 'all' -> groups associations.
		  groups keysAndValuesDo: [ :species :stages | 
			  stream nextPut: species -> { (species -> stages) } ] ]
]

{ #category : #aggregating }
RMDPopulationByTimeTabular >> aggregateByStages [

	| simulationModel groups |
	simulationModel := metaInterpreter simulationModel.
	groups := OrderedDictionary new.
	simulationModel animatDefinitionsDo: [ :animatDef | 
		(groups at: animatDef species ifAbsentPut: [ OrderedCollection new ]) 
			add: animatDef identifier ].
	^ Array streamContents: [ :stream | 
		  stream nextPut:
			  'all'
			  -> (simulationModel animatDefinitions collect: [ :animat | 
					   animat identifier -> { animat identifier } ]).
		  groups keysAndValuesDo: [ :species :stages | 
			  stream nextPut:
				  species -> (stages collect: [ :stage | stage -> { stage } ]) ] ]
]

{ #category : #updating }
RMDPopulationByTimeTabular >> animatAggregationChanged [
	self updateAnimatDropList
]

{ #category : #updating }
RMDPopulationByTimeTabular >> animatChanged [

	self updateColumns
]

{ #category : #initialization }
RMDPopulationByTimeTabular >> initializePresenters [

	super initializePresenters.
	runAggregationDropList := self newDropList
		                          display: [ :item | item key ];
		                          items: { 
				                          ('each run' -> #aggregateByRuns).
				                          ('by meta-parameters'
				                           -> #aggregateByMetaparameters).
				                          ('all' -> #aggregateAllRuns) };
		                          selectIndex: 1;
		                          whenSelectedItemChangedDo: [ 
			                          self runAggregationChanged ];
		                          yourself.
	animatAggregationDropList := self newDropList
		                             display: [ :item | item key ];
		                             items: { 
				                             ('stages' -> #aggregateByStages).
				                             ('species' -> #aggregateBySpecies).
				                             ('all' -> #aggregateAllAnimats) };
		                             selectIndex: 1;
		                             whenSelectedItemChangedDo: [ 
			                             self animatAggregationChanged ];
		                             yourself.
	runDropList
		display: [ :item | item key ];
		items: {  }.
	animatDropList := self newDropList
		                  display: [ :item | item key ];
		                  items: {  };
		                  whenSelectedItemChangedDo: [ self animatChanged ];
		                  yourself.
	openLineChartButton := self newButton
		                      icon: self lineChartIcon;
		                      action: [ self openChart ];
		                      help: 'Open a line chart';
		                      yourself
]

{ #category : #private }
RMDPopulationByTimeTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self
		updateRunDropList;
		updateAnimatDropList;
		updateColumns;
		updateRows
]

{ #category : #charts }
RMDPopulationByTimeTabular >> openChart [

	table columns ifNotEmpty: [ :columns | 
		| chart time canvas legend |
		chart := RSChart new.
		chart extent: 800 @ 400.
		time := table items collect: [ :row | columns first value: row ].
		columns do: [ :column | 
			column ifOnChartDo: [ 
				| y |
				y := (table items collect: [ :row | column value: row ]) reject:
					     #isNil.
				chart addPlot:
					(RSLinePlot new x: (time copyFrom: 1 to: y size) y: y) ] ].
		chart
			addDecoration: RSHorizontalTick new;
			addDecoration: RSVerticalTick new;
			addDecoration: (RSChartTitleDecoration new
					 title:
						 (runDropList selectedItem ifNotNil: #key ifNil: [ 'all' ])
						 , ' - '
						 , (animatDropList selectedItem ifNotNil: #key ifNil: [ 'all' ]);
					 fontSize: 10);
			addDecoration: (RSXLabelDecoration new
					 title:
						 'time ['
						 , metaInterpreter simulationModel durationUnit printString
						 , ']';
					 fontSize: 10);
			addDecoration: (RSYLabelDecoration new
					 title: 'Population';
					 fontSize: 10;
					 horizontal).
		canvas := chart build.
		legend := RSLegend new.
		legend container: canvas.
		1 to: chart plots size do: [ :plotIndex | 
			legend
				text: (columns at: plotIndex + 1) title
				withBoxColor: (chart plots at: plotIndex) line color ].
		legend build.
		(canvas openWithTitle: 'Population Chart'
			 ,
			 (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
			 , (metaInterpreter
					  ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
					  ifNil: [ '' ])) extent: 1000 @ 600 ]
]

{ #category : #updating }
RMDPopulationByTimeTabular >> runAggregationChanged [
	self updateRunDropList
]

{ #category : #private }
RMDPopulationByTimeTabular >> selectedIndividual [

	^ nil
]

{ #category : #initialization }
RMDPopulationByTimeTabular >> title [

	^ 'Population Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : #updating }
RMDPopulationByTimeTabular >> updateAnimatDropList [

	| selectedItem |
	selectedItem := animatDropList selectedItem.
	animatDropList items: (animatAggregationDropList selectedItem
			 ifNotNil: [ :assoc | self perform: assoc value ]
			 ifNil: [ {  } ]).
	selectedItem ifNotNil: [ 
		selectedItem := animatDropList items
			                detect: [ :item | item key = selectedItem key ]
			                ifNone: [ nil ].
		animatDropList selectItem: selectedItem ]
]

{ #category : #updating }
RMDPopulationByTimeTabular >> updateColumns [

	metaInterpreter ifNil: [ ^ self ].
	runDropList items
		ifNotEmpty: [ 
		runDropList selectedItem ifNil: [ runDropList selectIndex: 1 ] ]
		ifEmpty: [ ^ self ].
	animatDropList items
		ifNotEmpty: [ 
			animatDropList selectedItem ifNil: [ animatDropList selectIndex: 1 ] ]
		ifEmpty: [ ^ self ].
	table
		columns: (Array streamContents: [ :stream | 
					 stream nextPut:
							 (RMDTimeColumn unit:
									  metaInterpreter simulationModel durationUnit).
					 (runDropList selectedItem ifNil: [ runDropList items first ])
						 value do: [ :assoc1 | 
							 | runName runIds |
							 runName := assoc1 key.
							 runIds := assoc1 value.
							 (animatDropList selectedItem ifNil: [ 
									  animatDropList items first ]) value do: [ :assoc2 | 
									 | animatName stageNames |
									 animatName := assoc2 key.
									 stageNames := assoc2 value.
									 stream nextPut: (RMDPopulationColumn new
												  title: '(' , runName , ') ' , animatName;
												  runIds: runIds;
												  stages: stageNames) ] ] ]);
		refresh
]

{ #category : #updating }
RMDPopulationByTimeTabular >> updateRows [

	| latestTime |
	table showColumnHeaders.
	latestTime := self latestTime.
	'Collecting data from the run record'
		displayProgressFrom: 0
		to: latestTime
		during: [ :progress | 
			table items: (Array streamContents: [ :stream | 
					 0 to: latestTime do: [ :time | 
						 | row |
						 row := Dictionary new.
						 metaInterpreter interpretersDo: [ :interpreter | 
							 interpreter memory latestTime >= time ifTrue: [ 
								 interpreter memory time: time.
								 interpreter simulationModel animatDefinitionsDo: [ 
									 :animatDefinition | 
									 row
										 at: { 
												 interpreter runId.
												 animatDefinition identifier }
										 put:
										 (interpreter memory numberOfAnimats:
											  animatDefinition identifier) ].
								 row
									 at: #time
									 put: time * metaInterpreter simulationModel deltaTime ] ].
						 stream nextPut: row.
						 progress value: time ] ]) ]
]

{ #category : #updating }
RMDPopulationByTimeTabular >> updateRunDropList [

	| selectedItem |
	selectedItem := runDropList selectedItem.
	runDropList items: (runAggregationDropList selectedItem
			 ifNotNil: [ :assoc | self perform: assoc value ]
			 ifNil: [ {  } ]).
	selectedItem ifNotNil: [ 
		selectedItem := runDropList items
			                detect: [ :item | item key = selectedItem key ]
			                ifNone: [ nil ].
		runDropList selectItem: selectedItem ]
]
