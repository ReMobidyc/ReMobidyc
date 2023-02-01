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
	latestTime := 0.
	metaInterpreter interpretersDo: [ :interpreter | 
		latestTime := latestTime max: interpreter memory latestTime ].
	'Collecting data from the run record'
		displayProgressFrom: 1
		to: latestTime
		during: [ :progress | TimeProfiler spyOn: [ 
			1 to: latestTime do: [ :time | 
				aBlock value: time.
				progress value: time ] ]]
]

{ #category : #updating }
RMDTimeSeriesTabular >> runChanged [

	runDropList selectedItem
		ifNotNil: [ :runId | 
			self selectVisibleColumns: [ :columnKey | columnKey first = runId ] ]
		ifNil: [ self selectVisibleColumns: [ :columnKey | true ] ]
]

{ #category : #'accessing - column collectors' }
RMDTimeSeriesTabular >> timeColumnCollector [

	^ #time -> [ :rowIndex | 
	  metaInterpreter simulationModel durationUnit fromSI:
		  rowIndex - 1 * metaInterpreter simulationModel deltaTime ]
]
