Class {
	#name : #RMDMetaContextForDryRun,
	#superclass : #RMDMetaContext,
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #private }
RMDMetaContextForDryRun >> createInterpreterFor: aRMDSimulationModel [

	^ aRMDSimulationModel interpreterForDryRun
]
