Class {
	#name : #RMDAbstractSnapshotTabular,
	#superclass : #RMDTabular,
	#instVars : [
		'timeList'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #initialization }
RMDAbstractSnapshotTabular >> initializePresenters [

	super initializePresenters.
	timeList := self newList
		            display: [ :time | 
			            | unit |
			            unit := metaInterpreter simulationModel durationUnit.
			            String streamContents: [ :stream | 
					            (unit fromSI:
							             time * metaInterpreter simulationModel deltaTime)
						            printOn: stream
						            showingDecimalPlaces: 4.
					            stream nextPutAll: ' ['.
					            unit printOn: stream.
					            stream nextPutAll: ']' ] ];
		            whenSelectionChangedDo: [ self timeChanged ];
		            contextMenu: [ self analysisMenu ];
		            yourself
]

{ #category : #private }
RMDAbstractSnapshotTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self updateTimeDropList
]

{ #category : #updating }
RMDAbstractSnapshotTabular >> metaInterpreterReloaded [

	self updateTimeDropList.
	super metaInterpreterReloaded
]

{ #category : #updating }
RMDAbstractSnapshotTabular >> runChanged [

	self
		updateTimeDropList;
		updateTable
]

{ #category : #accessing }
RMDAbstractSnapshotTabular >> selectTime: aNumber [

	timeList
		selectIndex: (aNumber
				 ifNotNil: [ 
					 timeList items indexOf:
						 (aNumber / metaInterpreter simulationModel deltaTime) rounded ]
				 ifNil: [ 0 ])
		scrollToSelection: true
]

{ #category : #accessing }
RMDAbstractSnapshotTabular >> selectedTime [

	^ timeList selectedItem ifNotNil: [ :time | 
		  time * metaInterpreter simulationModel deltaTime ]
]

{ #category : #updating }
RMDAbstractSnapshotTabular >> timeChanged [

	self updateRows
]

{ #category : #updating }
RMDAbstractSnapshotTabular >> updateTimeDropList [

	| item items |
	item := timeList selectedItem.
	items := (0 to: self latestTime) asArray.
	timeList
		items: items;
		selectItem: ((items includes: item)
				 ifTrue: [ item ]
				 ifFalse: [ items ifNotEmpty: #first ifEmpty: [ nil ] ])
]
