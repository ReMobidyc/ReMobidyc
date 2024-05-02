Class {
	#name : 'RMDAttributeByTimeTabular',
	#superclass : 'RMDTimeSeriesTabular',
	#instVars : [
		'agentDropList',
		'openLineChartsButton',
		'openBoxChartButton',
		'taskList',
		'traceableActionContext'
	],
	#category : 'ReMobidyc-Spec2-Tabulars',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Tabulars'
}

{ #category : 'layout' }
RMDAttributeByTimeTabular class >> defaultLayout [

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
						    add: 'Run' expand: false;
						    add: #runDropList expand: false;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Agent';
						    add: #agentDropList;
						    yourself);
				   yourself)
		  expand: false;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.7;
				   add: #table;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.3;
						    add: #taskList;
						    add: #traceableActionContext));
		  add: (SpBoxLayout newHorizontal
				   add: #openTabularButton width: self buttonHeight;
				   add: #openObservatoryButton width: self buttonHeight;
				   add: '    ' expand: false;
				   add: #openLineChartsButton width: self buttonHeight;
				   add: #openBoxChartButton width: self buttonHeight;
				   add: #exportCSVButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'updating' }
RMDAttributeByTimeTabular >> agentChanged [

	self updateTable
]

{ #category : 'initialization' }
RMDAttributeByTimeTabular >> initializePresenters [

	super initializePresenters.
	agentDropList := self newDropList
		                 display: [ :agentDefinition |
			                 agentDefinition fullName ];
		                 whenSelectedItemChangedDo: [ self agentChanged ];
		                 yourself.
	openLineChartsButton := self newButton
		                        icon: self lineChartIcon;
		                        action: [ self openChartMenu ];
		                        help: 'Open line charts';
		                        yourself.
	openBoxChartButton := self newButton
		                      icon: self boxChartIcon;
		                      action: [ self openBoxChart ];
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
RMDAttributeByTimeTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self
		updateAgentDropList;
		updateTable
]

{ #category : 'charts' }
RMDAttributeByTimeTabular >> openBoxChart [

	table columns ifNotEmpty: [ :columns |
		| canvas |
		canvas := RSCanvas new @ RSCanvasController.
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

{ #category : 'charts' }
RMDAttributeByTimeTabular >> openChart: aRMDTabularColumn [

	| chart radius |
	chart := RSCompositeChart new.
	chart
		extent: 400 @ 400;
		title: aRMDTabularColumn title.
	radius := table items size > 1000
		          ifTrue: [ 0.5 ]
		          ifFalse: [ 1 ].
	chart
		add: (RMDScatterPlot new
				 shape: (RSBox new
						  extent: radius @ radius;
						  paint: Color gray);
				 x: (table items collect: table columns first)
				 y: (table items collect: aRMDTabularColumn));
		addDecoration: (RSXLabelDecoration new
				 title: table columns first title;
				 fontSize: 10);
		addDecoration: (RSYLabelDecoration new
				 title: aRMDTabularColumn title;
				 fontSize: 10).
	(chart build openWithTitle:
		 agentDropList selectedItem fullName , '''s '
		 , aRMDTabularColumn title
		 , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
		 , (metaInterpreter
				  ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
				  ifNil: [ '' ])) extent: 800 @ 800
]

{ #category : 'charts' }
RMDAttributeByTimeTabular >> openChartMenu [

	| menu |
	menu := self newMenu.
	table columns do: [ :column |
		column ifOnChartDo: [
			menu addItem: [ :item |
				item
					name: column title;
					action: [ self openChart: column ] ] ] ].
	menu openWithSpecAtPointer
]

{ #category : 'accessing' }
RMDAttributeByTimeTabular >> selectedAgent [

	^ agentDropList selectedItem
]

{ #category : 'accessing' }
RMDAttributeByTimeTabular >> selectedIndividual [

	^ table selectedItem ifNotNil: [ :row |
		  (row at: #id ifAbsent: [ nil ]) ifNotNil: [ :id |
			  id isInteger ifTrue: [ id ] ] ]
]

{ #category : 'accessing' }
RMDAttributeByTimeTabular >> selectedTime [

	^ table selectedItem ifNotNil: [ :item |
		  item at: #time ifAbsent: [ nil ] ]
]

{ #category : 'accessing' }
RMDAttributeByTimeTabular >> title [

	^ 'Attribute Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : 'updating' }
RMDAttributeByTimeTabular >> updateAgentDropList [

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
RMDAttributeByTimeTabular >> updateColumns [

	table columns: (Array streamContents: [ :stream |
			 runDropList selectedItem ifNotNil: [ :runId |
				 self simulationModelDo: [ :model |
					 stream nextPut: (RMDTimeColumn unit: model durationUnit).
					 agentDropList selectedItem ifNotNil: [ :agentDefinition |
						 agentDefinition isPatchDefinitionNode ifTrue: [
							 stream
								 nextPut: (RMDPatchXColumn unit: model patchLengthUnit);
								 nextPut: (RMDPatchYColumn unit: model patchLengthUnit) ].
						 agentDefinition isAnimatDefinitionNode ifTrue: [
							 stream nextPut: RMDIdColumn new ].
						 agentDefinition allAttributeDeclarationsDo: [ :attributeDecl |
							 stream nextPut: (RMDAttributeColumn attribute: attributeDecl) ] ] ] ] ])
]

{ #category : 'updating' }
RMDAttributeByTimeTabular >> updateRows [

	| latestTime |
	table showColumnHeaders.
	latestTime := self latestTime.
	'Collecting data from the run record'
		displayProgressFrom: 0
		to: latestTime
		during: [ :progress |
			table
				items: (Array streamContents: [ :stream |
							 (metaInterpreter
								  interpreterAt: runDropList selectedItem
								  ifAbsent: [ nil ]) ifNotNil: [ :interpreter |
									 | memory |
									 memory := interpreter memory.
									 0 to: latestTime do: [ :time |
											 agentDropList selectedItem ifNotNil: [ :agentDefinition |
													 memory time: time.
													 agentDefinition isWorldDefinitionNode ifTrue: [
															 | row |
															 row := Dictionary new.
															 row
																 at: #time
																 put: time * metaInterpreter simulationModel deltaTime.
															 agentDefinition attributeOffsetsDo: [ :attribute :offset |
																	 row
																		 at: attribute
																		 put:
																			 (memory
																				  at: memory world + offset
																				  ifAbsent: [ 0.0 ]) ].
															 stream nextPut: row ].
													 agentDefinition isPatchDefinitionNode ifTrue: [
															 memory patchesDo: [ :patch |
																	 | row |
																	 row := Dictionary new.
																	 row
																		 at: #time
																		 put:
																			 time * metaInterpreter simulationModel deltaTime.
																	 row
																		 at: 'id' put: patch;
																		 at: 'x' put: (interpreter centerXOfPatch: patch);
																		 at: 'y' put: (interpreter centerYOfPatch: patch).
																	 agentDefinition attributeOffsetsDo: [
																		 :attribute
																		 :offset |
																		 row at: attribute put: (memory at: patch + offset) ].
																	 stream nextPut: row ] ].
													 agentDefinition isAnimatDefinitionNode ifTrue: [
														 (memory animatsOf: agentDefinition identifier)
															 asSortedCollection do: [ :individual |
															 | row |
															 row := Dictionary new.
															 row
																 at: #time
																 put: time * metaInterpreter simulationModel deltaTime.
															 row at: #id put: individual.
															 agentDefinition attributeOffsetsDo: [ :attribute :offset |
																 row
																	 at: attribute
																	 put: (memory at: individual + offset) ].
															 stream nextPut: row ] ] ].
											 progress value: time ] ] ]);
				refresh ]
]

{ #category : 'updating' }
RMDAttributeByTimeTabular >> updateRunDropList [

	runDropList
		items: metaInterpreter runIds;
		selectIndex: 1
]

{ #category : 'updating' }
RMDAttributeByTimeTabular >> updateTaskList [

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
RMDAttributeByTimeTabular >> updateTraceableAction [

	traceableActionContext context: taskList selectedItem
]
