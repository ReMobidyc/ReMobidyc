Class {
	#name : #RMDSnapshotTabular,
	#superclass : #RMDAbstractSnapshotTabular,
	#instVars : [
		'openBoxChartButton',
		'agentDropList'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #layout }
RMDSnapshotTabular class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #reloadButton width: self buttonHeight;
				   yourself)
		  height: self buttonHeight;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.2;
				   add: (SpBoxLayout newVertical
						    add: 'Run' expand: false;
						    add: #runDropList expand: false;
						    add: 'Time' expand: false;
						    add: #timeList;
						    add: (SpBoxLayout newHorizontal
								     add: #openTabularButton width: self buttonHeight;
								     add: #openObservatoryButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Agent' expand: false;
						    add: #agentDropList expand: false;
						    add: #table;
						    add: (SpBoxLayout newHorizontal
								     add: #openBoxChartButton width: self buttonHeight;
								     add: #exportCSVButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   yourself);
		  yourself
]

{ #category : #layout }
RMDSnapshotTabular class >> withoutButtons [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #reloadButton width: self buttonHeight;
				   yourself)
		  height: self buttonHeight;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.2;
				   add: (SpBoxLayout newVertical
						    add: 'Run' expand: false;
						    add: #runDropList expand: false;
						    add: 'Time' expand: false;
						    add: #timeList;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Agent' expand: false;
						    add: #agentDropList expand: false;
						    add: #table;
						    yourself);
				   yourself);
		  yourself
]

{ #category : #updating }
RMDSnapshotTabular >> agentChanged [

	self updateTable
]

{ #category : #initialization }
RMDSnapshotTabular >> initializePresenters [

	super initializePresenters.
	agentDropList := self newDropList
		                 display: [ :agentDefinition | 
			                 agentDefinition fullName ];
		                 whenSelectedItemChangedDo: [ self agentChanged ];
		                 yourself.
	openBoxChartButton := self newButton
		                      icon: self boxChartIcon;
		                      action: [ self openChart ];
		                      help: 'Open box charts';
		                      yourself
]

{ #category : #private }
RMDSnapshotTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self
		updateAgentDropList;
		updateTable
]

{ #category : #charts }
RMDSnapshotTabular >> openChart [

	table columns ifNotEmpty: [ :columns | 
		| canvas |
		canvas := RSCanvas new @ RMDMultiChartInteraction.
		columns do: [ :column | 
			column ifOnChartDo: [ 
				| chart |
				chart := RSChart new.
				chart
					extent: 150 @ 400;
					title: column title.
				chart
					addPlot: (RSBoxPlot new y:
								 { (table items collect: [ :row | column value: row ]) });
					addDecoration: (RSVerticalTick new
							 numberOfTicks: 10;
							 fontSize: 10;
							 asFloat).
				canvas addShape: (RSComposite new shapes: chart build shapes) ] ].
		RSHorizontalLineLayout on: canvas shapes.
		(canvas openWithTitle: 'Attributes Chart'
			 ,
			 (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
			 , (metaInterpreter
					  ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
					  ifNil: [ '' ])) extent: 160 * columns size @ 400 ]
]

{ #category : #private }
RMDSnapshotTabular >> selectedIndividual [

	^ table selectedItem ifNotNil: [ :item |
		  (item at: #id ifAbsent: [ nil ]) ifNotNil: [ :id |
			  id isInteger ifTrue: [ id ] ] ]
]

{ #category : #initialization }
RMDSnapshotTabular >> title [

	^ 'Snapshot Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : #updating }
RMDSnapshotTabular >> updateAgentDropList [

	| selection items |
	selection := agentDropList selectedItem.
	items := self allAgents reject: [ :agentDef | 
		         agentDef allAttributeDeclarations isEmpty ].
	agentDropList
		items: items;
		selectItem: ((items includes: selection)
				 ifTrue: [ selection ]
				 ifFalse: [ items ifNotEmpty: #first ifEmpty: [ nil ] ])
]

{ #category : #updating }
RMDSnapshotTabular >> updateColumns [

	table columns: (Array streamContents: [ :stream | 
			 runDropList selectedItem ifNotNil: [ :runId | 
				 agentDropList selectedItem ifNotNil: [ :agentDefinition | 
					 agentDefinition isPatchDefinitionNode ifTrue: [ 
						 self simulationModelDo: [ :model | 
							 stream
								 nextPut: (RMDPatchXColumn unit: model patchLengthUnit);
								 nextPut: (RMDPatchYColumn unit: model patchLengthUnit) ] ].
					 agentDefinition isAnimatDefinitionNode ifTrue: [ 
						 stream nextPut: RMDIdColumn new ].
					 agentDefinition allAttributeDeclarationsDo: [ :attributeDecl | 
						 stream nextPut: (RMDAttributeColumn attribute: attributeDecl) ] ] ] ])
]

{ #category : #updating }
RMDSnapshotTabular >> updateRows [

	table
		items: (Array streamContents: [ :stream | 
					 (metaInterpreter
						  interpreterAt: runDropList selectedItem
						  ifAbsent: [ nil ]) ifNotNil: [ :interpreter | 
							 | memory |
							 memory := interpreter memory.
							 timeList selectedItem ifNotNil: [ :time | 
									 agentDropList selectedItem ifNotNil: [ :agentDefinition | 
											 memory time: time.
											 agentDefinition isWorldDefinitionNode ifTrue: [ 
													 | row |
													 row := Dictionary new.
													 agentDefinition attributeOffsetsDo: [ :attribute :offset | 
															 row
																 at: attribute
																 put: (memory at: memory world + offset) ].
													 stream nextPut: row ].
											 agentDefinition isPatchDefinitionNode ifTrue: [ 
													 memory patchesDo: [ :patch | 
															 | row |
															 row := Dictionary new.
															 row
																 at: 'x' put: (interpreter centerXOfPatch: patch);
																 at: 'y' put: (interpreter centerYOfPatch: patch).
															 agentDefinition attributeOffsetsDo: [ :attribute :offset | 
																 row at: attribute put: (memory at: patch + offset) ].
															 stream nextPut: row ] ].
											 agentDefinition isAnimatDefinitionNode ifTrue: [ 
												 (memory animatsOf: agentDefinition identifier)
													 asSortedCollection do: [ :individual | 
													 | row |
													 row := Dictionary new.
													 row at: #id put: individual.
													 agentDefinition attributeOffsetsDo: [ :attribute :offset | 
														 row at: attribute put: (memory at: individual + offset) ].
													 stream nextPut: row ] ] ] ] ] ]);
		refresh
]

{ #category : #updating }
RMDSnapshotTabular >> updateRunDropList [

	| selection items |
	selection := runDropList selectedItem.
	items := metaInterpreter runIds.
	runDropList
		items: items;
		selectItem: ((items includes: selection)
				 ifTrue: [ selection ]
				 ifFalse: [ items ifEmpty: [ nil ] ifNotEmpty: #first ])
]
