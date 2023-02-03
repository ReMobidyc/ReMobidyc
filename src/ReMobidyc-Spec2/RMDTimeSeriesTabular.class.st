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

{ #category : #updating }
RMDTimeSeriesTabular >> runChanged [

	self updateVisibleColumns
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
