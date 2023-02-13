Class {
	#name : #RMDPopulationByTimeTabular,
	#superclass : #RMDTimeSeriesTabular,
	#instVars : [
		'speciesDropList',
		'stageDropList'
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
						    add: 'Run';
						    add: #runDropList);
				   add: (SpBoxLayout newVertical
						    add: 'Species';
						    add: #speciesDropList);
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

{ #category : #initialization }
RMDPopulationByTimeTabular >> initializePresenters [

	super initializePresenters.
	speciesDropList := self newDropList
		                   display: [ :item | item ifNil: [ 'all species' ] ];
		                   whenSelectedItemChangedDo: [ self speciesChanged ];
		                   yourself.
	stageDropList := self newDropList
		                 display: [ :item | item ifNil: [ 'every stage' ] ];
		                 whenSelectedItemChangedDo: [ self stageChanged ];
		                 yourself
]

{ #category : #private }
RMDPopulationByTimeTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self updateRows.
	self updateSpeciesDropList.
	self updateStageDropList
]

{ #category : #private }
RMDPopulationByTimeTabular >> selectedIndividual [

	^ nil
]

{ #category : #updating }
RMDPopulationByTimeTabular >> speciesChanged [

	self updateColumns.
	self updateStageDropList
]

{ #category : #updating }
RMDPopulationByTimeTabular >> stageChanged [

	self updateColumns
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
RMDPopulationByTimeTabular >> updateColumns [

	table
		columns: (Array streamContents: [ :stream | 
					 stream nextPut:
							 (RMDTimeColumn unit:
									  metaInterpreter simulationModel durationUnit).
					 (runDropList selectedItem
						  ifNotNil: [ :runId | { runId } ]
						  ifNil: [ metaInterpreter runIds ]) do: [ :runId | 
							 (stageDropList selectedItem
								  ifNotNil: [ :stage | 
									  stage = #total
										  ifTrue: [ 
											  speciesDropList selectedItem
												  ifNotNil: [ :species | { species } ]
												  ifNil: [ metaInterpreter simulationModel speciesNames ] ]
										  ifFalse: [ 
											  { (metaInterpreter simulationModel
												   animatDefinitionAt: stage
												   ifAbsent: [ nil ]) } ] ]
								  ifNil: [ 
									  speciesDropList selectedItem
										  ifNotNil: [ :species | 
											  (metaInterpreter simulationModel stagesOf: species)
											  , { species } ]
										  ifNil: [ 
											  metaInterpreter simulationModel animatDefinitions ] ]) 
								 do: [ :animatDefinitionOrSpecies | 
									 animatDefinitionOrSpecies isString
										 ifTrue: [ 
											 stream nextPut: (RMDPopulationColumn new
														  title: (runDropList selectedItem
																   ifNotNil: [ '' ]
																   ifNil: [ runId printString , ': ' ])
															  , animatDefinitionOrSpecies;
														  runIds: { runId };
														  stages:
															  (metaInterpreter simulationModel stageNamesOf:
																	   animatDefinitionOrSpecies)) ]
										 ifFalse: [ 
											 stream nextPut: (RMDPopulationColumn new
													  title: (runDropList selectedItem
															   ifNotNil: [ '' ]
															   ifNil: [ runId printString , ': ' ])
														  , (speciesDropList selectedItem
																   ifNotNil: [ '' ]
																   ifNil: [ animatDefinitionOrSpecies species , ' (' ])
														  , animatDefinitionOrSpecies identifier
														  ,
															  (speciesDropList selectedItem
																   ifNotNil: [ '' ]
																   ifNil: [ ')' ]);
													  runIds: { runId };
													  stages: { animatDefinitionOrSpecies identifier };
													  yourself) ] ] ] ]);
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
RMDPopulationByTimeTabular >> updateSpeciesDropList [

	speciesDropList items: (Array streamContents: [ :stream | 
			 stream nextPut: nil.
			 self speciesDo: [ :species | stream nextPut: species ] ])
]

{ #category : #updating }
RMDPopulationByTimeTabular >> updateStageDropList [

	stageDropList items: (Array streamContents: [ :stream | 
			 stream nextPut: nil.
			 speciesDropList selectedItem
				 ifNotNil: [ :species | 
					 self
						 stagesOf: species
						 do: [ :stage | stream nextPut: stage identifier ] ]
				 ifNil: [ 
				 self stagesDo: [ :stage | stream nextPut: stage identifier ] ].
			 stream nextPut: #total ])
]
