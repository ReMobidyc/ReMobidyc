Class {
	#name : #RMDInterpreter,
	#superclass : #Object,
	#instVars : [
		'memory',
		'libraries',
		'context',
		'individualDirectory',
		'simulationModel'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #examples }
RMDInterpreter class >> exampleSugar [
	<script: 'RMDInterpreter exampleSugar'>
	| interpreter memory goat metabolism goats goatMetabolize |
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
	energy = uniform 5000 [kcal] to 20000 [kcal]
	basal_metabolism = 3000 [kcal/s].
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
	my sugar -> energy
	my basal_metabolism -> basal_metabolism.' trim
		asRMDBehaviorDefinition.
	interpreter load: goatMetabolize.
	goats := (1 to: 9)
		collect: [ :i | interpreter allocateAnimat: goat ].
	(goats collect: [ :animat | goat asDictionary: animat in: memory ])
		inspect.
	1000
		timesRepeat: [ goatMetabolize evalIn: interpreter.
			interpreter tick ].
	(goats collect: [ :animat | goat asDictionary: animat in: memory ])
		inspect
]

{ #category : #'library access' }
RMDInterpreter >> addLibraries: aCollectionOfDictionary [
	libraries addAll: aCollectionOfDictionary
]

{ #category : #'library access' }
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

{ #category : #'animat operations' }
RMDInterpreter >> animatDefinitionAt: aString ifAbsent: errorBlock [
	^ simulationModel
		ifNil: errorBlock
		ifNotNil: [ simulationModel animatDefinitionAt: aString ifAbsent: errorBlock ]
]

{ #category : #directives }
RMDInterpreter >> byChanceOf: aNumber [
	^ self random < aNumber
]

{ #category : #'animat operations' }
RMDInterpreter >> cellAtXIndex: anInteger yIndex: anotherInteger [
	^ ((anotherInteger - 1) * simulationModel cellXDivisions + anInteger - 1)
		* self cellDefinition totalNumberOfProperties
		+ individualDirectory cell
]

{ #category : #'animat operations' }
RMDInterpreter >> cellDefinition [
	^ simulationModel cellDefinition
]

{ #category : #'space access' }
RMDInterpreter >> cellLength [
	^ simulationModel cellLength
]

{ #category : #'space access' }
RMDInterpreter >> cellX: aNumber [
	^ (aNumber - self west) / simulationModel cellLength
]

{ #category : #'animat operations' }
RMDInterpreter >> cellXDivisions [
	^ simulationModel cellXDivisions
]

{ #category : #'space access' }
RMDInterpreter >> cellY: aNumber [
	^ (aNumber - self south) / simulationModel cellLength
]

{ #category : #'animat operations' }
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
RMDInterpreter >> directive: aString object: anotherString [
	aString = 'direction'
		ifTrue: [ ^ self direction: anotherString ].
	aString = 'distance'
		ifTrue: [ ^ self distance: anotherString ].
	aString = 'time'
		ifTrue: [ ^ self time ].
	aString = 'dtime'
		ifTrue: [ ^ self deltaTime ].
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

{ #category : #'library access' }
RMDInterpreter >> functionAt: aString ifAbsent: errorBlock [
	libraries
		do:
			[ :library | library at: aString ifPresent: [ :function | ^ function ] ].
	^ errorBlock value
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
	individualDirectory := RMDIndividualDirectory new
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

{ #category : #'loading definitions' }
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

{ #category : #'context controls' }
RMDInterpreter >> setActionContextWithIndividual: anInteger species: aRMDAnimatDefinitionNode [
	self
		setContext:
			(RMDActionContext subject: anInteger species: aRMDAnimatDefinitionNode)
]

{ #category : #private }
RMDInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : #'context controls' }
RMDInterpreter >> setInitializerContextWithSubject: anInteger species: aRMDSpeciesInitializerNode [
	self
		setContext:
			(RMDInitializerContext
				subject: anInteger
				species: aRMDSpeciesInitializerNode)
]

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [
	memory := aRMDMemory
]

{ #category : #'context controls' }
RMDInterpreter >> setObserverContextWithSubject: anInteger species: aRMDSpeciesInitializerNode [
	self
		setContext:
			(RMDObserverContext
				subject: anInteger
				species: aRMDSpeciesInitializerNode)
]

{ #category : #simulating }
RMDInterpreter >> setupSimulation [
	memory time: 1.
	individualDirectory
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
				setInitializerContextWithSubject: world
				species: simulationModel worldDefinition.
			simulationModel worldInitializer evalIn: self ].
	individualDirectory
		cellsDo: [ :cell | 
			self
				setInitializerContextWithSubject: cell
				species: simulationModel cellDefinition.
			simulationModel cellInitializer evalIn: self ].
	simulationModel
		animatInitializersDo: [ :initializer | 
			individualDirectory
				animatsOf: initializer animat
				do: [ :animat | 
					| species |
					species := simulationModel
						animatDefinitionAt: initializer animat
						ifAbsent: [ ^ KeyNotFound signal: initializer animat ].
					self setInitializerContextWithSubject: animat species: species.
					initializer evalIn: self ] ]
]

{ #category : #'space access' }
RMDInterpreter >> south [
	^ simulationModel south
]

{ #category : #'library access' }
RMDInterpreter >> standardLibrary [
	^ {('min' -> [ :a :b | a min: b ]).
	('max' -> [ :a :b | a max: b ]).
	('sin' -> [ :theta | theta sin ]).
	('cos' -> [ :theta | theta cos ]).
	('tan' -> [ :theta | theta tan ])} asDictionary
]

{ #category : #timing }
RMDInterpreter >> tick [
	memory tick
]

{ #category : #timing }
RMDInterpreter >> time [ 
	^ memory time * self deltaTime
]

{ #category : #'space access' }
RMDInterpreter >> west [
	^ simulationModel west
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
