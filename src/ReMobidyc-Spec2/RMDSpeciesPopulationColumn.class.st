Class {
	#name : #RMDSpeciesPopulationColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'runId',
		'stages'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #initialization }
RMDSpeciesPopulationColumn >> defaultEvaluation [

	^ [ :row | 
	  (self value: row) ifNotNil: [ :value | 
		  value isInteger
			  ifTrue: [ self printNat: value ]
			  ifFalse: [ value ] ] ]
]

{ #category : #accessing }
RMDSpeciesPopulationColumn >> runId [

	^ runId
]

{ #category : #accessing }
RMDSpeciesPopulationColumn >> runId: anInteger [

	runId := anInteger
]

{ #category : #accessing }
RMDSpeciesPopulationColumn >> stages [

	^ stages
]

{ #category : #accessing }
RMDSpeciesPopulationColumn >> stages: anArrayOfString [

	stages := anArrayOfString
]

{ #category : #accessing }
RMDSpeciesPopulationColumn >> value: aRow [

	^ stages inject: nil into: [ :sum :stage | 
		  aRow
			  at: { 
					  runId.
					  stage }
			  ifPresent: [ :num | (sum ifNil: [ 0 ]) + num ]
			  ifAbsent: [ sum ] ]
]
