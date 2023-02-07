Class {
	#name : #RMDSnapshotTabular,
	#superclass : #RMDTabular,
	#instVars : [
		'timeList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #initialization }
RMDSnapshotTabular >> initializePresenters [

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
RMDSnapshotTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self updateTimeDropList
]

{ #category : #updating }
RMDSnapshotTabular >> metaInterpreterReloaded [

	self updateTimeDropList.
	super metaInterpreterReloaded
]

{ #category : #updating }
RMDSnapshotTabular >> runChanged [

	self
		updateTimeDropList;
		updateTable
]

{ #category : #accessing }
RMDSnapshotTabular >> selectTime: aNumber [

	timeList
		selectIndex: (aNumber
				 ifNotNil: [ 
					 timeList items indexOf:
						 (aNumber / metaInterpreter simulationModel deltaTime) rounded ]
				 ifNil: [ 0 ])
		scrollToSelection: true
]

{ #category : #accessing }
RMDSnapshotTabular >> selectedTime [

	^ timeList selectedItem ifNotNil: [ :time | 
		  time * metaInterpreter simulationModel deltaTime ]
]

{ #category : #updating }
RMDSnapshotTabular >> timeChanged [

	self updateRows
]

{ #category : #updating }
RMDSnapshotTabular >> updateTimeDropList [

	| item items |
	item := timeList selectedItem.
	items := (0 to: self latestTime) asArray.
	timeList
		items: items;
		selectItem: ((items includes: item)
				 ifTrue: [ item ]
				 ifFalse: [ items ifNotEmpty: #first ifEmpty: [ nil ] ])
]
