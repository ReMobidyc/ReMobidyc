Class {
	#name : #RMDInterpreter,
	#superclass : #RMDAbstractInterpreter,
	#instVars : [
		'memory',
		'libraries',
		'runSemaphore',
		'runState',
		'guard'
	],
	#category : #'ReMobidyc-Interpreter-Core'
}

{ #category : #'accessing - libraries' }
RMDInterpreter >> addLibraries: aCollectionOfDictionary [
	libraries addAll: aCollectionOfDictionary
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> addLibrary: aDictionary [
	libraries add: aDictionary
]

{ #category : #announcement }
RMDInterpreter >> announceSimulationPaused [

	self announcer announce: (RMDSimulationPaused interpreter: self)
]

{ #category : #announcement }
RMDInterpreter >> announceSimulationStarted [

	self announcer announce: (RMDSimulationStarted interpreter: self)
]

{ #category : #announcement }
RMDInterpreter >> announceTimeChanged [

	self announcer announce:
		(RMDTimeChanged interpreter: self time: self time)
]

{ #category : #simulating }
RMDInterpreter >> basicStepSimulation [

	^ (guard value: self) and: [ 
		  self time < simulationModel duration and: [ 
			  memory time + 1 <= memory latestTime
				  ifTrue: [ memory time: memory time + 1 ]
				  ifFalse: [ 
					  self performTasks.
					  self bounceOutOfBoundsAnimats.
					  self tick ].
			  self announceTimeChanged.
			  true ] ]
]

{ #category : #private }
RMDInterpreter >> bounceOutOfBoundsAnimats [

	simulationModel animatDefinitionsDo: [ :animatDef | 
		| xOffset yOffset |
		xOffset := animatDef attributeOffsetAt: 'x' ifAbsent: [ 
			           ^ RMDUndefinedAttributeError signal:
				             (RMDAttributeVariableNode identifier: 'x' agent: nil) ].
		yOffset := animatDef attributeOffsetAt: 'y' ifAbsent: [ 
			           ^ RMDUndefinedAttributeError signal:
				             (RMDAttributeVariableNode identifier: 'y' agent: nil) ].
		memory animatsOf: animatDef identifier do: [ :individual | 
			memory
				nextAndDeltaAt: individual + xOffset
				between: simulationModel west
				and: simulationModel east;
				nextAndDeltaAt: individual + yOffset
				between: simulationModel south
				and: simulationModel north ] ]
]

{ #category : #directives }
RMDInterpreter >> byChanceOf: aNumber [
	^ self random < aNumber
]

{ #category : #'space access' }
RMDInterpreter >> centerXOfPatch: anInteger [

	^ (self xPatchOf: anInteger) - 0.5 * simulationModel patchLength
]

{ #category : #'space access' }
RMDInterpreter >> centerYOfPatch: anInteger [

	^ (self yPatchOf: anInteger) - 0.5 * simulationModel patchLength
]

{ #category : #'animat operations' }
RMDInterpreter >> changeStage: animatString [

	| animatDefinition newIndividual offset |
	animatDefinition := simulationModel
		                    animatDefinitionAt: animatString
		                    ifAbsent: [ 
		                    ^ RMDUndefinedAnimatError signal: animatString ].
	newIndividual := memory
		                 stageAnimat: animatDefinition
		                 with: context subject.
	memory seedAt: newIndividual put: self nextSeed.
	context
		newIndividuals: { newIndividual }
		definition: animatDefinition.
	offset := 0.
	animatDefinition allAttributeDeclarations do: [ :attributeDecl | 
		| value |
		value := self my: attributeDecl identifier ifAbsent: [ 0.0 ].
		memory nextAt: newIndividual + offset put: value.
		offset := offset + 1 ].
	self
		withSubInitializerContextWithSubject: newIndividual
		definition: animatDefinition
		do: [ animatDefinition evalIn: self ].
	memory removeAnimat: context subject.
	context subject
		to:
			context subject + context subjectDefinition totalNumberOfAttributes
			- 1
		do: [ :slot | memory nextAt: slot put: nil ].
	^ newIndividual
]

{ #category : #simulating }
RMDInterpreter >> critical: aBlock [

	^ runSemaphore critical: [ 
		  self announceSimulationStarted.
		  runState := true.
		  aBlock ensure: [ 
			  runState := false.
			  self announceSimulationPaused ] ]
]

{ #category : #timing }
RMDInterpreter >> deltaTime [

	^ self simulationModel deltaTime
]

{ #category : #timing }
RMDInterpreter >> duration [
	^ simulationModel duration
]

{ #category : #'variable access' }
RMDInterpreter >> easts: aString ifAbsent: errorBlock [

	memory eastOf: context location do: [ :id | 
		^ memory
			  at:
				  id + (context locationDefinition offsetAt: aString ifAbsent: [ 
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
			  ifAbsent: [ 
				  RMDAddressError signal:
					  (RMDAttributeVariableNode identifier: aString agent: nil) ] ].
	^ errorBlock value
]

{ #category : #exporting }
RMDInterpreter >> exportAPNG: aFileReference [

	^ self exportAPNG: aFileReference extent: 250 @ 250
]

{ #category : #exporting }
RMDInterpreter >> exportAPNG: aFileReference extent: aPoint [

	| oldTime |
	oldTime := self time.
	[
	self time: 0.
	aFileReference binaryWriteStreamDo: [ :stream |
		| writer visualizer |
		writer := RMDAPNGWriter on: stream.
		"writer numPlays: 1."
		visualizer := RMDVisualizer extent: 500 @ 500.
		self simulationModel renderersDo: [ :renderer |
			visualizer addRenderer: renderer ].
		[
		UIManager default
			displayProgress: 'exporting animated png'
			from: 0.0
			to: self duration
			during: [ :progress |
				[ self time < self duration ] whileTrue: [
					writer nextPutImage:
						((visualizer visualize: self) scaledToSize: aPoint).
					self performTasks.
					self bounceOutOfBoundsAnimats.
					self tick.
					progress value: self time ] ].
		writer nextPutImage: (visualizer visualize: self) ] ensure: [
			writer close ] ] ] ensure: [ self time: oldTime ]
]

{ #category : #simulating }
RMDInterpreter >> fastForward [

	self critical: [ 
		memory time: memory latestTime.
		self announceTimeChanged ]
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> functionAt: aString ifAbsent: errorBlock [
	libraries
		do:
			[ :library | library at: aString ifPresent: [ :function | ^ function ] ].
	^ errorBlock value
]

{ #category : #accessing }
RMDInterpreter >> guard [

	^ guard
]

{ #category : #accessing }
RMDInterpreter >> guard: aBlock [

	guard := aBlock
]

{ #category : #'space access' }
RMDInterpreter >> here [

	| patchX patchY |
	patchX := (self patchX: (self my: 'x')) floor + 1
		          min: simulationModel patchXDivisions
		          max: 1.
	patchY := (self patchY: (self my: 'y')) floor + 1
		          min: simulationModel patchYDivisions
		          max: 1.
	^ memory patchAtXIndex: patchX yIndex: patchY
]

{ #category : #'variable access' }
RMDInterpreter >> heres: aString [

	^ memory
		  at: context location
			  + (context locationDefinition offsetAt: aString ifAbsent: [ 
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
		  ifAbsent: [ 
			  RMDAddressError signal:
				  (RMDAttributeVariableNode identifier: aString agent: nil) ]
]

{ #category : #'animat operations' }
RMDInterpreter >> individualsOf: aRMDAgentDefinitionNode do: aBlock [

	aRMDAgentDefinitionNode isAnimatDefinitionNode ifTrue: [ 
		memory animatsOf: aRMDAgentDefinitionNode identifier do: aBlock.
		^ self ].
	aRMDAgentDefinitionNode isPatchDefinitionNode ifTrue: [ 
		memory patchesDo: aBlock.
		^ self ].
	aRMDAgentDefinitionNode isWorldDefinitionNode ifTrue: [ 
		memory worldDo: aBlock.
		^ self ].
	^ self error: 'Unknown agent type'
]

{ #category : #initialization }
RMDInterpreter >> initialize [

	super initialize.
	runSemaphore := Semaphore forMutualExclusion.
	libraries := OrderedCollection with: self standardLibrary.
	guard := [ :interpreter | true ]
]

{ #category : #simulating }
RMDInterpreter >> isRunningSimulation [

	^ runState
]

{ #category : #accessing }
RMDInterpreter >> kindName [

	^ 'interpreter'
]

{ #category : #simulating }
RMDInterpreter >> loadDataSources [

	memory
		addInputForAgentDefinition: simulationModel worldDefinition
		duration: self duration
		timeStep: self deltaTime.
	memory
		addInputForAgentDefinition: simulationModel patchDefinition
		duration: self duration
		timeStep: self deltaTime.
	simulationModel animatDefinitionsDo: [ :animatDefinition |
		memory
			addInputForAgentDefinition: animatDefinition
			duration: self duration
			timeStep: self deltaTime ]
]

{ #category : #private }
RMDInterpreter >> memory [
	^ memory
]

{ #category : #accessing }
RMDInterpreter >> memoryName [

	^ memory ifNotNil: #name ifNil: [ '' ]
]

{ #category : #'accessing - meta parameters' }
RMDInterpreter >> metaparameters [

	^ memory metaparameters
]

{ #category : #'accessing - meta parameters' }
RMDInterpreter >> metaparametersString [

	^ memory metaparametersString
]

{ #category : #'variable access' }
RMDInterpreter >> my: aString [

	^ memory
		  at: context subject
			  + (context subjectDefinition offsetAt: aString ifAbsent: [ 
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
		  ifAbsent: [ 
			  RMDAddressError signal:
				  (RMDAttributeVariableNode identifier: aString agent: nil) ]
]

{ #category : #'variable access' }
RMDInterpreter >> my: aString ifAbsent: errorBlock [

	^ memory
		  at: context subject + (context subjectDefinition
				   offsetAt: aString
				   ifAbsent: [ ^ errorBlock value ])
		  ifAbsent: errorBlock
]

{ #category : #accessing }
RMDInterpreter >> name [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: super name;
			  nextPutAll: '[';
			  nextPutAll: self metaparametersString;
			  nextPutAll: ']' ]
]

{ #category : #'animat operations' }
RMDInterpreter >> newIndividual: animatString quantity: anInteger [

	| animatDefinition newIndividuals offset |
	animatDefinition := simulationModel
		                    animatDefinitionAt: animatString
		                    ifAbsent: [ 
		                    ^ RMDUndefinedAnimatError signal: animatString ].
	newIndividuals := (1 to: anInteger) collect: [ :i | 
		                  | id |
		                  id := memory
			                        reproduceAnimat: animatDefinition
			                        with: context subject.
		                  memory seedAt: id put: self nextSeed.
		                  id ].
	context newIndividuals: newIndividuals definition: animatDefinition.
	offset := 0.
	animatDefinition allAttributeDeclarations do: [ :attributeDecl | 
		| value |
		value := self my: attributeDecl identifier ifAbsent: [0.0].
		newIndividuals do: [ :individual | 
			memory nextAt: individual + offset put: value ].
		offset := offset + 1 ].
	newIndividuals do: [ :individual | 
		self
			withSubInitializerContextWithSubject: individual
			definition: animatDefinition
			do: [ animatDefinition evalIn: self ] ].
	^ newIndividuals
]

{ #category : #'random numbers' }
RMDInterpreter >> nextSeed [

	^ context nextSeed
]

{ #category : #'variable access' }
RMDInterpreter >> norths: aString ifAbsent: errorBlock [

	memory northOf: context location do: [ :id | 
		^ memory
			  at:
				  id + (context locationDefinition offsetAt: aString ifAbsent: [ 
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
			  ifAbsent: [ 
				  RMDAddressError signal:
					  (RMDAttributeVariableNode identifier: aString agent: nil) ] ].
	^ errorBlock value
]

{ #category : #directives }
RMDInterpreter >> numberOfIndividuals [

	^ memory numberOfAnimats
]

{ #category : #directives }
RMDInterpreter >> numberOfIndividualsInPatch: animatName [

	| total |
	total := 0.
	simulationModel stagesOf: animatName do: [ :animatDef |
		total := total + (memory
			          numberOfAnimats: animatDef identifier
			          patch: context location
			          patchBlock: [ :x :y |
				          | patchX patchY |
				          patchX := (self patchX: x) floor + 1
					                    min: simulationModel patchXDivisions
					                    max: 1.
				          patchY := (self patchY: y) floor + 1
					                    min: simulationModel patchYDivisions
					                    max: 1.
				          memory patchAtXIndex: patchX yIndex: patchY ]) ].
	^ total
]

{ #category : #directives }
RMDInterpreter >> numberOfIndividualsInWorld: animatName [

	| total |
	total := 0.
	simulationModel stagesOf: animatName do: [ :animatDef |
		total := total + (memory numberOfAnimats: animatDef identifier) ].
	^ total
]

{ #category : #'animat operations' }
RMDInterpreter >> numberOfIndividualsOf: aRMDAgentDefinitionNode [

	aRMDAgentDefinitionNode isWorldDefinitionNode ifTrue: [ ^ 1 ].
	aRMDAgentDefinitionNode isPatchDefinitionNode ifTrue: [ 
		^ memory xPatches * memory yPatches ].
	^ memory numberOfAnimats: aRMDAgentDefinitionNode identifier
]

{ #category : #'variable access' }
RMDInterpreter >> objects: aString [

	^ memory
		  at: context object
			  + (context objectDefinition offsetAt: aString ifAbsent: [ 
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
		  ifAbsent: [ 
			  RMDAddressError signal:
				  (RMDAttributeVariableNode identifier: aString agent: nil) ]
]

{ #category : #directives }
RMDInterpreter >> patchArea [

	^ self simulationModel patchLength squared
]

{ #category : #'space access' }
RMDInterpreter >> patchAtXIndex: anInteger yIndex: anotherInteger [
	^ memory patchAtXIndex: anInteger yIndex: anotherInteger
]

{ #category : #directives }
RMDInterpreter >> patchLength [

	^ self simulationModel patchLength
]

{ #category : #'space access' }
RMDInterpreter >> patchX: aNumber [

	^ aNumber - self simulationModel west / simulationModel patchLength
]

{ #category : #'space access' }
RMDInterpreter >> patchY: aNumber [

	^ aNumber - self simulationModel south / simulationModel patchLength
]

{ #category : #'space access' }
RMDInterpreter >> patchesDo: aBlock [

	memory patchesDo: aBlock
]

{ #category : #simulating }
RMDInterpreter >> pauseSimulation [

	runState := false
]

{ #category : #private }
RMDInterpreter >> performTasks [
	simulationModel tasksDo: [ :task | task evalIn: self ]
]

{ #category : #simulating }
RMDInterpreter >> progress [

	^ self time / self duration
]

{ #category : #'random numbers' }
RMDInterpreter >> random [

	^ context random
]

{ #category : #'accessing - meta parameters' }
RMDInterpreter >> randomSeed [

	^ memory randomSeed
]

{ #category : #'variable access' }
RMDInterpreter >> read: anInteger ifAbsent: errorBlock [

	^ memory at: anInteger ifAbsent: errorBlock
]

{ #category : #'variable access' }
RMDInterpreter >> readUtility: aString ifAbsent: errorBlock [

	| numberOrExpression |
	numberOrExpression := context utilityAt: aString ifAbsent: errorBlock.

	^ numberOrExpression isNumber
		  ifTrue: [ numberOrExpression ]
		  ifFalse: [ 
		  context utilityAt: aString put: (numberOrExpression evalIn: self) ]
]

{ #category : #timing }
RMDInterpreter >> reloadMemory [

	memory reload
]

{ #category : #private }
RMDInterpreter >> removeOutOfBoundsAnimats [

	simulationModel animatDefinitionsDo: [ :animatDef | 
		| xOffset yOffset |
		xOffset := animatDef attributeOffsetAt: 'x' ifAbsent: [ 
			           ^ RMDUndefinedAttributeError signal:
				             (RMDAttributeVariableNode identifier: 'x' agent: nil) ].
		yOffset := animatDef attributeOffsetAt: 'y' ifAbsent: [ 
			           ^ RMDUndefinedAttributeError signal:
				             (RMDAttributeVariableNode identifier: 'y' agent: nil) ].
		memory animatsOf: animatDef identifier do: [ :individual | 
			| x y |
			x := memory at: individual + xOffset ifAbsent: [ nil ].
			y := memory at: individual + yOffset ifAbsent: [ nil ].
			((x between: simulationModel west and: simulationModel east) and: [ 
				 y between: simulationModel south and: simulationModel north ]) 
				ifFalse: [ self terminate: individual animat: animatDef ] ] ]
]

{ #category : #'accessing - repository' }
RMDInterpreter >> repositoryName [
	^ 'local'
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> resetTasks [
	simulationModel tasksDo: [ :task | task resetAction ]
]

{ #category : #simulating }
RMDInterpreter >> rewind [

	self critical: [ 
		memory time: 0.
		self announceTimeChanged ]
]

{ #category : #'accessing - meta parameters' }
RMDInterpreter >> runId [

	^ memory runId
]

{ #category : #simulating }
RMDInterpreter >> runSimulationOnError: errorHandlerBlock [

	[ 
	self critical: [ 
		[ [ runState = true and: [ self basicStepSimulation ] ] whileTrue ]
			on: RMDSemanticError
			do: errorHandlerBlock ] ] forkAt: Processor userBackgroundPriority 
]

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [

	memory := aRMDMemory
]

{ #category : #'random numbers' }
RMDInterpreter >> setupRandomForIndividual: anInteger1 and: anInteger2 task: aRMDTaskDefinitionNode [

	context randomSeedWithHash: { 
			self randomSeed.
			memory time.
			(memory seedAt: anInteger1).
			(memory seedAt: anInteger2).
			(self simulationModel taskDefinitions indexOf:
				 aRMDTaskDefinitionNode) }
]

{ #category : #'random numbers' }
RMDInterpreter >> setupRandomForIndividual: anInteger task: aRMDTaskDefinitionNode [

	context randomSeedWithHash: { 
			self randomSeed.
			memory time.
			(memory seedAt: anInteger).
			(self simulationModel taskDefinitions indexOf:
				 aRMDTaskDefinitionNode) }
]

{ #category : #simulating }
RMDInterpreter >> setupSimulation [

	self critical: [
		memory world ifNil: [
			memory initialize.
			self loadDataSources.
			simulationModel worldInitializer evalIn: self.
			simulationModel patchInitializer evalIn: self.
			simulationModel animatInitializersDo: [ :initializer |
				initializer evalIn: self ] ].
		memory time: 0.
		self announceTimeChanged ]
]

{ #category : #accessing }
RMDInterpreter >> shortName [

	^ self runId printString, ':', self metaparametersString
]

{ #category : #'variable access' }
RMDInterpreter >> souths: aString ifAbsent: errorBlock [

	memory southOf: context location do: [ :id | 
		^ memory
			  at:
				  id + (context locationDefinition offsetAt: aString ifAbsent: [ 
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
			  ifAbsent: [ 
				  RMDAddressError signal:
					  (RMDAttributeVariableNode identifier: aString agent: nil) ] ].
	^ errorBlock value
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> standardLibrary [
	^ self class standardLibrary 
]

{ #category : #simulating }
RMDInterpreter >> stepSimulation [

	self critical: [ ^ self basicStepSimulation ]
]

{ #category : #'random numbers' }
RMDInterpreter >> taskHashFor: aRMDTaskDefinitionNode [

	^ simulationModel taskDefinitions indexOf: aRMDTaskDefinitionNode
]

{ #category : #'animat operations' }
RMDInterpreter >> terminate: aString [

	^ aString
		  ifNotNil: [
		  self terminate: context object animat: context objectDefinition ]
		  ifNil: [
		  self terminate: context subject animat: context subjectDefinition ]
]

{ #category : #'animat operations' }
RMDInterpreter >> terminate: anInteger animat: aRMDAnimatDefinitionNode [

	memory
		removeAnimat: anInteger;
		removeSeedAt: anInteger.
	anInteger to:
	anInteger + aRMDAnimatDefinitionNode totalNumberOfAttributes - 1 do: [ 
	:slot | memory nextAt: slot put: nil ]
]

{ #category : #timing }
RMDInterpreter >> tick [

	memory tick
]

{ #category : #timing }
RMDInterpreter >> ticks [

	^ memory time
]

{ #category : #timing }
RMDInterpreter >> time [

	^ memory time * self deltaTime
]

{ #category : #timing }
RMDInterpreter >> time: aNumber [

	| newTime lastTime |
	newTime := (aNumber / self deltaTime) rounded.
	lastTime := memory latestTime.
	lastTime < newTime
		ifTrue: [
			Cursor wait showWhile: [
				memory time: lastTime.
				[ memory time < newTime ] whileTrue: [
					self performTasks.
					self bounceOutOfBoundsAnimats.
					self tick ] ] ]
		ifFalse: [ memory time: newTime ].
	self announceTimeChanged
]

{ #category : #simulating }
RMDInterpreter >> typecheck [

	self critical: [ simulationModel typecheck ]
]

{ #category : #simulating }
RMDInterpreter >> waitForPause [

	[ self isRunningSimulation ] whileTrue: [ self waitingTime wait ]
]

{ #category : #accessing }
RMDInterpreter >> waitingTime [

	^ 200 milliSecond
]

{ #category : #'variable access' }
RMDInterpreter >> wests: aString ifAbsent: errorBlock [

	memory westOf: context location do: [ :id | 
		^ memory
			  at:
				  id + (context locationDefinition offsetAt: aString ifAbsent: [ 
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
			  ifAbsent: [ 
				  RMDAddressError signal:
					  (RMDAttributeVariableNode identifier: aString agent: nil) ] ].
	^ errorBlock value
]

{ #category : #'context controls' }
RMDInterpreter >> withActionContextWith: aRMDActionDefinitionNode subject: anInteger1 definition: aRMDAnimatDefinitionNode1 object: anInteger2 definition: aRMDAnimatDefinitionNode2 taskHash: hashInteger do: aBlock [

	| newContext |
	newContext := (RMDActionContext
		               subject: anInteger1
		               definition: aRMDAnimatDefinitionNode1)
		              space: memory;
		              randomSeedWithHash: { 
				              self randomSeed.
				              memory time.
				              (memory seedAt: anInteger1).
				              (memory seedAt: anInteger2).
				              hashInteger };
		              action: aRMDActionDefinitionNode;
		              object: anInteger2
		              definition: aRMDAnimatDefinitionNode2;
		              yourself.
	aRMDAnimatDefinitionNode1 isAnimatDefinitionNode ifTrue: [ 
		newContext
			location: [ self here ]
			definition: simulationModel patchDefinition ].
	aRMDAnimatDefinitionNode1 isPatchDefinitionNode ifTrue: [ 
		newContext
			location: anInteger1
			definition: simulationModel patchDefinition ].
	^ self withContext: newContext do: aBlock
]

{ #category : #'context controls' }
RMDInterpreter >> withActionContextWith: aRMDActionDefinitionNode subject: anInteger definition: aRMDAnimatDefinitionNode taskHash: anotherInteger do: aBlock [

	| newContext |
	newContext := (RMDActionContext
		               subject: anInteger
		               definition: aRMDAnimatDefinitionNode)
		              space: memory;
		              randomSeedWithHash: { 
				              self randomSeed.
				              memory time.
				              (memory seedAt: anInteger).
				              anotherInteger };
		              action: aRMDActionDefinitionNode;
		              yourself.
	aRMDAnimatDefinitionNode isAnimatDefinitionNode ifTrue: [ 
		newContext
			location: [ 
				memory
					patchAtXIndex: ((self patchX: (self my: 'x')) floor + 1
							 min: simulationModel patchXDivisions
							 max: 1)
					yIndex: ((self patchY: (self my: 'y')) floor + 1
							 min: simulationModel patchYDivisions
							 max: 1) ]
			definition: simulationModel patchDefinition ].
	aRMDAnimatDefinitionNode isPatchDefinitionNode ifTrue: [ 
		newContext
			location: anInteger
			definition: simulationModel patchDefinition ].
	^ self withContext: newContext do: aBlock
]

{ #category : #'context controls' }
RMDInterpreter >> withInitializerContextWithSubject: anInteger definition: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withContext: ((RMDInitializerContext
				    subject: anInteger
				    definition: aRMDAgentDefinitionNode)
				   randomSeedWithHash: { 
						   self randomSeed.
						   anInteger };
				   yourself)
		  do: aBlock
]

{ #category : #'context controls' }
RMDInterpreter >> withObserverContextWithSubject: anInteger definition: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withContext: (RMDObserverContext
				   subject: anInteger
				   definition: aRMDAgentDefinitionNode)
		  do: aBlock
]

{ #category : #'context controls' }
RMDInterpreter >> withObserverSubContextWithSubject: anInteger definition: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withSubContext: (RMDObserverContext
				   subject: anInteger
				   definition: aRMDAgentDefinitionNode)
		  do: aBlock
]

{ #category : #'context controls' }
RMDInterpreter >> withSubInitializerContextWithSubject: anInteger definition: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withSubContext: ((RMDInitializerContext
				    subject: anInteger
				    definition: aRMDAgentDefinitionNode)
				   randomSeedWithHash: { 
						   self randomSeed.
						   memory time.
						   (memory seedAt: anInteger) };
				   yourself)
		  do: aBlock
]

{ #category : #'space access' }
RMDInterpreter >> world [

	^ memory world
]

{ #category : #'variable access' }
RMDInterpreter >> worlds: aString [

	^ memory
		  at: self world
			  + (simulationModel worldDefinition offsetAt: aString ifAbsent: [
					   RMDUndefinedAttributeError signal:
						   (RMDAttributeVariableNode identifier: aString agent: nil) ])
		  ifAbsent: [
			  RMDAddressError signal:
				  (RMDAttributeVariableNode identifier: aString agent: nil) ]
]

{ #category : #'variable access' }
RMDInterpreter >> write: aFloat to: anInteger [

	^ memory at: anInteger put: aFloat
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toUtility: aString [

	^ context utilityAt: aString put: aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> writeDelta: aFloat to: anInteger [

	memory nextDeltaAt: anInteger add: aFloat.
	^ aFloat
]

{ #category : #'variable access' }
RMDInterpreter >> writeNext: aFloat to: anInteger [

	memory nextAt: anInteger put: aFloat.
	^ aFloat
]

{ #category : #'space access' }
RMDInterpreter >> xIndexOfPatch: anInteger [

	^ anInteger - memory patch // memory patchSize + 1
]

{ #category : #'space access' }
RMDInterpreter >> xPatchOf: anInteger [

	^ memory xPatchOf: anInteger
]

{ #category : #'space access' }
RMDInterpreter >> yIndexOfPatch: anInteger [

	^ anInteger - memory patch // memory patchSize \\ memory xPatches + 1
]

{ #category : #'space access' }
RMDInterpreter >> yPatchOf: anInteger [

	^ memory yPatchOf: anInteger
]
