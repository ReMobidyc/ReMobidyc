Class {
	#name : #RMDPopulationTabular,
	#superclass : #RMDTimeSeriesTabular,
	#instVars : [
		'speciesDropList',
		'stageDropList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDPopulationTabular class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #exportCSVButton width: self buttonHeight;
				   add: #runDropList;
				   add: #speciesDropList;
				   add: #stageDropList;
				   yourself)
		  expand: false;
		  add: #table;
		  yourself
]

{ #category : #'instance creation' }
RMDPopulationTabular class >> on: aRMDMetaInterpreter [

	^ self new metaInterpreter: aRMDMetaInterpreter
]

{ #category : #'instance creation' }
RMDPopulationTabular class >> openOn: aRMDMetaInterpreter [

	^ (self on: aRMDMetaInterpreter) open
]

{ #category : #accessing }
RMDPopulationTabular >> allSpecies [

	^ Array streamContents: [ :stream | 
		  self speciesDo: [ :species | stream nextPut: species ] ]
]

{ #category : #initialization }
RMDPopulationTabular >> initializePresenters [

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

{ #category : #initialization }
RMDPopulationTabular >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 700 @ 800
]

{ #category : #private }
RMDPopulationTabular >> metaInterpreter: aRMDMetaInterpreter [

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
RMDPopulationTabular >> populationCollectorOnRunId: anInteger animat: aRMDAnimatDefinition [

	^ { 
		  anInteger.
		  aRMDAnimatDefinition } -> [ :rowIndex | 
	  (metaInterpreter interpreterAt: anInteger ifAbsent: [ nil ]) 
		  ifNotNil: [ :interpreter | 
			  | memory time |
			  memory := interpreter memory.
			  time := rowIndex - 1.
			  time <= memory latestTime
				  ifTrue: [ 
					  memory
						  time: time;
						  numberOfAnimats: aRMDAnimatDefinition identifier ]
				  ifFalse: [ '' ] ] ]
]

{ #category : #updating }
RMDPopulationTabular >> speciesChanged [

	self updateVisibleColumns.
	self updateStageDropList
]

{ #category : #updating }
RMDPopulationTabular >> stageChanged [

	self updateVisibleColumns
]

{ #category : #initialization }
RMDPopulationTabular >> title [

	^ 'Population Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : #enumerating }
RMDPopulationTabular >> titleRowsDo: aBlock [

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
RMDPopulationTabular >> updateSpeciesDropList [

	speciesDropList items: (Array streamContents: [ :stream | 
			 stream nextPut: nil.
			 self speciesDo: [ :species | stream nextPut: species ] ])
]

{ #category : #updating }
RMDPopulationTabular >> updateStageDropList [

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
RMDPopulationTabular >> updateVisibleColumns [

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
