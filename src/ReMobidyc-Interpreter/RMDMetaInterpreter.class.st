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

{ #category : #'meta-interpreting' }
RMDMetaInterpreter >> addSimulationModel: aRMDSimulationModel [

	^ self addSimulationModel: aRMDSimulationModel randomSeed: 1
]

{ #category : #'meta-interpreting' }
RMDMetaInterpreter >> addSimulationModel: aRMDSimulationModel multiplicity: anInteger [

	| runIds |
	runIds := Array new: anInteger.
	1 to: anInteger do: [ :index | 
		| runId |
		runId := context addSimulationModel: aRMDSimulationModel.
		(self interpreterAt: runId ifAbsent: [ nil ]) ifNotNil: [ 
			:interpreter | 
			interpreter randomSeed: SharedRandom globalGenerator next ].
		runIds at: index put: runId ].
	^ runIds
]

{ #category : #'meta-interpreting' }
RMDMetaInterpreter >> addSimulationModel: aRMDSimulationModel randomSeed: anInteger [

	| runId |
	runId := context addSimulationModel: aRMDSimulationModel.
	(self interpreterAt: runId ifAbsent: [ nil ]) ifNotNil: [ 
		:interpreter | interpreter randomSeed: anInteger ].
	^ runId
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

{ #category : #testing }
RMDMetaInterpreter >> isMetaInterpreter [

	^ true
]

{ #category : #simulating }
RMDMetaInterpreter >> isRunningSimulation [

	self interpretersDo: [ :interpreter | 
		interpreter isRunningSimulation ifTrue: [ ^ true ] ].
	^ false
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

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> numberOfInterpreters [

	^ context numberOfInterpreters
]

{ #category : #simulating }
RMDMetaInterpreter >> pauseSimulation [

	self interpretersDo: #pauseSimulation.
	[ 
	self
		waitForPause;
		simulationPaused ] forkAt: Processor userBackgroundPriority
]

{ #category : #simulating }
RMDMetaInterpreter >> progress [

	| sum n |
	sum := 0.0.
	n := 0.
	self interpretersDo: [ :interpreter | 
		sum := sum + interpreter progress.
		n := n + 1 ].
	^ n > 0
		  ifTrue: [ sum / n ]
		  ifFalse: [ ^ 0.0 ]
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
RMDMetaInterpreter >> runSimulation [

	self interpretersDo: #runSimulation
]

{ #category : #simulating }
RMDMetaInterpreter >> setupSimulation [

	self interpretersDo: #setupSimulation
]

{ #category : #announcement }
RMDMetaInterpreter >> simulationPaused [

	self announcer announce: (RMDSimulationPaused interpreter: self)
]

{ #category : #announcement }
RMDMetaInterpreter >> simulationStarted [

	self announcer announce: (RMDSimulationStarted interpreter: self)
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

{ #category : #simulating }
RMDMetaInterpreter >> waitForPause [

	[ context anyInterpreterRunning ] whileTrue: [ self waitingTime wait ]
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> waitingTime [

	^ 200 milliSecond
]

{ #category : #'context controls' }
RMDMetaInterpreter >> withDryRunContextDo: aBlock [

	^ self withContext: RMDMetaContextForDryRun new do: aBlock
]

{ #category : #'context controls' }
RMDMetaInterpreter >> withFileMemoryContextOnModelPath: aFileReference do: aBlock [

	^ self
		  withContext:
		  (RMDMetaContextForFileMemory modelPath: aFileReference)
		  do: aBlock
]
