Class {
	#name : #RMDInterpreter,
	#superclass : #RMDAbstractInterpreter,
	#instVars : [
		'memory',
		'libraries',
		'globalSeed',
		'worldAttributeDict'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #examples }
RMDInterpreter class >> exampleSugar [
	<script: 'RMDInterpreter exampleSugar'>
	| interpreter memory goat metabolism  goatMetabolize simulation |
	interpreter := RMDInterpreter new.
	memory := RMDFileMemory
		on:
			((FileLocator documents / 'ReMobidyc' / 'sugar')
				ensureCreateDirectory;
				deleteAllChildren;
				yourself).
	memory digitsForTime: 5.
	interpreter setMemory: memory.
	goat := '
Goat is Animat with
	energy [kcal]
	basal_metabolism [kcal/s].
' trim asRMDAnimatDefinition.
	interpreter load: goat.
	metabolism := '
to metabolize is
when my sugar >= 0
	my delta sugar'' = - my basal_metabolism.
' trim asRMDActionDefinition.
	interpreter load: metabolism.
	goatMetabolize := '
Goat metabolize@model where
	my sugar -> my energy
	my basal_metabolism -> my basal_metabolism.' trim
		asRMDTaskDefinition.
	interpreter load: goatMetabolize.
	simulation := '
Simulation with
	during 1000 [day] by 1[day]
	1x1 of 1[m] Patch
	9 Goat with
		energy = uniform 5000 [kcal] to 20000 [kcal]
		basal_metabolism = 3000 [kcal/s].
' trim asRMDSimulationDefinition.
	interpreter load: simulation.
	interpreter setupSimulation.
	(Array
		streamContents: [ :stream | 
			interpreter
				individualsOf: goat
				do: [ :g | stream nextPut: (goat asDictionary: g in: memory) ] ])
		inspect.
	1000 timesRepeat: [ interpreter stepSimulation ].
	(Array
		streamContents: [ :stream | 
			interpreter
				individualsOf: goat
				do: [ :g | stream nextPut: (goat asDictionary: g in: memory) ] ])
		inspect
]

{ #category : #examples }
RMDInterpreter class >> sugarScape [
	<script: 'RMDInterpreter sugarScape inspect'>
	| interpreter |
	interpreter := self new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		simulationModel: RMDSimulationModel sugarScape;
		yourself.
	interpreter setupSimulation.
	^ interpreter
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> addLibraries: aCollectionOfDictionary [
	libraries addAll: aCollectionOfDictionary
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> addLibrary: aDictionary [
	libraries add: aDictionary
]

{ #category : #simulating }
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
			| x y |
			x := memory at: individual + xOffset ifAbsent: [ nil ].
			x < simulationModel west ifTrue: [ 
				memory at: individual + xOffset put: simulationModel west ].
			x > simulationModel east ifTrue: [ 
				memory at: individual + xOffset put: simulationModel east ].
			y := memory at: individual + yOffset ifAbsent: [ nil ].
			y < simulationModel south ifTrue: [ 
				memory at: individual + yOffset put: simulationModel south ].
			y > simulationModel north ifTrue: [ 
				memory at: individual + yOffset put: simulationModel north ] ] ]
]

{ #category : #directives }
RMDInterpreter >> byChanceOf: aNumber [
	^ self random < aNumber
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
		visualizer := RMDVisualizer extent: 500@500.
		self simulationModel renderersDo: [ :renderer | 
			visualizer addRenderer: renderer ].
		[ 
		UIManager default
			displayProgress: 'exporting animated png'
			from: 0.0
			to: self duration
			during: [ :progress | 
				[ self time < self duration ] whileTrue: [ 
					writer nextPutImage: ((visualizer visualize: self) scaledToSize: aPoint).
					self performTasks.
					self tick.
					self bounceOutOfBoundsAnimats.
					progress value: self time ] ].
		writer nextPutImage: (visualizer visualize: self) ] ensure: [ 
			writer close ] ] ] ensure: [ self time: oldTime ]
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> functionAt: aString ifAbsent: errorBlock [
	libraries
		do:
			[ :library | library at: aString ifPresent: [ :function | ^ function ] ].
	^ errorBlock value
]

{ #category : #'random numbers' }
RMDInterpreter >> globalSeed [
	^ globalSeed
]

{ #category : #'random numbers' }
RMDInterpreter >> globalSeed: anInteger [

	globalSeed := anInteger asInteger
]

{ #category : #'space access' }
RMDInterpreter >> here [

	| patchX patchY |
	patchX := (self patchX: (self my: 'x')) floor + 1
		          min: 1
		          max: simulationModel patchXDivisions.
	patchY := (self patchY: (self my: 'y')) floor + 1
		          min: 1
		          max: simulationModel patchYDivisions.
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
	libraries := OrderedCollection with: self standardLibrary.
	globalSeed := 1
]

{ #category : #private }
RMDInterpreter >> memory [
	^ memory
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

{ #category : #'animat operations' }
RMDInterpreter >> numberOfIndivisualsOf: aRMDAgentDefinitionNode [

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

{ #category : #'space access' }
RMDInterpreter >> patchAtXIndex: anInteger yIndex: anotherInteger [
	^ memory patchAtXIndex: anInteger yIndex: anotherInteger
]

{ #category : #'space access' }
RMDInterpreter >> patchesDo: aBlock [

	memory patchesDo: aBlock
]

{ #category : #simulating }
RMDInterpreter >> performTasks [
	simulationModel tasksDo: [ :task | task evalIn: self ]
]

{ #category : #'random numbers' }
RMDInterpreter >> random [

	^ context random
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

{ #category : #simulating }
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

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [
	memory := aRMDMemory
]

{ #category : #'random numbers' }
RMDInterpreter >> setupRandomForIndividual: anInteger1 and: anInteger2 task: aRMDTaskDefinitionNode [

	context randomSeedWithHash: { 
			globalSeed.
			memory time.
			(memory seedAt: anInteger1).
			(memory seedAt: anInteger2).
			(self taskDefinitions indexOf: aRMDTaskDefinitionNode) }
]

{ #category : #'random numbers' }
RMDInterpreter >> setupRandomForIndividual: anInteger task: aRMDTaskDefinitionNode [

	context randomSeedWithHash: { 
			globalSeed.
			memory time.
			(memory seedAt: anInteger).
			(self taskDefinitions indexOf: aRMDTaskDefinitionNode) }
]

{ #category : #simulating }
RMDInterpreter >> setupSimulation [

	memory world ifNil: [ 
		memory initialize.
		simulationModel worldInitializer evalIn: self.
		simulationModel patchInitializer evalIn: self.
		simulationModel animatInitializersDo: [ :initializer | 
			initializer evalIn: self ] ].
	memory time: 0.
	self timeChanged
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
	^ self time < simulationModel duration
		and: [ memory time + 1 <= memory latestTime
				ifTrue: [ memory time: memory time + 1 ]
				ifFalse: [ self performTasks.
					self tick.
					self bounceOutOfBoundsAnimats ].
			self timeChanged.
			true ]
]

{ #category : #'animat operations' }
RMDInterpreter >> terminate: aString [
	aString
		ifNil:
			[ ^ self terminate: context subject animat: context subjectDefinition ].
	^ self terminate: context object animat: context objectDefinition
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
		ifTrue: [ Cursor wait
				showWhile: [ memory time: lastTime.
					[ memory time < newTime ]
						whileTrue: [ self performTasks.
							self tick.
							self bounceOutOfBoundsAnimats ] ] ]
		ifFalse: [ memory time: newTime ].
	self timeChanged
]

{ #category : #simulating }
RMDInterpreter >> timeChanged [
	self announcer announce: (RMDTimeChanged time: self time)
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
				              globalSeed.
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
				              globalSeed.
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
						   globalSeed.
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
RMDInterpreter >> withSubInitializerContextWithSubject: anInteger definition: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withSubContext: ((RMDInitializerContext
				    subject: anInteger
				    definition: aRMDAgentDefinitionNode)
				   randomSeedWithHash: { 
						   globalSeed.
						   memory time.
						   (memory seedAt: anInteger) };
				   yourself)
		  do: aBlock
]

{ #category : #'space access' }
RMDInterpreter >> world [

	^ memory world
]

{ #category : #private }
RMDInterpreter >> worldAttributeDict [

	^ worldAttributeDict ifNil: [ 
		  | def baseAddress dict |
		  def := simulationModel worldDefinition.
		  baseAddress := memory world.
		  dict := Dictionary new: def totalNumberOfAttributes + 2.
		  def attributeOffsets keysAndValuesDo: [ :ident :offset | 
			  dict at: ident put: baseAddress + offset ].
		  worldAttributeDict := dict ]
]

{ #category : #'variable access' }
RMDInterpreter >> worlds: aString [

	^ memory
		  at: context world
			  + (context worldDefinition offsetAt: aString ifAbsent: [ 
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
