Class {
	#name : #RMDSnapshotValidatorium,
	#superclass : #RMDSnapshotTabular,
	#instVars : [
		'taskList',
		'traceableActionContext'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #layout }
RMDSnapshotValidatorium class >> defaultLayout [

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

{ #category : #initialization }
RMDSnapshotValidatorium >> initializePresenters [

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
RMDSnapshotValidatorium >> updateTaskList [

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
RMDSnapshotValidatorium >> updateTraceableAction [

	traceableActionContext context: taskList selectedItem
]
