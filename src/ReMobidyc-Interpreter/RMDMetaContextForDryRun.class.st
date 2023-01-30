Class {
	#name : #RMDMetaContextForDryRun,
	#superclass : #RMDMetaContext,
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #private }
RMDMetaContextForDryRun >> createInterpreterFor: aRMDSimulationModel [

	^ aRMDSimulationModel interpreterForDryRun
]

{ #category : #accessing }
RMDMetaContextForDryRun >> memoryName [

	^ 'dry-run'
]

{ #category : #enumerating }
RMDMetaContextForDryRun >> restoreMemoriesDo: aBlock ifEmpty: emptyBlock [

	^ emptyBlock value
]
