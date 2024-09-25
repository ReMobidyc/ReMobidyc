Class {
	#name : 'RMDSnapshotTabular',
	#superclass : 'RMDAbstractSnapshotTabular',
	#instVars : [
		'openBoxChartButton',
		'agentDropList',
		'traceableActionContext',
		'taskList'
	],
	#category : 'ReMobidyc-Spec2-Tabulars',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Tabulars'
}

{ #category : 'layout' }
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
						    add: (SpPanedLayout newVertical
								     positionOfSlider: 0.8;
								     add: #table;
								     add: (SpPanedLayout newHorizontal
										      positionOfSlider: 0.3;
										      add: #taskList;
										      add: #traceableActionContext));
						    add: (SpBoxLayout newHorizontal
								     add: #openBoxChartButton width: self buttonHeight;
								     add: #exportCSVButton width: self buttonHeight;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   yourself);
		  yourself
]

{ #category : 'updating' }
RMDSnapshotTabular >> agentChanged [

	self updateTable
]

{ #category : 'initialization' }
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
		                      yourself.
	table whenSelectedItemChangedDo: [ self updateTaskList ].
	taskList := self newTable
		            addColumn:
			            (SpStringTableColumn
				             title: 'task'
				             evaluated: #printString);
		            whenSelectedItemChangedDo: [ self updateTraceableAction ];
		            yourself.
	traceableActionContext := self instantiate:
		                          RMDTraceableActionContextPresenter
]

{ #category : 'private' }
RMDSnapshotTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self
		updateAgentDropList;
		updateTable
]

{ #category : 'charts' }
RMDSnapshotTabular >> openChart [

	table columns ifNotEmpty: [ :columns |
		| canvas |
		canvas := RSCanvas new @ RMDMultiChartInteraction.
		columns do: [ :column |
			column ifOnChartDo: [
				| chart |
				chart := (RSBoxPlot data:
					          { (table items collect: [ :row | column value: row ]) })
					         chart.
				chart
					extent: 150 @ 400;
					title: column title.
				canvas addShape: (RSComposite new shapes: chart build shapes) ] ].
		RSHorizontalLineLayout on: canvas shapes.
		(canvas openWithTitle: 'Attributes Chart'
			 ,
			 (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
			 , (metaInterpreter
					  ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
					  ifNil: [ '' ])) extent: 160 * columns size @ 400 ]
]

{ #category : 'accessing' }
RMDSnapshotTabular >> selectedAgent [

	^ agentDropList selectedItem
]

{ #category : 'accessing' }
RMDSnapshotTabular >> selectedIndividual [

	self selectedAgent ifNotNil: [ :agent |
		agent isWorldDefinitionNode ifTrue: [
			^ self selectedInterpreter world ] ].
	^ table selectedItem ifNotNil: [ :item |
		  (item at: #id ifAbsent: [ nil ]) ifNotNil: [ :id |
			  id isInteger ifTrue: [ id ] ] ]
]

{ #category : 'initialization' }
RMDSnapshotTabular >> title [

	^ 'Snapshot Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : 'updating' }
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

{ #category : 'updating' }
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

{ #category : 'updating' }
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
																 at: 'id' put: patch;
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

{ #category : 'updating' }
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

{ #category : 'updating' }
RMDSnapshotTabular >> updateTaskList [

	| selection |
	selection := taskList selectedItem.
	self selectedInterpreter ifNotNil: [ :interpreter |
		self selectedAgent ifNotNil: [ :agent |
			self selectedIndividual ifNotNil: [ :subject |
				taskList items: (Array streamContents: [ :stream |
						 interpreter simulationModel taskDefinitions do: [ :task |
							 (task enabled and: [ task subjectIdentifier = agent name ])
								 ifTrue: [
									 task
										 validate: subject
										 in: self selectedInterpreter
										 do: [ :context | stream nextPut: context ] ] ] ]).
				selection ifNotNil: [ taskList selectItem: selection ].
				^ self ] ] ].
	taskList items: Array new
]

{ #category : 'updating' }
RMDSnapshotTabular >> updateTraceableAction [

	traceableActionContext context: taskList selectedItem
]
