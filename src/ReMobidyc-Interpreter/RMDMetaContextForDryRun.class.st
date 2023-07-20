Class {
	#name : #RMDMetaContextForDryRun,
	#superclass : #RMDMetaContext,
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #private }
RMDMetaContextForDryRun >> createInterpreterFor: aRMDSimulationModel [

	^ aRMDSimulationModel interpreterForDryRun
]

{ #category : #private }
RMDMetaContextForDryRun >> createInterpreterOn: aRMDSimulationModel metaparameters: aDictionary randomSeed: anIntegerOrNil runId: anInteger [

	| memory |
	memory := RMDDryMemory new.
	memory
		runId: anInteger
		metaparameters: aDictionary
		randomSeed: (anIntegerOrNil ifNil: [ 
				 SharedRandom globalGenerator nextInteger:
					 RMDFishmanMooreRandomGenerator modulo ]).
	^ (aRMDSimulationModel instantiateWithMetaParameters: aDictionary) 
		  interpreterOn: memory
]

{ #category : #private }
RMDMetaContextForDryRun >> exportModel: aRMDSimulationModel [

	
]

{ #category : #accessing }
RMDMetaContextForDryRun >> memoryName [

	^ 'dry-run'
]

{ #category : #accessing }
RMDMetaContextForDryRun >> modelPath [

	^ nil
]

{ #category : #enumerating }
RMDMetaContextForDryRun >> restoreMemoriesDo: aBlock ifEmpty: emptyBlock [

	^ emptyBlock value
]
