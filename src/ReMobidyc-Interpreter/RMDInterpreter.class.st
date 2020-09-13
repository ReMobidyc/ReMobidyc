Class {
	#name : #RMDInterpreter,
	#superclass : #Model,
	#instVars : [
		'memory',
		'libraries',
		'context',
		'contextSemaphore',
		'individualDirectory',
		'simulationModel'
	],
	#classInstVars : [
		'standardLibrary'
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
presume my sugar >= 0
	my delta sugar'' = - my basal_metabolism.
' trim asRMDActionDefinition.
	interpreter load: metabolism.
	goatMetabolize := '
Goat metabolize where
	my sugar -> my energy
	my basal_metabolism -> my basal_metabolism.' trim
		asRMDBehaviorDefinition.
	interpreter load: goatMetabolize.
	simulation := '
Simulation with
	during 1000 [day] by 1[day]
	1x1 of 1[m] Cell
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

{ #category : #'library access' }
RMDInterpreter class >> standardLibrary [
	^ standardLibrary
		ifNil: [ standardLibrary := {('min' -> RMDFunction min).
			('max' -> RMDFunction max).
			('mean' -> RMDFunction mean).
			('sum' -> RMDFunction sum).
			('sin' -> RMDFunction sin).
			('cos' -> RMDFunction cos).
			('exp' -> RMDFunction exp).
			('log' -> RMDFunction log).
			('ln' -> RMDFunction ln).
			('abs' -> RMDFunction abs).
			('squareRoot' -> RMDFunction squareRoot)} asDictionary ]
]

{ #category : #examples }
RMDInterpreter class >> sugarScape [
	| interpreter |
	interpreter := self new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		simulationModel: RMDSimulationModel sugarScape;
		yourself.
	interpreter setupSimulation.
	^ interpreter
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> actionDefinitionAt: aString ifAbsent: errorBlock [
	^ simulationModel
		ifNil: errorBlock
		ifNotNil: [ simulationModel actionDefinitionAt: aString ifAbsent: errorBlock ]
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> actionIdentifiers [
	^ self actionNames
		collect: [ :actionName | RMDLocalActionIdentifierNode identifier: actionName ]
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> actionNames [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #actionNames
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> addActionDefinition: aRMDActionDefinitionNode [
	^ simulationModel
		ifNotNil: [ simulationModel addActionDefinition: aRMDActionDefinitionNode ]
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> addLibraries: aCollectionOfDictionary [
	libraries addAll: aCollectionOfDictionary
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> addLibrary: aDictionary [
	libraries add: aDictionary
]

{ #category : #'animat operations' }
RMDInterpreter >> allocateAnimat: aRMDAnimatDefinitionNode [
	^ individualDirectory allocateAnimat: aRMDAnimatDefinitionNode
]

{ #category : #'animat operations' }
RMDInterpreter >> allocateCells: aRMDCellDefinitionNode x: anInteger1 y: anInteger2 [
	^ individualDirectory
		allocateCells: aRMDCellDefinitionNode
		x: anInteger1
		y: anInteger2
]

{ #category : #'animat operations' }
RMDInterpreter >> allocateWorld: aRMDWorldDefinitionNode [
	^ individualDirectory allocateWorld: aRMDWorldDefinitionNode
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> animatDefinitionAt: aString ifAbsent: errorBlock [
	^ simulationModel
		ifNil: errorBlock
		ifNotNil: [ simulationModel animatDefinitionAt: aString ifAbsent: errorBlock ]
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> animatNames [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #animatNames
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> behaviorDefinitions [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #behaviorDefinitions
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> behaviorNames [
	^ simulationModel ifNil: [ Array new ] ifNotNil: #behaviorNames
]

{ #category : #simulating }
RMDInterpreter >> bounceOutOfBoundsAnimats [
	individualDirectory
		animatNamesDo: [ :animatName | 
			| animatDef xOffset yOffset |
			animatDef := simulationModel
				animatDefinitionAt: animatName
				ifAbsent: [ ^ LibrarySymbolNotFoundError signal: animatName ].
			xOffset := animatDef
				propertyOffsetAt: 'x'
				ifAbsent: [ ^ LibrarySymbolNotFoundError signal: 'x' ].
			yOffset := animatDef
				propertyOffsetAt: 'y'
				ifAbsent: [ ^ LibrarySymbolNotFoundError signal: 'y' ].
			individualDirectory
				animatsOf: animatName
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

{ #category : #'space access' }
RMDInterpreter >> cellAtXIndex: anInteger yIndex: anotherInteger [
	^ individualDirectory cellAtXIndex: anInteger yIndex: anotherInteger
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> cellDefinition [
	^ simulationModel cellDefinition
]

{ #category : #directives }
RMDInterpreter >> cellDirective: aString variable: aRMDPropertyVariableNode [
	aString = 'direction'
		ifTrue: [ ^ self directionOfGradient: aRMDPropertyVariableNode identifier ].
	^ self error: 'Unknown directive: ' , aString
]

{ #category : #'space access' }
RMDInterpreter >> cellLength [
	^ simulationModel cellLength
]

{ #category : #'space access' }
RMDInterpreter >> cellX: aNumber [
	^ (aNumber - self west) / simulationModel cellLength
]

{ #category : #'space access' }
RMDInterpreter >> cellXDivisions [
	^ simulationModel cellXDivisions
]

{ #category : #'space access' }
RMDInterpreter >> cellY: aNumber [
	^ (aNumber - self south) / simulationModel cellLength
]

{ #category : #'space access' }
RMDInterpreter >> cellYDivisions [
	^ simulationModel cellYDivisions
]

{ #category : #private }
RMDInterpreter >> context [
	^ context
]

{ #category : #timing }
RMDInterpreter >> deltaTime [
	^ simulationModel deltaTime
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
		ifTrue: [ | x y cellX cellY |
			x := self readVariable: 'x' agent: nil ifAbsent: [ 0.0 ].
			y := self readVariable: 'y' agent: nil ifAbsent: [ 0.0 ].
			cellX := self cellLength * ((self cellX: x) + 0.5).
			cellY := self cellLength * ((self cellY: y) + 0.5).
			vector := (cellX - x) @ (cellY - y) ].
	^ vector theta
]

{ #category : #directives }
RMDInterpreter >> directive: aString object: anotherString [
	aString = 'directionOfGradient'
		ifTrue: [ ^ self directionOfGradient: anotherString ].
	aString = 'direction'
		ifTrue: [ ^ self direction: anotherString ].
	aString = 'distance'
		ifTrue: [ ^ self distance: anotherString ].
	aString = 'time'
		ifTrue: [ ^ self time ].
	aString = 'delta time'
		ifTrue: [ ^ self deltaTime ].
	aString = 'terminate'
		ifTrue: [ ^ self terminate: anotherString ].
	^ self error: 'Unknown directive: ' , aString
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

{ #category : #'space access' }
RMDInterpreter >> east [
	^ simulationModel east
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
	| x y cellX cellY |
	x := self readVariable: 'x' agent: nil ifAbsent: [ ^ nil ].
	y := self readVariable: 'y' agent: nil ifAbsent: [ ^ nil ].
	cellX := (self cellX: x) floor + 1
		min: 1
		max: simulationModel cellXDivisions.
	cellY := (self cellY: y) floor + 1
		min: 1
		max: simulationModel cellYDivisions.
	^ individualDirectory cellAtXIndex: cellX yIndex: cellY
]

{ #category : #'animat operations' }
RMDInterpreter >> individualsOf: aRMDSpeciesDefinitionNode do: aBlock [
	aRMDSpeciesDefinitionNode isAnimatDefinitionNode
		ifTrue: [ individualDirectory
				animatsOf: aRMDSpeciesDefinitionNode identifier
				do: aBlock.
			^ self ].
	aRMDSpeciesDefinitionNode isCellDefinitionNode
		ifTrue: [ individualDirectory cellsDo: aBlock.
			^ self ].
	aRMDSpeciesDefinitionNode isWorldDefinitionNode
		ifTrue: [ individualDirectory worldDo: aBlock.
			^ self ].
	^ self error: 'Unknown species type'
]

{ #category : #initialization }
RMDInterpreter >> initialize [
	super initialize.
	simulationModel := RMDSimulationModel new.
	libraries := OrderedCollection with: self standardLibrary.
	individualDirectory := RMDIndividualDirectory new.
	contextSemaphore := Semaphore forMutualExclusion
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

{ #category : #'accessing - definitions' }
RMDInterpreter >> load: aRMDSyntaxNode [
	simulationModel load: aRMDSyntaxNode
]

{ #category : #private }
RMDInterpreter >> memory [
	^ memory
]

{ #category : #'space access' }
RMDInterpreter >> north [
	^ simulationModel north
]

{ #category : #simulating }
RMDInterpreter >> performBehaviors [
	simulationModel behaviorsDo: [ :behavior | behavior evalIn: self ]
]

{ #category : #private }
RMDInterpreter >> random [
	^ SharedRandom globalGenerator next
]

{ #category : #'variable access' }
RMDInterpreter >> readUtility: aString ifAbsent: errorBlock [
	^ (context utilityAt: aString ifAbsent: errorBlock) evalIn: self
]

{ #category : #'variable access' }
RMDInterpreter >> readVariable: aString agent: anotherString ifAbsent: errorBlock [
	^ memory
		at:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: errorBlock
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> removeBehaviorDefinition: aRMDBehaviorDefinitionNode ifAbsent: errorBlock [
	^ simulationModel
		ifNil: errorBlock
		ifNotNil: [ simulationModel
				removeBehaviorDefinition: aRMDBehaviorDefinitionNode
				ifAbsent: errorBlock ]
]

{ #category : #simulating }
RMDInterpreter >> removeOutOfBoundsAnimats [
	individualDirectory
		animatNamesDo: [ :animatName | 
			| animatDef xOffset yOffset |
			animatDef := simulationModel
				animatDefinitionAt: animatName
				ifAbsent: [ ^ LibrarySymbolNotFoundError signal: animatName ].
			xOffset := animatDef
				propertyOffsetAt: 'x'
				ifAbsent: [ ^ LibrarySymbolNotFoundError signal: 'x' ].
			yOffset := animatDef
				propertyOffsetAt: 'y'
				ifAbsent: [ ^ LibrarySymbolNotFoundError signal: 'y' ].
			individualDirectory
				animatsOf: animatName
				do: [ :individual | 
					| x y |
					x := memory at: individual + xOffset ifAbsent: [ nil ].
					y := memory at: individual + yOffset ifAbsent: [ nil ].
					((x between: simulationModel west and: simulationModel east)
						and: [ y between: simulationModel south and: simulationModel north ])
						ifFalse: [ self terminate: individual animat: animatDef ] ] ]
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> replaceBehavior: aRMDBehaviorDefinitionNode with: anotherRMDBehaviorDefinitionNode [
	^ simulationModel
		ifNotNil: [ simulationModel
				replaceBehavior: aRMDBehaviorDefinitionNode
				with: anotherRMDBehaviorDefinitionNode ]
]

{ #category : #'accessing - repository' }
RMDInterpreter >> repositoryName [
	^ 'local'
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> resetBehaviors [
	simulationModel behaviorsDo: [ :behavior | behavior resetAction ]
]

{ #category : #private }
RMDInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [
	memory := aRMDMemory
]

{ #category : #simulating }
RMDInterpreter >> setupSimulation [
	memory time: 0.
	individualDirectory
		initialize;
		allocateWorld: simulationModel worldDefinition;
		allocateCells: simulationModel cellDefinition
			x: simulationModel cellXDivisions
			y: simulationModel cellYDivisions.
	simulationModel
		animatInitializersDo: [ :initializer | 
			initializer population
				timesRepeat: [ individualDirectory
						allocateAnimat:
							(simulationModel
								animatDefinitionAt: initializer animat
								ifAbsent: [ ^ KeyNotFound signal: initializer animat ]) ] ].
	individualDirectory
		worldDo: [ :world | 
			self
				withInitializerContextWithSubject: world
				species: simulationModel worldDefinition
				do: [ simulationModel worldInitializer evalIn: self ] ].
	individualDirectory
		cellsDo: [ :cell | 
			self
				withInitializerContextWithSubject: cell
				species: simulationModel cellDefinition
				do: [ simulationModel cellInitializer evalIn: self ] ].
	simulationModel
		animatInitializersDo: [ :initializer | 
			individualDirectory
				animatsOf: initializer animat
				do: [ :animat | 
					| species |
					species := simulationModel
						animatDefinitionAt: initializer animat
						ifAbsent: [ ^ KeyNotFound signal: initializer animat ].
					self
						withInitializerContextWithSubject: animat
						species: species
						do: [ initializer evalIn: self ] ] ].
	self timeChanged
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> simulationDefinition [
	^ simulationModel simulationDefinition
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> simulationModel [
	^ simulationModel
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel
]

{ #category : #'space access' }
RMDInterpreter >> south [
	^ simulationModel south
]

{ #category : #'accessing - libraries' }
RMDInterpreter >> standardLibrary [
	^ self class standardLibrary 
]

{ #category : #simulating }
RMDInterpreter >> stepSimulation [
	^ self time < simulationModel duration
		and: [ self performBehaviors.
			self tick.
			self bounceOutOfBoundsAnimats.
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
	individualDirectory
		remove: anInteger
		animat: aRMDAnimatDefinitionNode
		ifAbsent: [ ^ NotFound
				signal:
					{aRMDAnimatDefinitionNode.
					anInteger} ].
	anInteger to: anInteger + aRMDAnimatDefinitionNode totalNumberOfProperties - 1
	do: [ :slot | memory nextAt: slot put: nil ]
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
	memory time: aNumber // self deltaTime
]

{ #category : #simulating }
RMDInterpreter >> timeChanged [
	self announcer announce: (RMDTimeChanged time: self time)
]

{ #category : #'space access' }
RMDInterpreter >> west [
	^ simulationModel west
]

{ #category : #'context controls' }
RMDInterpreter >> withActionContextWithIndividual: anInteger species: aRMDAnimatDefinitionNode do: aBlock [
	^ contextSemaphore
		critical: [ | originalContext |
			originalContext := context.
			self
				setContext:
					(RMDActionContext
						subject: anInteger
						definition: aRMDAnimatDefinitionNode).
			aRMDAnimatDefinitionNode isAnimatDefinitionNode
				ifTrue: [ | here |
					here := individualDirectory
						cellAtXIndex:
							((self
								cellX:
									(self
										readVariable: 'x'
										agent: nil
										ifAbsent: [ ^ KeyNotFound signal: 'x' ])) floor + 1
								min: simulationModel cellXDivisions
								max: 1)
						yIndex:
							((self
								cellY:
									(self
										readVariable: 'y'
										agent: nil
										ifAbsent: [ ^ KeyNotFound signal: 'y' ])) floor + 1
								min: simulationModel cellYDivisions
								max: 1).
					context
						location: here
						definition: simulationModel cellDefinition
						agent: 'here'.
					individualDirectory
						eastOf: here
						do: [ :east | 
							context
								location: east
								definition: simulationModel cellDefinition
								agent: 'east' ].
					individualDirectory
						westOf: here
						do: [ :west | 
							context
								location: west
								definition: simulationModel cellDefinition
								agent: 'west' ].
					individualDirectory
						southOf: here
						do: [ :south | 
							context
								location: south
								definition: simulationModel cellDefinition
								agent: 'south' ].
					individualDirectory
						northOf: here
						do: [ :north | 
							context
								location: north
								definition: simulationModel cellDefinition
								agent: 'north' ] ].
			[ aBlock cull: self cull: context ]
				ensure: [ context := originalContext ] ]
]

{ #category : #'context controls' }
RMDInterpreter >> withInitializerContextWithSubject: anInteger species: aRMDSpeciesInitializerNode do: aBlock [
	^ contextSemaphore
		critical: [ | originalContext |
			originalContext := context.
			self
				setContext:
					(RMDInitializerContext
						subject: anInteger
						definition: aRMDSpeciesInitializerNode).
			[ aBlock cull: self cull: context ]
				ensure: [ context := originalContext ] ]
]

{ #category : #'context controls' }
RMDInterpreter >> withObserverContextWithSubject: anInteger species: aRMDSpeciesInitializerNode do: aBlock [
	^ contextSemaphore
		critical: [ | originalContext |
			originalContext := context.
			self
				setContext:
					(RMDObserverContext
						subject: anInteger
						definition: aRMDSpeciesInitializerNode).
			[ aBlock cull: self cull: context ]
				ensure: [ context := originalContext ] ]
]

{ #category : #'accessing - definitions' }
RMDInterpreter >> worldDefinition [
	^ simulationModel worldDefinition
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toDelta: aString agent: anotherString ifAbsent: errorBlock [
	memory
		nextDeltaAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		add: aNumber.
	^ aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toDifferential: aString agent: anotherString ifAbsent: errorBlock [
	memory
		nextDeltaAt:
			(context
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
		nextAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		put: aNumber
]
