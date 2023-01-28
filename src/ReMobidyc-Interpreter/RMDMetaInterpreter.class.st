Class {
	#name : #RMDMetaInterpreter,
	#superclass : #RMDAbstractInterpreter,
	#category : #'ReMobidyc-Interpreter-Core'
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

{ #category : #simulating }
RMDMetaInterpreter >> fastForward [

	self interpretersDo: #fastForward
]

{ #category : #threading }
RMDMetaInterpreter >> forkAllInterpretersDo: aBlock at: anInteger [
	
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> interpreterAt: anInteger ifAbsent: errorBlock [

	^ context interpreterAt: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> interpretersDo: aBlock [

	context interpretersDo: aBlock
]

{ #category : #accessing }
RMDMetaInterpreter >> kindName [

	^ 'meta-interpreter'
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> nameAt: anInteger ifAbsent: errorBlock [

	^ (context interpreterAt: anInteger ifAbsent: [ ^ errorBlock value ])
		  simulationModel metaParametersString
]

{ #category : #simulating }
RMDMetaInterpreter >> rewind [

	self interpretersDo: #rewind
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> runIds [

	^ Array streamContents: [ :stream | 
		  context runIdsDo: [ :runId | stream nextPut: runId ] ]
]

{ #category : #simulating }
RMDMetaInterpreter >> setupSimulation [

	self interpretersDo: #setupSimulation
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> simulationModelAt: anInteger ifAbsent: errorBlock [

	^ (context interpreterAt: anInteger ifAbsent: [ ^ errorBlock value ])
		  simulationModel
]

{ #category : #simulating }
RMDMetaInterpreter >> stepSimulation [

	| finishSemaphore |
	finishSemaphore := Semaphore new.
	self interpretersDo: [ :interpreter | 
		[ [ interpreter stepSimulation ] ensure: [ finishSemaphore signal ] ] 
			forkAt: Processor userBackgroundPriority ].
	self interpretersDo: [ :interpreter | finishSemaphore wait ]
]

{ #category : #simulating }
RMDMetaInterpreter >> typecheck [

	self interpretersDo: #typecheck
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> waitForRunningInterpreters [

	[ context anyInterpreterRunning ] whileTrue: [ self waitingTime wait ]
]

{ #category : #'context controls' }
RMDMetaInterpreter >> withContext: aRMDContext do: aBlock [

	self shouldNotImplement
]

{ #category : #'context controls' }
RMDMetaInterpreter >> withSubContext: aRMDContext do: aBlock [

	^ self shouldNotImplement
]
