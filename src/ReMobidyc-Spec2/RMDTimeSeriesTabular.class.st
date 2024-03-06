Class {
	#name : #RMDTimeSeriesTabular,
	#superclass : #RMDTabular,
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #testing }
RMDTimeSeriesTabular class >> isAbstract [

	^ self == RMDTimeSeriesTabular
]

{ #category : #initialization }
RMDTimeSeriesTabular >> initializePresenters [

	super initializePresenters.
	table
		whenSelectedItemChangedDo: [ self updateTime ];
		contextMenu: [ self analysisMenu ]
]

{ #category : #updating }
RMDTimeSeriesTabular >> runChanged [

	self updateColumns
]

{ #category : #accessing }
RMDTimeSeriesTabular >> selectTime: aNumber [

	| index |
	aNumber ifNil: [ ^table unselectAll ].
	index := (aNumber / metaInterpreter simulationModel deltaTime)
		         rounded.
	index >= 0
		ifTrue: [ 
		table selectIndex: index + baseRowIndex scrollToSelection: true ]
		ifFalse: [ table unselectAll ]
]

{ #category : #accessing }
RMDTimeSeriesTabular >> selectedTime [

	| index |
	index := table selection selectedIndex - baseRowIndex.
	^ index >= 0
		  ifTrue: [ index * metaInterpreter simulationModel deltaTime ]
		  ifFalse: [ nil ]
]

{ #category : #updating }
RMDTimeSeriesTabular >> updateTime [

	table selectedItem ifNotNil: [ :item |
		item at: #time ifPresent: [ :time |
			self selectedInterpreter ifNotNil: [ :interpreter |
				interpreter time: time ] ] ]
]
