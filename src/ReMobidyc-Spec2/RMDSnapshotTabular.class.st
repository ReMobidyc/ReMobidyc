Class {
	#name : #RMDSnapshotTabular,
	#superclass : #RMDTabular,
	#instVars : [
		'timeDropList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #initialization }
RMDSnapshotTabular >> initializePresenters [

	super initializePresenters.
	timeDropList := self newDropList
		                display: [ :time | 
			                | unit |
			                unit := metaInterpreter simulationModel
				                        durationUnit.
			                String streamContents: [ :stream | 
					                (unit fromSI:
							                 time
							                 * metaInterpreter simulationModel deltaTime)
						                printOn: stream
						                showingDecimalPlaces: 4.
					                stream nextPutAll: ' ['.
					                unit printOn: stream.
					                stream nextPutAll: ']' ] ];
		                whenSelectedItemChangedDo: [ self timeChanged ];
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

{ #category : #updating }
RMDSnapshotTabular >> timeChanged [

	self updateRows
]

{ #category : #updating }
RMDSnapshotTabular >> updateTimeDropList [

	| item items |
	item := timeDropList selectedItem.
	items := (0 to: self latestTime) asArray.
	timeDropList
		items: items;
		selectItem: ((items includes: item)
				 ifTrue: [ item ]
				 ifFalse: [ items ifNotEmpty: #first ifEmpty: [ nil ] ])
]
