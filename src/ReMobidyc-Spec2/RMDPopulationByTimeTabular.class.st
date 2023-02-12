Class {
	#name : #RMDPopulationByTimeTabular,
	#superclass : #RMDTimeSeriesTabular,
	#instVars : [
		'speciesDropList',
		'stageDropList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
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
		                 display: [ :item | item ifNil: [ 'all stages' ] ];
		                 whenSelectedItemChangedDo: [ self stageChanged ];
		                 yourself
]

{ #category : #private }
RMDPopulationByTimeTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self columnCollectors: (Array streamContents: [ :stream | 
			 metaInterpreter interpretersDo: [ :interpreter | 
				 metaInterpreter simulationModel animatDefinitionsDo: [ 
					 :animatDefinition | 
					 stream nextPut: (self
							  populationCollectorOnRunId: interpreter runId
							  animat: animatDefinition) ] ] ]).
	self updateSpeciesDropList.
	self updateStageDropList
]

{ #category : #'accessing - column collectors' }
RMDPopulationByTimeTabular >> populationCollectorOnRunId: anInteger animat: aRMDAnimatDefinition [

	^ { 
		  anInteger.
		  aRMDAnimatDefinition } -> [ :time | 
	  (metaInterpreter interpreterAt: anInteger ifAbsent: [ nil ]) 
		  ifNotNil: [ :interpreter | 
			  | memory |
			  memory := interpreter memory.
			  time <= memory latestTime
				  ifTrue: [ 
					  memory
						  time: time;
						  numberOfAnimats: aRMDAnimatDefinition identifier ]
				  ifFalse: [ '' ] ] ]
]

{ #category : #private }
RMDPopulationByTimeTabular >> selectedIndividual [

	^ nil
]

{ #category : #updating }
RMDPopulationByTimeTabular >> speciesChanged [

	self updateVisibleColumns.
	self updateStageDropList
]

{ #category : #updating }
RMDPopulationByTimeTabular >> stageChanged [

	self updateVisibleColumns
]

{ #category : #initialization }
RMDPopulationByTimeTabular >> title [

	^ 'Population Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : #enumerating }
RMDPopulationByTimeTabular >> titleRowsDo: aBlock [

	aBlock value: [ :columnKey | 
		columnKey = #time
			ifTrue: [ 
				'time ['
				, metaInterpreter simulationModel durationUnit printString , ']' ]
			ifFalse: [ 
				(metaInterpreter interpreterAt: columnKey first ifAbsent: [ nil ]) 
					ifNotNil: [ :interpreter | 
						columnKey first printString , ':'
						, interpreter metaparametersString ] ] ].
	aBlock value: [ :columnKey | 
		columnKey = #time
			ifTrue: [ '' ]
			ifFalse: [ columnKey second species ] ].
	aBlock value: [ :columnKey | 
		columnKey = #time
			ifTrue: [ '' ]
			ifFalse: [ columnKey second identifier ] ]
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
				 self stagesDo: [ :stage | stream nextPut: stage identifier ] ] ])
]

{ #category : #updating }
RMDPopulationByTimeTabular >> updateVisibleColumns [

	| runBlock speciesBlock stageBlock |
	runBlock := runDropList selectedItem
		            ifNotNil: [ :runId | 
			            [ :columnKey | 
			            columnKey isSymbol or: [ columnKey first = runId ] ] ]
		            ifNil: [ [ :columnKey | true ] ].
	speciesBlock := speciesDropList selectedItem
		                ifNotNil: [ :species | 
			                [ :columnKey | 
			                columnKey isSymbol or: [ 
				                columnKey second species = species ] ] ]
		                ifNil: [ [ :columnKey | true ] ].
	stageBlock := stageDropList selectedItem
		              ifNotNil: [ :stage | 
			              [ :columnKey | 
			              columnKey isSymbol or: [ 
				              columnKey second identifier = stage ] ] ]
		              ifNil: [ [ :columnKey | true ] ].

	self selectVisibleColumns: [ :columnKey | 
		(runBlock value: columnKey) and: [ 
			(speciesBlock value: columnKey) and: [ stageBlock value: columnKey ] ] ]
]
