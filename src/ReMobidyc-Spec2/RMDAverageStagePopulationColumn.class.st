Class {
	#name : #RMDAverageStagePopulationColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'runIds',
		'stage'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #accessing }
RMDAverageStagePopulationColumn >> runIds [

	^ runIds
]

{ #category : #accessing }
RMDAverageStagePopulationColumn >> runIds: anArrayOfInteger [

	runIds := anArrayOfInteger
]

{ #category : #accessing }
RMDAverageStagePopulationColumn >> stage [

	^ stage
]

{ #category : #accessing }
RMDAverageStagePopulationColumn >> stage: aRMDAnimatDefinitionNode [

	stage := aRMDAnimatDefinitionNode
]

{ #category : #accessing }
RMDAverageStagePopulationColumn >> value: aRow [

	^ self printNat: ((runIds
			    collect: [ :runId | 
				    aRow
					    at: { 
							    runId.
							    stage identifier }
					    ifAbsent: [ nil ] ]
			    thenSelect: #notNil) ifNotEmpty: #average ifEmpty: [ nil ])
]
