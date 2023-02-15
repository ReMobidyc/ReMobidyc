Class {
	#name : #RMDStageIndividualsAtTimeTabular,
	#superclass : #RMDSnapshotTabular,
	#instVars : [
		'stageDropList',
		'openBoxChartButton'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #layout }
RMDStageIndividualsAtTimeTabular class >> defaultLayout [

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
						    add: 'Species(Stage)' expand: false;
						    add: #stageDropList expand: false;
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

{ #category : #initialization }
RMDStageIndividualsAtTimeTabular >> initializePresenters [

	super initializePresenters.
	stageDropList := self newDropList
		                 display: [ :animatDefinition | 
			                 animatDefinition species , '('
			                 , animatDefinition identifier , ')' ];
		                 whenSelectedItemChangedDo: [ self stageChanged ];
		                 yourself.
	openBoxChartButton := self newButton
		                      icon: self boxChartIcon;
		                      action: [ self openChart ];
		                      help: 'Open box charts';
		                      yourself
]

{ #category : #private }
RMDStageIndividualsAtTimeTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self
		updateStageDropList;
		updateTable
]

{ #category : #charts }
RMDStageIndividualsAtTimeTabular >> openChart [

	table columns ifNotEmpty: [ :columns | 
		| canvas |
		canvas := RSCanvas new @ RSCanvasController.
		2 to: columns size do: [ :columnIndex | 
			| chart column |
			chart := RSChart new.
			column := columns at: columnIndex.
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
			canvas addShape: (RSComposite new shapes: chart build shapes) ].
		RSHorizontalLineLayout on: canvas shapes.
		(canvas openWithTitle: 'Population Chart'
			 ,
			 (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
			 , (metaInterpreter
					  ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
					  ifNil: [ '' ])) extent: (160 * columns size) @ 400 ]
]

{ #category : #private }
RMDStageIndividualsAtTimeTabular >> selectedIndividual [

	^ (table selectedItem at: #id) ifNotNil: [ :id | 
		  id isInteger
			  ifTrue: [ id ]
			  ifFalse: [ nil ] ]
]

{ #category : #updating }
RMDStageIndividualsAtTimeTabular >> stageChanged [

	self updateTable
]

{ #category : #initialization }
RMDStageIndividualsAtTimeTabular >> title [

	^ 'Attribute Tabular'
	  , (self modelName ifNil: [ '' ] ifNotNil: [ :name | ' @ ' , name ])
	  , (metaInterpreter
			   ifNotNil: [ '[' , metaInterpreter memoryName , ']' ]
			   ifNil: [ '' ])
]

{ #category : #updating }
RMDStageIndividualsAtTimeTabular >> updateColumns [

	table columns: (Array streamContents: [ :stream | 
			 runDropList selectedItem ifNotNil: [ :runId | 
				 stageDropList selectedItem ifNotNil: [ :animatDefinition | 
					 stream nextPut: RMDIdColumn new.
					 animatDefinition attributeDeclarationsDo: [ :attributeDecl | 
						 stream nextPut: (RMDAttributeColumn attribute: attributeDecl) ] ] ] ])
]

{ #category : #updating }
RMDStageIndividualsAtTimeTabular >> updateRows [

	table
		items: (Array streamContents: [ :stream | 
					 (metaInterpreter
						  interpreterAt: runDropList selectedItem
						  ifAbsent: [ nil ]) ifNotNil: [ :interpreter | 
							 | memory |
							 memory := interpreter memory.
							 timeList selectedItem ifNotNil: [ :time | 
									 stageDropList selectedItem ifNotNil: [ :animat | 
											 memory time: time.
											 (memory animatsOf: animat identifier) asSortedCollection 
												 do: [ :individual | 
													 | row |
													 row := Dictionary new.
													 row at: #id put: individual.
													 animat attributeOffsetsDo: [ :attribute :offset | 
															 row
																 at: attribute
																 put: (memory at: individual + offset) ].
													 stream nextPut: row ] ] ] ] ]);
		refresh
]

{ #category : #updating }
RMDStageIndividualsAtTimeTabular >> updateRunDropList [

	| selection items |
	selection := runDropList selectedItem.
	items := metaInterpreter runIds.
	runDropList
		items: items;
		selectItem: ((items includes: selection)
				 ifTrue: [ selection ]
				 ifFalse: [ items ifEmpty: [ nil ] ifNotEmpty: #first ])
]

{ #category : #updating }
RMDStageIndividualsAtTimeTabular >> updateStageDropList [

	| selection items |
	selection := stageDropList selectedItem.
	items := self allStages.
	stageDropList
		items: items;
		selectItem: ((items includes: selection)
				 ifTrue: [ selection ]
				 ifFalse: [ items ifNotEmpty: #first ifEmpty: [ nil ] ])
]

{ #category : #updating }
RMDStageIndividualsAtTimeTabular >> updateTable [

	self
		updateRows;
		updateColumns
]
