Class {
	#name : #RMDIndividualHistoryValidatorium,
	#superclass : #RMDIndividualHistoryTabular,
	#instVars : [
		'taskList',
		'traceableAction'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #layout }
RMDIndividualHistoryValidatorium class >> defaultLayout [

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
						    add: 'Run';
						    add: #runDropList);
				   add: (SpBoxLayout newVertical
						    add: 'Stage';
						    add: #stageDropList);
				   yourself)
		  expand: false;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.8;
				   add: #table;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.3;
						    add: #taskList;
						    add: #traceableAction));
		  add: (SpBoxLayout newHorizontal
				   add: #openTabularButton width: self buttonHeight;
				   add: #openObservatoryButton width: self buttonHeight;
				   add: '    ' expand: false;
				   add: #openLineChartsButton width: self buttonHeight;
				   add: #exportCSVButton width: self buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #initialization }
RMDIndividualHistoryValidatorium >> initializePresenters [

	super initializePresenters.
	stageDropList whenSelectedItemChangedDo: [ self updateTaskList ].
	table whenSelectedItemChangedDo: [
		self
			updateTaskList;
			updateTraceableAction ].
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
RMDIndividualHistoryValidatorium >> updateTaskList [

	| selection |
	selection := taskList selectedItem.
	self selectedInterpreter ifNotNil: [ :interpreter |
		stageDropList selectedItem ifNotNil: [ :assoc |
			(interpreter simulationModel
				 animatDefinitionAt: assoc value first
				 ifAbsent: [ nil ]) ifNotNil: [ :agent |
				taskList items:
					(interpreter simulationModel taskDefinitions select: [ :task |
						 task enabled and: [
							 task subjectIdentifier = agent name and: [
								 task objectIdentifier isNil ] ] ]) ].
			selection ifNotNil: [ taskList selectItem: selection ].
			^ self ] ].
	taskList items: Array new
]

{ #category : #updating }
RMDIndividualHistoryValidatorium >> updateTraceableAction [

	taskList selectedItem ifNotNil: [ :task |
		self selectedIndividual ifNotNil: [ :subject |
			traceableAction action:
				(task validateWithSubject: subject in: self selectedInterpreter).
			^ self ] ].
	traceableAction action: nil
]
