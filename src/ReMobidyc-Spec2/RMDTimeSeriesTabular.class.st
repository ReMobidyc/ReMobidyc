Class {
	#name : #RMDTimeSeriesTabular,
	#superclass : #RMDTabular,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #accessing }
RMDTimeSeriesTabular >> columnCollectors: anArrayOfAssociationOfColumnKeyAndBlock selectVisible: aBlock [

	super
		columnCollectors:
		{ self timeColumnCollector }
		, anArrayOfAssociationOfColumnKeyAndBlock
		selectVisible: aBlock
]

{ #category : #enumerating }
RMDTimeSeriesTabular >> generateRowsDo: aBlock [

	| latestTime |
	latestTime := self latestTime.
	'Collecting data from the run record'
		displayProgressFrom: 0
		to: latestTime
		during: [ :progress | 
			0 to: latestTime do: [ :time | 
				aBlock value: time.
				progress value: time ] ]
]

{ #category : #initialization }
RMDTimeSeriesTabular >> initializePresenters [

	super initializePresenters.
	table contextMenu: [ self analysisMenu ]
]

{ #category : #updating }
RMDTimeSeriesTabular >> runChanged [

	self updateVisibleColumns
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

{ #category : #'accessing - column collectors' }
RMDTimeSeriesTabular >> timeColumnCollector [

	^ #time -> [ :time | 
	  metaInterpreter simulationModel durationUnit fromSI:
		  time * metaInterpreter simulationModel deltaTime ]
]

{ #category : #updating }
RMDTimeSeriesTabular >> updateVisibleColumns [

	^ self subclassResponsibility
]
