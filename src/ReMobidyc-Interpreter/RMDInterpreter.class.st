Class {
	#name : #RMDInterpreter,
	#superclass : #RMDAbstractInterpreter,
	#instVars : [
		'memory',
		'libraries',
		'randomSeed'
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
	simulationModel
		animatDefinitionsDo: [ :animatDef | 
			| xOffset yOffset |
			xOffset := animatDef
				attributeOffsetAt: 'x'
				ifAbsent: [ ^ KeyNotFound signal: 'x' ].
			yOffset := animatDef
				attributeOffsetAt: 'y'
				ifAbsent: [ ^ KeyNotFound signal: 'y' ].
			memory
				animatsOf: animatDef identifier
				do: [ :individual | 
					| x y |
					x := memory at: individual + xOffset ifAbsent: [ nil ].
					x < simulationModel west
						ifTrue: [ memory at: individual + xOffset put: simulationModel west ].
					x > simulationModel east
						ifTrue: [ memory at: individual + xOffset put: simulationModel east ].
					y := memory at: individual + yOffset ifAbsent: [ nil ].
					y < simulationModel south
						ifTrue: [ memory at: individual + yOffset put: simulationModel south ].
					y > simulationModel north
						ifTrue: [ memory at: individual + yOffset put: simulationModel north ] ] ]
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
		                    ifAbsent: [ ^ KeyNotFound signal: animatString ].
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
		value := self
			         readVariable: attributeDecl identifier
			         agent: nil
			         ifAbsent: [ 0.0 ].
		memory nextAt: newIndividual + offset put: value.
		offset := offset + 1 ].
	memory removeAnimat: context subject.
	context subject
		to:
			context subject + context subjectDefinition totalNumberOfAttributes
			- 1
		do: [ :slot | memory nextAt: slot put: nil ].
	^ newIndividual
]

{ #category : #directives }
RMDInterpreter >> direction: aString [
	| x1 y1 x2 y2 |
	x1 := self
		readVariable: 'x'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	y1 := self
		readVariable: 'y'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	x2 := self
		readVariable: 'x'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	y2 := self
		readVariable: 'y'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	^ ((x2 - x1) @ (y2 - y1)) theta
]

{ #category : #directives }
RMDInterpreter >> directionOfGradient: aString [
	| here west east south north vector |
	here := self readVariable: aString agent: 'here' ifAbsent: [ 0 ].
	east := self readVariable: aString agent: 'east' ifAbsent: [ here ].
	west := self readVariable: aString agent: 'west' ifAbsent: [ here ].
	south := self readVariable: aString agent: 'south' ifAbsent: [ here ].
	north := self readVariable: aString agent: 'north' ifAbsent: [ here ].
	vector := (east - west) @ (north - south).
	(east <= here
		and: [ west <= here and: [ south <= here and: [ north <= here ] ] ])
		ifTrue: [ | x y patchX patchY |
			x := self readVariable: 'x' agent: nil ifAbsent: [ 0.0 ].
			y := self readVariable: 'y' agent: nil ifAbsent: [ 0.0 ].
			patchX := self patchLength * ((self patchX: x) + 0.5).
			patchY := self patchLength * ((self patchY: y) + 0.5).
			vector := (patchX - x) @ (patchY - y) ].
	^ vector theta
]

{ #category : #directives }
RMDInterpreter >> directive: aString object: anotherString [

	aString = 'directionOfGradient' ifTrue: [ 
		^ self directionOfGradient: anotherString ].
	aString = 'direction' ifTrue: [ ^ self direction: anotherString ].
	aString = 'distance' ifTrue: [ ^ self distance: anotherString ].
	aString = 'time' ifTrue: [ ^ self time ].
	aString = 'delta time' ifTrue: [ ^ self deltaTime ].
	aString = 'terminate' ifTrue: [ ^ self terminate: anotherString ].
	^ self unknownDirectiveError: aString
]

{ #category : #directives }
RMDInterpreter >> distance: aString [
	| x1 y1 x2 y2 |
	x1 := self
		readVariable: 'x'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	y1 := self
		readVariable: 'y'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	x2 := self
		readVariable: 'x'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	y2 := self
		readVariable: 'y'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	^ ((x1 - x2) squared + (y1 - y2) squared) sqrt
]

{ #category : #timing }
RMDInterpreter >> duration [
	^ simulationModel duration
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

{ #category : #'space access' }
RMDInterpreter >> here [

	| x y patchX patchY |
	x := self readVariable: 'x' agent: nil ifAbsent: [ ^ nil ].
	y := self readVariable: 'y' agent: nil ifAbsent: [ ^ nil ].
	patchX := (self patchX: x) floor + 1
		          min: 1
		          max: simulationModel patchXDivisions.
	patchY := (self patchY: y) floor + 1
		          min: 1
		          max: simulationModel patchYDivisions.
	^ memory patchAtXIndex: patchX yIndex: patchY
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
	randomSeed := 1
]

{ #category : #'variable access' }
RMDInterpreter >> initializeVariable: aString with: aNumber ifAbsent: errorBlock [
	^ memory
		at:
			(context
				getMemoryAddressFor: aString
				agent: nil
				ifAbsent: [ ^ errorBlock value ])
		put: aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> initializeVariableIfNotInitialized: aString with: aBlock ifAbsent: errorBlock [
	^ memory
		at:
			(context
				getMemoryAddressFor: aString
				agent: nil
				ifAbsent: [ ^ errorBlock value ])
		ifAbsentPut: aBlock
]

{ #category : #private }
RMDInterpreter >> memory [
	^ memory
]

{ #category : #'animat operations' }
RMDInterpreter >> newIndividual: animatString quantity: anInteger [

	| animatDefinition newIndividuals offset |
	animatDefinition := simulationModel
		                    animatDefinitionAt: animatString
		                    ifAbsent: [ ^ KeyNotFound signal: animatString ].
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
		value := self
			         readVariable: attributeDecl identifier
			         agent: nil
			         ifAbsent: [ 0.0 ].
		newIndividuals do: [ :individual | 
			memory nextAt: individual + offset put: value ].
		offset := offset + 1 ].

	^ newIndividuals
]

{ #category : #'random numbers' }
RMDInterpreter >> nextSeed [

	^ context nextSeed
]

{ #category : #'animat operations' }
RMDInterpreter >> numberOfIndivisualsOf: aRMDAgentDefinitionNode [

	aRMDAgentDefinitionNode isWorldDefinitionNode ifTrue: [ ^ 1 ].
	aRMDAgentDefinitionNode isPatchDefinitionNode ifTrue: [ 
		^ memory xPatches * memory yPatches ].
	^ memory numberOfAnimats: aRMDAgentDefinitionNode identifier
]

{ #category : #'space access' }
RMDInterpreter >> patchAtXIndex: anInteger yIndex: anotherInteger [
	^ memory patchAtXIndex: anInteger yIndex: anotherInteger
]

{ #category : #directives }
RMDInterpreter >> patchDirective: aString variable: aRMDAttributeVariableNode [

	aString = 'direction' ifTrue: [ 
		^ self directionOfGradient: aRMDAttributeVariableNode identifier ].
	^ self unknownDirectiveError: aString
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

{ #category : #'random numbers' }
RMDInterpreter >> randomSeed [
	^ randomSeed
]

{ #category : #'random numbers' }
RMDInterpreter >> randomSeed: anInteger [

	randomSeed := anInteger asInteger
]

{ #category : #'variable access' }
RMDInterpreter >> readUtility: aString ifAbsent: errorBlock [
	^ (context utilityAt: aString ifAbsent: errorBlock) evalIn: self
]

{ #category : #'variable access' }
RMDInterpreter >> readVariable: aString agent: anotherString ifAbsent: errorBlock [

	^ memory
		  at: (context
				   getMemoryAddressFor: aString
				   agent: anotherString
				   ifAbsent: [ ^ errorBlock value ])
		  ifAbsent: errorBlock
]

{ #category : #simulating }
RMDInterpreter >> removeOutOfBoundsAnimats [
	simulationModel
		animatDefinitionsDo: [ :animatDef | 
			| xOffset yOffset |
			xOffset := animatDef
				attributeOffsetAt: 'x'
				ifAbsent: [ ^ KeyNotFound signal: 'x' ].
			yOffset := animatDef
				attributeOffsetAt: 'y'
				ifAbsent: [ ^ KeyNotFound signal: 'y' ].
			memory
				animatsOf: animatDef identifier
				do: [ :individual | 
					| x y |
					x := memory at: individual + xOffset ifAbsent: [ nil ].
					y := memory at: individual + yOffset ifAbsent: [ nil ].
					((x between: simulationModel west and: simulationModel east)
						and: [ y between: simulationModel south and: simulationModel north ])
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

	context randomSeedWithAll: { 
			randomSeed.
			memory time.
			(memory seedAt: anInteger1).
			(memory seedAt: anInteger2).
			(self taskDefinitions indexOf: aRMDTaskDefinitionNode) }
]

{ #category : #'random numbers' }
RMDInterpreter >> setupRandomForIndividual: anInteger task: aRMDTaskDefinitionNode [

	context randomSeedWithAll: { 
			randomSeed.
			memory time.
			(memory seedAt: anInteger).
			(self taskDefinitions indexOf: aRMDTaskDefinitionNode) }
]

{ #category : #simulating }
RMDInterpreter >> setupSimulation [

	memory world ifNil: [ 
		memory
			initialize;
			allocateWorld: simulationModel worldDefinition;
			allocatePatches: simulationModel patchDefinition
			x: simulationModel patchXDivisions
			y: simulationModel patchYDivisions.
		memory worldDo: [ :world | 
			self
				withInitializerContextWithSubject: world
				agent: simulationModel worldDefinition
				do: [ 
					context randomSeedWithAll: { 
							randomSeed.
							memory time.
							world }.
					simulationModel worldInitializer evalIn: self ] ].
		memory patchesDo: [ :patch | 
			self
				withInitializerContextWithSubject: patch
				agent: simulationModel patchDefinition
				do: [ 
					context randomSeedWithAll: { 
							randomSeed.
							memory time.
							patch }.
					simulationModel patchInitializer evalIn: self ] ].
		simulationModel animatInitializersDo: [ :initializer | 
			| animatDefinition |
			animatDefinition := simulationModel
				                    animatDefinitionAt: initializer animat
				                    ifAbsent: [ 
				                    ^ KeyNotFound signal: initializer animat ].
			initializer population timesRepeat: [ 
				| animat |
				animat := memory allocateAnimat: animatDefinition.

				self
					withInitializerContextWithSubject: animat
					agent: animatDefinition
					do: [ 
						context randomSeedWithAll: { 
								randomSeed.
								memory time.
								animat }.
						initializer evalIn: self ] ] ] ].
	memory time: 0.
	self timeChanged
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

{ #category : #directives }
RMDInterpreter >> unknownDirectiveError: aString [

	^ self error: 'Unknown directive: ' , aString
]

{ #category : #'context controls' }
RMDInterpreter >> withActionContextWithIndividual: anInteger agent: aRMDAnimatDefinitionNode do: aBlock [

	^ self
		  withContext: (RMDActionContext
				   subject: anInteger
				   definition: aRMDAnimatDefinitionNode)
		  do: [ 
			  context
				  world: memory world
				  definition: simulationModel worldDefinition.
			  aRMDAnimatDefinitionNode isAnimatDefinitionNode ifTrue: [ 
				  | here |
				  here := memory
					          patchAtXIndex: ((self patchX: (self
								             readVariable: 'x'
								             agent: nil
								             ifAbsent: [ ^ KeyNotFound signal: 'x' ])) floor
						           + 1 min: simulationModel patchXDivisions max: 1)
					          yIndex: ((self patchY: (self
								             readVariable: 'y'
								             agent: nil
								             ifAbsent: [ ^ KeyNotFound signal: 'y' ])) floor
						           + 1 min: simulationModel patchYDivisions max: 1).
				  context
					  location: here
					  definition: simulationModel patchDefinition
					  agent: 'here'.
				  memory eastOf: here do: [ :east | 
					  context
						  location: east
						  definition: simulationModel patchDefinition
						  agent: 'east' ].
				  memory westOf: here do: [ :west | 
					  context
						  location: west
						  definition: simulationModel patchDefinition
						  agent: 'west' ].
				  memory southOf: here do: [ :south | 
					  context
						  location: south
						  definition: simulationModel patchDefinition
						  agent: 'south' ].
				  memory northOf: here do: [ :north | 
					  context
						  location: north
						  definition: simulationModel patchDefinition
						  agent: 'north' ] ].
			  aBlock cull: self cull: context ]
]

{ #category : #'context controls' }
RMDInterpreter >> withActionContextWithIndividual: anInteger1 agent: aRMDAnimatDefinitionNode1 object: anInteger2 agent: aRMDAnimatDefinitionNode2 do: aBlock [

	^ self
		  withContext: (RMDActionContext
				   subject: anInteger1
				   definition: aRMDAnimatDefinitionNode1)
		  do: [ 
			  context
				  world: memory world
				  definition: simulationModel worldDefinition.
			  context
				  object: anInteger2
				  definition: aRMDAnimatDefinitionNode2.
			  aRMDAnimatDefinitionNode1 isAnimatDefinitionNode ifTrue: [ 
				  | here |
				  here := memory
					          patchAtXIndex: ((self patchX: (self
								             readVariable: 'x'
								             agent: nil
								             ifAbsent: [ ^ KeyNotFound signal: 'x' ])) floor
						           + 1 min: simulationModel patchXDivisions max: 1)
					          yIndex: ((self patchY: (self
								             readVariable: 'y'
								             agent: nil
								             ifAbsent: [ ^ KeyNotFound signal: 'y' ])) floor
						           + 1 min: simulationModel patchYDivisions max: 1).
				  context
					  location: here
					  definition: simulationModel patchDefinition
					  agent: 'here'.
				  memory eastOf: here do: [ :east | 
					  context
						  location: east
						  definition: simulationModel patchDefinition
						  agent: 'east' ].
				  memory westOf: here do: [ :west | 
					  context
						  location: west
						  definition: simulationModel patchDefinition
						  agent: 'west' ].
				  memory southOf: here do: [ :south | 
					  context
						  location: south
						  definition: simulationModel patchDefinition
						  agent: 'south' ].
				  memory northOf: here do: [ :north | 
					  context
						  location: north
						  definition: simulationModel patchDefinition
						  agent: 'north' ] ].
			  aBlock cull: self cull: context ]
]

{ #category : #'context controls' }
RMDInterpreter >> withInitializerContextWithSubject: anInteger agent: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withContext: (RMDInitializerContext
				   subject: anInteger
				   definition: aRMDAgentDefinitionNode)
		  do: aBlock
]

{ #category : #'context controls' }
RMDInterpreter >> withObserverContextWithSubject: anInteger agent: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withContext: (RMDObserverContext
				   subject: anInteger
				   definition: aRMDAgentDefinitionNode)
		  do: aBlock
]

{ #category : #'space access' }
RMDInterpreter >> world [

	^ memory world
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toDelta: aString agent: anotherString ifAbsent: errorBlock [

	memory
		nextDeltaAt: (context
				 getMemoryAddressFor: aString
				 agent: anotherString
				 ifAbsent: [ ^ errorBlock value ])
		add: aNumber.
	^ aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toDifferential: aString agent: anotherString ifAbsent: errorBlock [

	memory
		nextDeltaAt: (context
				 getMemoryAddressFor: aString
				 agent: anotherString
				 ifAbsent: [ ^ errorBlock value ])
		add: aNumber * self deltaTime.
	^ aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toUtility: aString [

	^ context utilityAt: aString put: aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toVariable: aString agent: anotherString ifAbsent: errorBlock [

	^ memory
		  nextAt: (context
				   getMemoryAddressFor: aString
				   agent: anotherString
				   ifAbsent: [ ^ errorBlock value ])
		  put: aNumber
]
