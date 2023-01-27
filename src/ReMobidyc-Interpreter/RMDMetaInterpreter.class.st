Class {
	#name : #RMDMetaInterpreter,
	#superclass : #RMDAbstractInterpreter,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instancce creation' }
RMDMetaInterpreter class >> forDryRunOn: aRMDSimulationModel [

	^ self new
		  simulationModel: aRMDSimulationModel;
		  setContext: RMDMetaContextForDryRun new;
		  yourself
]

{ #category : #'instancce creation' }
RMDMetaInterpreter class >> forModelPath: aFileReference on: aRMDSimulationModel [

	^ self new
		  simulationModel: aRMDSimulationModel;
		  setContext:
			  (RMDMetaContextForFileMemory modelPath: aFileReference);
		  yourself
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> interpreterAt: anInteger ifAbsent: errorBlock [

	^ context interpreterAt: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> interpretersDo: aBlock [

	context interpretersDo: aBlock
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> nameAt: anInteger ifAbsent: errorBlock [

	^ (context interpreterAt: anInteger ifAbsent: [ ^ errorBlock value ])
		  simulationModel metaParametersString
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> runIds [

	^ Array streamContents: [ :stream | 
		  context runIdsDo: [ :runId | stream nextPut: runId ] ]
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> simulationModelAt: anInteger ifAbsent: errorBlock [

	^ (context interpreterAt: anInteger ifAbsent: [ ^ errorBlock value ])
		  simulationModel
]
