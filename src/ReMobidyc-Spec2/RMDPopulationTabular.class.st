Class {
	#name : #RMDPopulationTabular,
	#superclass : #RMDTimeSeriesTabular,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDPopulationTabular class >> on: aRMDMetaInterpreter [

	^ self new metaInterpreter: aRMDMetaInterpreter
]

{ #category : #'instance creation' }
RMDPopulationTabular class >> openOn: aRMDMetaInterpreter [

	^ (self on: aRMDMetaInterpreter) open
]

{ #category : #initialization }
RMDPopulationTabular >> initializePresenters [

	super initializePresenters.
	table hideColumnHeaders
]

{ #category : #accessing }
RMDPopulationTabular >> metaInterpreter: aRMDMetaInterpreter [

	super metaInterpreter: aRMDMetaInterpreter.
	self columnCollectors: (Array streamContents: [ :stream | 
			 metaInterpreter interpretersDo: [ :interpreter | 
				 metaInterpreter simulationModel animatDefinitionsDo: [ 
					 :animatDefinition | 
					 stream nextPut: (self
							  populationCollectorOnRunId: interpreter runId
							  animat: animatDefinition) ] ] ])
]

{ #category : #'accessing - column collectors' }
RMDPopulationTabular >> populationCollectorOnRunId: anInteger animat: aRMDAnimatDefinition [

	^ { 
		  anInteger.
		  aRMDAnimatDefinition } -> [ :rowIndex | 
	  (metaInterpreter interpreterAt: anInteger ifAbsent: [ nil ]) 
		  ifNotNil: [ :interpreter | 
			  | memory time |
			  memory := interpreter memory.
			  time := rowIndex - 1.
			  time <= memory latestTime
				  ifTrue: [ 
					  memory
						  time: time;
						  numberOfAnimats: aRMDAnimatDefinition identifier ]
				  ifFalse: [ '' ] ] ]
]

{ #category : #enumerating }
RMDPopulationTabular >> titleRowsDo: aBlock [

	aBlock value: [ :columnKey | 
		columnKey = #time
			ifTrue: [ 
				'time ['
				, metaInterpreter simulationModel durationUnit printString , ']' ]
			ifFalse: [ 
				(metaInterpreter interpreterAt: columnKey first ifAbsent: [ nil ]) 
					ifNotNil: [ :interpreter | 
						columnKey first printString , ':'
						, interpreter metaparametersString ] ] ].
	aBlock value: [ :columnKey | 
		columnKey = #time
			ifTrue: [ '' ]
			ifFalse: [ columnKey second species ] ].
	aBlock value: [ :columnKey | 
		columnKey = #time
			ifTrue: [ '' ]
			ifFalse: [ columnKey second identifier ] ]
]
