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
RMDMetaInterpreter class >> on: aRMDSimulationModel modelPath: aFileReference [

	^ self new
		  simulationModel: aRMDSimulationModel;
		  setContext:
			  (RMDMetaContextForFileMemory modelPath: aFileReference);
		  yourself
]

{ #category : #'instancce creation' }
RMDMetaInterpreter class >> on: aRMDSimulationModel readOnlyModelPath: aFileReference [

	^ self new
		  simulationModel: aRMDSimulationModel;
		  setContext:
			  (RMDMetaContextForReadOnlyFileMemory modelPath: aFileReference);
		  yourself
]

{ #category : #'instancce creation' }
RMDMetaInterpreter class >> onModelPath: aFileReference [

	^ self new
		  simulationModel:
			  (RMDSimulationModel
				   importModel: aFileReference
				   ifError: [ ^ nil ]);
		  setContext:
			  (RMDMetaContextForFileMemory modelPath: aFileReference);
		  yourself
]

{ #category : #'instancce creation' }
RMDMetaInterpreter class >> onReadOnlyModelPath: aFileReference [

	^ self new
		  simulationModel:
			  (RMDSimulationModel
				   importModel: aFileReference
				   ifError: [ ^ nil ]);
		  setContext:
			  (RMDMetaContextForReadOnlyFileMemory modelPath: aFileReference);
		  yourself
]

{ #category : #'meta-interpreting' }
RMDMetaInterpreter >> addInterpreterWithMetaparameters: aDictionary multiplicity: anInteger randomSeed: anIntegerOrNil [

	| runIds |
	runIds := Array new: anInteger.
	1 to: anInteger do: [ :index | 
		| runId |
		runId := context
			         addInterpreterOn: simulationModel
			         metaparameters: aDictionary
			         randomSeed: anIntegerOrNil.
		runIds at: index put: runId ].
	^ runIds
]

{ #category : #announcement }
RMDMetaInterpreter >> announceSimulationPaused [

	self announcer announce: (RMDSimulationPaused interpreter: self)
]

{ #category : #announcement }
RMDMetaInterpreter >> announceSimulationStarted [

	self announcer announce: (RMDSimulationStarted interpreter: self)
]

{ #category : #simulating }
RMDMetaInterpreter >> fastForward [

	self interpretersDo: #fastForward
]

{ #category : #accessing }
RMDMetaInterpreter >> guard: aBlock [

	self interpretersDo: [ :interpreter | interpreter guard: aBlock ]
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> interpreterAt: anInteger ifAbsent: errorBlock [

	anInteger ifNil: [ ^ errorBlock value ].
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

{ #category : #accessing }
RMDMetaInterpreter >> memoryName [

	^ context ifNotNil: #memoryName ifNil: [ '' ]
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> nameAt: anInteger ifAbsent: errorBlock [

	^ (context interpreterAt: anInteger ifAbsent: [ ^ errorBlock value ])
		  shortName
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> numberOfInterpreters [

	^ context numberOfInterpreters
]

{ #category : #simulating }
RMDMetaInterpreter >> pauseSimulation [

	self interpretersDo: #pauseSimulation
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
RMDMetaInterpreter >> reloadMemory [

	self interpretersDo: #reloadMemory
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
RMDMetaInterpreter >> runSimulationOnError: errorHandlerBlock [

	self interpretersDo: [ :interpreter | 
		interpreter runSimulationOnError: errorHandlerBlock ].
	[ 
	self announceSimulationStarted.
	self
		waitForPause;
		announceSimulationPaused ] forkAt: Processor userBackgroundPriority
]

{ #category : #'meta-interpreting' }
RMDMetaInterpreter >> setupInterpreters [

	context
		restoreMemoriesDo: [ :memory | 
			context addInterpreter: (simulationModel interpreterOn: memory) ]
		ifEmpty: [ 
			context exportModel: simulationModel.
			simulationModel variability metaEvalIn: self ]
]

{ #category : #simulating }
RMDMetaInterpreter >> setupSimulation [
	self setupInterpreters.
	self interpretersDo: #setupSimulation
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

	[ context isRunningSimulation ] whileTrue: [ self waitingTime wait ]
]

{ #category : #'accessing-interpreters' }
RMDMetaInterpreter >> waitingTime [

	^ 200 milliSecond
]

{ #category : #'context controls' }
RMDMetaInterpreter >> withDryRunContextDo: aBlock [

	^ self withContext: RMDMetaContextForDryRun new do: aBlock
]
