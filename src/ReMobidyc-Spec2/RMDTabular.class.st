Class {
	#name : #RMDTabular,
	#superclass : #RMDPresenter,
	#traits : 'TRMDLaunchAnalysisTools',
	#classTraits : 'TRMDLaunchAnalysisTools classTrait',
	#instVars : [
		'metaInterpreter',
		'runDropList',
		'table',
		'exportCSVButton',
		'reloadButton',
		'baseRowIndex'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #testing }
RMDTabular class >> isAbstract [

	^ self == RMDTabular
]

{ #category : #'instance creation' }
RMDTabular class >> on: aRMDMetaInterpreter [

	^ self new metaInterpreter: aRMDMetaInterpreter
]

{ #category : #'instance creation' }
RMDTabular class >> openOn: aRMDMetaInterpreter [

	^ (self on: aRMDMetaInterpreter) open
]

{ #category : #enumerating }
RMDTabular >> agentsDo: aBlock [

	self simulationModelDo: [ :simulationModel | 
		simulationModel worldDefinition ifNotNil: aBlock.
		simulationModel patchDefinition ifNotNil: aBlock.
		simulationModel animatDefinitionsDo: aBlock ]
]

{ #category : #accessing }
RMDTabular >> allAgents [

	^ Array streamContents: [ :stream | 
		  self agentsDo: [ :stage | stream nextPut: stage ] ]
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

{ #category : #testing }
RMDTabular >> canOpenAnalysis [

	^ metaInterpreter notNil and: [ 
		  metaInterpreter context isForFileMemory ]
]

{ #category : #private }
RMDTabular >> csvQuote: aString [

	^ '"' , (((aString copyReplaceAll: '"' with: '\"')
		    copyReplaceAll: ','
		    with: '\,') copyReplaceAll: String cr with: '\n') , '"'
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

{ #category : #initialization }
RMDTabular >> initialize [

	super initialize.
	baseRowIndex := 1
]

{ #category : #initialization }
RMDTabular >> initializePresenters [

	super initializePresenters.
	self initializeOpenAnalysisButtonsPresenters.
	reloadButton := self newButton
		                icon: self updateIcon;
		                action: [ self reloadInterpreter ];
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
	table := self newTableWithHorizontalScrollbar
		         enableHorizontalScrollbar;
		         beResizable;
		         contextMenu: [ self analysisMenu ];
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
	self updateRunDropList.
	self updateOpenAnalysisButtons 
]

{ #category : #private }
RMDTabular >> metaInterpreterForTabularDo: aBlock [

	^ (metaInterpreter notNil and: [ 
		   metaInterpreter context isForFileMemory ]) ifTrue: [ 
		  aBlock value:
			  (metaInterpreter simulationModel 
				   metaInterpreterOnReadOnlyModelPath:
				   metaInterpreter context modelPath) ]
]

{ #category : #updating }
RMDTabular >> metaInterpreterReloaded [

	self updateTable
]

{ #category : #accessing }
RMDTabular >> modelName [

	^ metaInterpreter
		  ifNotNil: [ metaInterpreter simulationModel name ]
		  ifNil: [ 'noname' ]
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
RMDTabular >> selectRunId: anInteger [

	(runDropList items includes: anInteger) ifTrue: [ 
		runDropList selectItem: anInteger ]
]

{ #category : #accessing }
RMDTabular >> selectTime: anInteger [

	^ self subclassResponsibility
]

{ #category : #private }
RMDTabular >> selectedInterpreter [

	^ metaInterpreter interpreterAt: self selectedRunId ifAbsent: [  ]
]

{ #category : #private }
RMDTabular >> selectedRunId [

	^ runDropList selectedItem ifNotNil: [ :runId | 
		  runId isInteger ifTrue: [ runId ] ]
]

{ #category : #accessing }
RMDTabular >> selectedTime [

	^ self subclassResponsibility
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

{ #category : #updating }
RMDTabular >> updateColumns [

	^ self subclassResponsibility
]

{ #category : #updating }
RMDTabular >> updateRows [

	^ self subclassResponsibility
]

{ #category : #updating }
RMDTabular >> updateRunDropList [

	runDropList
		items: { nil } , metaInterpreter runIds;
		selectIndex: 1
]

{ #category : #updating }
RMDTabular >> updateTable [

	self
		updateRows;
		updateColumns.
	table refresh
]

{ #category : #operations }
RMDTabular >> writeCSVInto: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		table columns
			do: [ :column | stream nextPutAll: (self csvQuote: column title) ]
			separatedBy: [ stream nextPut: $, ].
		stream cr.
		table items
			do: [ :row | 
				table columns
					do: [ :column | 
						| item |
						item := column value: row.
						item ifNotNil: [ 
							item isNumber
								ifTrue: [ item printOn: stream ]
								ifFalse: [ 
									stream nextPutAll: (self csvQuote: item) ] ] ]
					separatedBy: [ stream nextPut: $, ] ]
			separatedBy: [ stream cr ] ]
]
