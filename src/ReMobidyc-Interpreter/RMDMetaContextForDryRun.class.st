Class {
	#name : #RMDMetaContextForDryRun,
	#superclass : #RMDMetaContext,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDMetaContextForDryRun >> createInterpreterFor: aRMDSimulationModel [

	^ aRMDSimulationModel interpreterForDryRun
]
