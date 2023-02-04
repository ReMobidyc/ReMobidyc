Class {
	#name : #RMDTabular,
	#superclass : #RMDPresenter,
	#instVars : [
		'metaInterpreter',
		'runDropList',
		'table',
		'columnCollectors',
		'exportCSVButton',
		'reloadButton',
		'openObservatoryButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDTabular class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #reloadButton width: self buttonHeight;
				   addSpace;
				   add: #runDropList expand: false;
				   yourself)
		  expand: false;
		  add: #table;
		  add: (SpBoxLayout newHorizontal
				   add: #exportCSVButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #'instance creation' }
RMDTabular class >> on: aRMDMetaInterpreter [

	^ self new metaInterpreter: aRMDMetaInterpreter
]

{ #category : #'instance creation' }
RMDTabular class >> openOn: aRMDMetaInterpreter [

	^ (self on: aRMDMetaInterpreter) open
]

{ #category : #accessing }
RMDTabular >> allSpecies [

	^ Array streamContents: [ :stream | 
		  self speciesDo: [ :species | stream nextPut: species ] ]
]

{ #category : #accessing }
RMDTabular >> allStages [

	^ Array streamContents: [ :stream | 
		  self stagesDo: [ :stage | stream nextPut: stage ] ]
]

{ #category : #accessing }
RMDTabular >> columnCollectors: anArrayOfAssociationOfColumnKeyAndBlock [

	self
		columnCollectors: anArrayOfAssociationOfColumnKeyAndBlock
		selectVisible: [ :columnKey | true ]
]

{ #category : #accessing }
RMDTabular >> columnCollectors: anArrayOfAssociationOfColumnKeyAndBlock selectVisible: aBlock [

	columnCollectors := anArrayOfAssociationOfColumnKeyAndBlock.
	table columns: #(  ).
	self updateRows.
	table
		columns: (anArrayOfAssociationOfColumnKeyAndBlock
				 select: [ :assoc | aBlock value: assoc key ]
				 thenCollect: [ :assoc | 
					 SpStringTableColumn evaluated: [ :row | 
							 row at: assoc key ifAbsent: [ '' ] ] ]);
		refresh
]

{ #category : #operations }
RMDTabular >> exportAsCSV [

	(UIManager default
		 chooseForSaveFileReference: 'Export a CSV file...'
		 extensions: #( 'csv' )
		 path: ((FileLocator documents / 'ReMobidyc') ensureCreateDirectory
			  / (metaInterpreter context modelPath basename , '-populations') 
				  withExtension: 'csv') absolutePath) ifNotNil: [ :fileRef | 
		self writeCSVInto: fileRef ]
]

{ #category : #enumerating }
RMDTabular >> generateRowsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #initialization }
RMDTabular >> initializePresenters [

	super initializePresenters.
	reloadButton := self newButton
		                icon: self updateIcon;
		                action: [ self reloadInterpreter ];
		                yourself.
	openObservatoryButton := self newButton
		                         icon: self observatoryIcon;
		                         action: [ self openInObservatory ];
		                         yourself.
	exportCSVButton := self newButton
		                   icon: (self saveIconWith: 'CSV');
		                   action: [ self exportAsCSV ];
		                   yourself.
	runDropList := self newDropList
		               display: [ :runId | 
			               runId
				               ifNotNil: [ 
					               (metaInterpreter
						                interpreterAt: runId
						                ifAbsent: [ nil ])
						               ifNotNil: #shortName
						               ifNil: [ '-' ] ]
				               ifNil: 'all' ];
		               whenSelectedItemChangedDo: [ self runChanged ];
		               yourself.
	table := self newTable
		         beResizable;
		         yourself
]

{ #category : #initialization }
RMDTabular >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 700 @ 800
]

{ #category : #accessing }
RMDTabular >> latestTime [

	| latestTime |
	latestTime := 0.
	metaInterpreter interpretersDo: [ :interpreter | 
		latestTime := latestTime max: interpreter memory latestTime ].
	^ latestTime
]

{ #category : #private }
RMDTabular >> metaInterpreter: aRMDMetaInterpreter [

	aRMDMetaInterpreter setupSimulation.
	metaInterpreter := aRMDMetaInterpreter.
	self updateRunDropList
]

{ #category : #updating }
RMDTabular >> metaInterpreterReloaded [

	self updateRows.
	table refresh
]

{ #category : #accessing }
RMDTabular >> modelName [

	^ metaInterpreter
		  ifNotNil: [ metaInterpreter simulationModel name ]
		  ifNil: [ 'noname' ]
]

{ #category : #operations }
RMDTabular >> openInObservatory [

	(metaInterpreter notNil and: [ 
		 metaInterpreter context isForFileMemory ]) ifTrue: [ 
		(metaInterpreter simulationModel 
			 metaInterpreterOnReadOnlyModelPath:
			 metaInterpreter context modelPath) openInReplayObservatory ]
]

{ #category : #operations }
RMDTabular >> reloadInterpreter [

	metaInterpreter reloadMemory.
	self metaInterpreterReloaded
]

{ #category : #operations }
RMDTabular >> reloadTable [

	metaInterpreter reloadMemory.
	self updateRows.
	table refresh
]

{ #category : #updating }
RMDTabular >> runChanged [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDTabular >> selectVisibleColumns: aBlock [

	columnCollectors ifNotNil: [ 
		table
			columns: (columnCollectors
					 select: [ :assoc | aBlock value: assoc key ]
					 thenCollect: [ :assoc | 
						 SpStringTableColumn evaluated: [ :row | 
								 row at: assoc key ifAbsent: [ '' ] ] ]);
			refresh ]
]

{ #category : #accessing }
RMDTabular >> simulationModelDo: aBlock [

	(metaInterpreter ifNotNil: #simulationModel) ifNotNil: aBlock
]

{ #category : #enumerating }
RMDTabular >> speciesDo: aBlock [

	| done |
	done := Set new.
	self stagesDo: [ :animatDefinition | 
		| species |
		species := animatDefinition species.
		(done includes: species) ifFalse: [ 
			done add: species.
			aBlock value: species ] ]
]

{ #category : #enumerating }
RMDTabular >> speciesNamesDo: aBlock [

	| done |
	done := Set new.
	self stagesDo: [ :animatDefinition | 
		| species |
		species := animatDefinition species.
		(done includes: species) ifFalse: [ 
			done add: species.
			aBlock value: species ] ]
]

{ #category : #enumerating }
RMDTabular >> stageNamesDo: aBlock [

	self simulationModelDo: [ :simulationModel | 
		simulationModel animatDefinitionsDo: [ :animatDefinition | 
			aBlock value: animatDefinition identifier ] ]
]

{ #category : #enumerating }
RMDTabular >> stagesDo: aBlock [

	self simulationModelDo: [ :simulationModel | 
		simulationModel animatDefinitionsDo: aBlock ]
]

{ #category : #enumerating }
RMDTabular >> stagesOf: aString do: aBlock [

	self stagesDo: [ :animatDefinition | 
		animatDefinition species = aString ifTrue: [ 
			aBlock value: animatDefinition ] ]
]

{ #category : #initialization }
RMDTabular >> title [ 
]

{ #category : #enumerating }
RMDTabular >> titleRowsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #updating }
RMDTabular >> updateRows [

	table items: (Array streamContents: [ :stream | 
			 columnCollectors ifNotNil: [ 
				 self titleRowsDo: [ :block | 
					 stream nextPut: (columnCollectors collect: [ :assoc | 
							  assoc key -> (block value: assoc key) ]) asDictionary ].
				 self generateRowsDo: [ :row | 
					 stream nextPut: (columnCollectors collect: [ :assoc | 
							  assoc key -> (assoc value value: row) ]) asDictionary ] ] ])
]

{ #category : #updating }
RMDTabular >> updateRunDropList [

	runDropList items: { nil } , metaInterpreter runIds
]

{ #category : #operations }
RMDTabular >> writeCSVInto: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		table items
			do: [ :row | 
				table columns
					do: [ :column | 
						| item |
						item := column evaluation value: row.
						item isNumber
							ifTrue: [ item printOn: stream ]
							ifFalse: [ 
								stream
									nextPut: $";
									nextPutAll: ((item asString copyReplaceAll: '"' with: '\"')
											 copyReplaceAll: ','
											 with: '\,');
									nextPut: $" ] ]
					separatedBy: [ stream nextPut: $, ] ]
			separatedBy: [ stream cr ] ]
]
