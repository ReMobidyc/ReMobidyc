Class {
	#name : #RMDSpeciesPopulationColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'runId',
		'stages'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

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

	^ self printNat: (stages inject: nil into: [ :sum :stage | 
			   aRow
				   at: { 
						   runId.
						   stage }
				   ifPresent: [ :num | (sum ifNil: [ 0 ]) + num ]
				   ifAbsent: [ sum ] ])
]
