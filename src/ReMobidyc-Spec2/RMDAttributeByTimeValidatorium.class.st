Class {
	#name : #RMDAttributeByTimeValidatorium,
	#superclass : #RMDAttributeByTimeTabular,
	#instVars : [
		'taskList',
		'traceableAction'
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
		  add: #table;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.3;
				   add: #taskList;
				   add: #traceableAction);
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
				             title: 'verb'
				             evaluated: #verbIdentifier);
		            whenSelectedItemChangedDo: [ self updateTraceableAction ];
		            yourself.
	traceableAction := self instantiate: RMDTraceableActionPresenter
]

{ #category : #updating }
RMDAttributeByTimeValidatorium >> updateTaskList [

	| selection |
	selection := taskList selectedItem.
	self selectedInterpreter ifNotNil: [ :interpreter |
		agentDropList selectedItem ifNotNil: [ :agent |
			taskList items:
				(interpreter simulationModel taskDefinitions select: [ :task |
					 task enabled and: [
						 task subjectIdentifier = agent name and: [
							 task objectIdentifier isNil ] ] ]).
			selection ifNotNil: [ taskList selectItem: selection ].
			^ self ] ].
	taskList items: Array new
]

{ #category : #updating }
RMDAttributeByTimeValidatorium >> updateTraceableAction [

	taskList selectedItem ifNotNil: [ :task |
		self selectedIndividual ifNotNil: [ :subject |
			traceableAction action:
				(task validateWithSubject: subject in: self selectedInterpreter).
			^ self ] ].
	traceableAction action: nil
]
