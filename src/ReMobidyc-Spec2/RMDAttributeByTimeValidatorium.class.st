Class {
	#name : #RMDAttributeByTimeValidatorium,
	#superclass : #RMDAttributeByTimeTabular,
	#instVars : [
		'taskList',
		'traceableActionContext'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #layout }
RMDAttributeByTimeValidatorium class >> defaultLayout [

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

{ #category : #initialization }
RMDAttributeByTimeValidatorium >> initializePresenters [

	super initializePresenters.
	table whenSelectedItemChangedDo: [ self updateTaskList ].
	taskList := self newTable
		            addColumn:
			            (SpStringTableColumn
				             title: 'task'
				             evaluated: #printString);
		            whenSelectedItemChangedDo: [ self updateTraceableAction ];
		            yourself.
	traceableActionContext := self instantiate: RMDTraceableActionContextPresenter
]

{ #category : #updating }
RMDAttributeByTimeValidatorium >> updateTaskList [

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

{ #category : #updating }
RMDAttributeByTimeValidatorium >> updateTraceableAction [

	traceableActionContext context: taskList selectedItem
]
