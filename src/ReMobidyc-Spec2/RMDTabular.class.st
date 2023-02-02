Class {
	#name : #RMDTabular,
	#superclass : #RMDPresenter,
	#instVars : [
		'metaInterpreter',
		'runDropList',
		'table',
		'rows',
		'columnCollectors'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDTabular class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #runDropList expand: false;
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

{ #category : #enumerating }
RMDTabular >> generateRowsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #initialization }
RMDTabular >> initializePresenters [

	super initializePresenters.
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
]

{ #category : #private }
RMDTabular >> metaInterpreter: aRMDMetaInterpreter [

	aRMDMetaInterpreter setupSimulation.
	metaInterpreter := aRMDMetaInterpreter.
	runDropList items: { nil } , aRMDMetaInterpreter runIds.
	runDropList selectIndex: 1
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

	rows := Array streamContents: [ :stream | 
		        self titleRowsDo: [ :block | 
			        stream nextPut: (columnCollectors collect: [ :assoc | 
					         assoc key -> (block value: assoc key) ]) asDictionary ].
		        self generateRowsDo: [ :rowIndex | 
			        stream nextPut: (columnCollectors collect: [ :assoc | 
					         assoc key -> (assoc value value: rowIndex) ])
					        asDictionary ] ].
	table items: rows
]
