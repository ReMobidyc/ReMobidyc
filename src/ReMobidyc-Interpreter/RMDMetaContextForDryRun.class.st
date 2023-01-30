Class {
	#name : #RMDMetaContextForDryRun,
	#superclass : #RMDMetaContext,
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #private }
RMDMetaContextForDryRun >> createInterpreterFor: aRMDSimulationModel [

	^ aRMDSimulationModel interpreterForDryRun
]

{ #category : #enumerating }
RMDMetaContextForDryRun >> restoreMemoriesDo: aBlock ifEmpty: emptyBlock [

	^ emptyBlock value
]
