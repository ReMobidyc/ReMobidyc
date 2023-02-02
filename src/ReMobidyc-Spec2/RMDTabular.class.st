Class {
	#name : #RMDTabular,
	#superclass : #RMDPresenter,
	#instVars : [
		'metaInterpreter',
		'runDropList',
		'table',
		'columnCollectors',
		'exportCSVButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDTabular class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #exportCSVButton width: self buttonHeight;
				   add: #runDropList)
		  expand: false;
		  add: #table;
		  yourself
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
					 SpStringTableColumn
						 title: assoc key asString
						 evaluated: [ :row | row at: assoc key ifAbsent: [ '' ] ] ]);
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
		         hideColumnHeaders;
		         yourself
]

{ #category : #private }
RMDTabular >> metaInterpreter: aRMDMetaInterpreter [

	aRMDMetaInterpreter setupSimulation.
	metaInterpreter := aRMDMetaInterpreter.
	runDropList items: { nil } , aRMDMetaInterpreter runIds
]

{ #category : #accessing }
RMDTabular >> modelName [

	^ metaInterpreter
		  ifNotNil: [ metaInterpreter simulationModel name ]
		  ifNil: [ 'noname' ]
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
						 SpStringTableColumn
							 title: assoc key asString
							 evaluated: [ :row | row at: assoc key ifAbsent: [ '' ] ] ]);
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

{ #category : #enumerating }
RMDTabular >> titleRowsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #updating }
RMDTabular >> updateRows [

	table items: (Array streamContents: [ :stream | 
			 self titleRowsDo: [ :block | 
				 stream nextPut: (columnCollectors collect: [ :assoc | 
						  assoc key -> (block value: assoc key) ]) asDictionary ].
			 self generateRowsDo: [ :rowIndex | 
				 stream nextPut: (columnCollectors collect: [ :assoc | 
						  assoc key -> (assoc value value: rowIndex) ]) asDictionary ] ])
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
