Class {
	#name : #RMDStagePopulationColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'runId',
		'stage'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #initialization }
RMDStagePopulationColumn >> defaultEvaluation [

	^ [ :row | 
	  (self value: row) ifNotNil: [ :value | 
		  value isInteger
			  ifTrue: [ self printNat: value ]
			  ifFalse: [ value ] ] ]
]

{ #category : #accessing }
RMDStagePopulationColumn >> runId [

	^ runId
]

{ #category : #accessing }
RMDStagePopulationColumn >> runId: anInteger [

	runId := anInteger
]

{ #category : #accessing }
RMDStagePopulationColumn >> stage [

	^ stage
]

{ #category : #accessing }
RMDStagePopulationColumn >> stage: aRMDAnimatDefinitionNode [

	stage := aRMDAnimatDefinitionNode
]

{ #category : #accessing }
RMDStagePopulationColumn >> value: aRow [

	^ aRow
		  at: { 
				  runId.
				  stage identifier }
		  ifAbsent: [ nil ]
]
