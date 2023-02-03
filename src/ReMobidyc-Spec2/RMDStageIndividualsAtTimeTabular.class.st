Class {
	#name : #RMDStageIndividualsAtTimeTabular,
	#superclass : #RMDSnapshotTabular,
	#instVars : [
		'stageDropList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDStageIndividualsAtTimeTabular class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #reloadButton width: self buttonHeight;
				   addSpace;
				   add: (SpBoxLayout newVertical
						    add: 'Species(Stage)';
						    add: #stageDropList);
				   add: (SpBoxLayout newVertical
						    add: 'Run';
						    add: #runDropList);
				   add: (SpBoxLayout newVertical
						    add: 'Time';
						    add: #timeDropList);
				   yourself)
		  expand: false;
		  add: #table;
		  add: (SpBoxLayout newHorizontal
				   add: #exportCSVButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #'accessing - column collectors' }
RMDStageIndividualsAtTimeTabular >> attributeCollectorOn: aRMDAttributeDeclarationNode [

	^ aRMDAttributeDeclarationNode -> [ :individual | 
	  (metaInterpreter
		   interpreterAt: runDropList selectedItem
		   ifAbsent: [ nil ]) ifNotNil: [ :interpreter | 
		  | time stage |
		  time := timeDropList selectedItem.
		  stage := stageDropList selectedItem.
		  (time notNil and: [ stage notNil ]) ifTrue: [ 
			  (stage
				   attributeOffsetAt: aRMDAttributeDeclarationNode identifier
				   ifAbsent: [ nil ]) ifNotNil: [ :offset | 
				  | memory |
				  memory := interpreter memory.
				  time <= memory latestTime ifTrue: [ 
					  (memory
						   time: time;
						   at: individual + offset ifAbsent: [ nil ]) ifNotNil: [ :value | 
						  aRMDAttributeDeclarationNode unit fromSI: value ] ] ] ] ] ]
]

{ #category : #accessing }
RMDStageIndividualsAtTimeTabular >> columnCollectors: anArrayOfAssociationOfColumnKeyAndBlock selectVisible: aBlock [

	super
		columnCollectors: { self individualColumnCollector }
			, anArrayOfAssociationOfColumnKeyAndBlock
		selectVisible: aBlock
]

{ #category : #enumerating }
RMDStageIndividualsAtTimeTabular >> generateRowsDo: aBlock [

	(metaInterpreter
		 interpreterAt: runDropList selectedItem
		 ifAbsent: [ nil ]) ifNotNil: [ :interpreter | 
		timeDropList selectedItem ifNotNil: [ :time | 
			stageDropList selectedItem ifNotNil: [ :stage | 
				interpreter memory time: time.
				(Array streamContents: [ :stream | 
					 interpreter memory
						 animatsOf: stage identifier
						 do: [ :individual | stream nextPut: individual ] ])
					asSortedCollection do: aBlock ] ] ]
]

{ #category : #'accessing - column collectors' }
RMDStageIndividualsAtTimeTabular >> individualColumnCollector [

	^ #individual -> [ :individual | individual ]
]

{ #category : #initialization }
RMDStageIndividualsAtTimeTabular >> initializePresenters [

	super initializePresenters.
	stageDropList := self newDropList
		                 display: [ :animatDefinition | 
			                 animatDefinition species , '('
			                 , animatDefinition identifier , ')' ];
		                 whenSelectedItemChangedDo: [ self stageChanged ];
		                 yourself
]

{ #category : #private }
RMDStageIndividualsAtTimeTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self
		updateStageDropList;
		updateTable
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

{ #category : #enumerating }
RMDStageIndividualsAtTimeTabular >> titleRowsDo: aBlock [

	aBlock value: [ :columnKey | 
		columnKey = #individual
			ifTrue: [ 'ID' ]
			ifFalse: [ 
			columnKey identifier , '[' , columnKey unit printString , ']' ] ]
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

	self columnCollectors: (Array streamContents: [ :stream | 
			 runDropList selectedItem ifNotNil: [ :runId | 
				 stageDropList selectedItem ifNotNil: [ :animatDefinition | 
					 animatDefinition attributeDeclarationsDo: [ :attributeDecl | 
						 stream nextPut: (self attributeCollectorOn: attributeDecl) ] ] ] ])
]
