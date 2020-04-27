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

{ #category : #'space access' }
RMDInterpreter >> cellAtXIndex: anInteger yIndex: anotherInteger [
	^ individualDirectory cellAtXIndex: anInteger yIndex: anotherInteger
]

{ #category : #'space access' }
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
	here := west := east := south := north := context location.
	individualDirectory westOf: here do: [ :cell | west := cell ].
	individualDirectory eastOf: here do: [ :cell | east := cell ].
	individualDirectory southOf: here do: [ :cell | south := cell ].
	individualDirectory northOf: here do: [ :cell | north := cell ].
	vector := ((self readVariable: aString agent: east ifAbsent: [ 0 ])
		- (self readVariable: aString agent: west ifAbsent: [ 0 ]))
		@
			((self readVariable: aString agent: north ifAbsent: [ 0 ])
				- (self readVariable: aString agent: south ifAbsent: [ 0 ])).
	^ vector theta
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

{ #category : #'library access' }
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

{ #category : #simulating }
RMDInterpreter >> removeOutOfBoundsAnimats [
	individualDirectory
		animatNamesDo: [ :animatName | 
			| animatDef xOffset yOffset |
			animatDef := simulationModel
				animatDefinitionAt: animatName
				ifAbsent: [ ^ NotFoundError signal: animatName ].
			xOffset := animatDef
				propertyOffsetAt: 'x'
				ifAbsent: [ ^ NotFoundError signal: 'x' ].
			yOffset := animatDef
				propertyOffsetAt: 'y'
				ifAbsent: [ ^ NotFoundError signal: 'y' ].
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

{ #category : #'context controls' }
RMDInterpreter >> setActionContextWithIndividual: anInteger species: aRMDAnimatDefinitionNode [
	self
		setContext:
			(RMDActionContext subject: anInteger definition: aRMDAnimatDefinitionNode).
	aRMDAnimatDefinitionNode isAnimatDefinitionNode
		ifTrue: [ context
				location:
					(individualDirectory
						cellAtXIndex:
							((self
								cellX:
									(self
										readVariable: 'x'
										agent: nil
										ifAbsent: [ ^ KeyNotFound signal: 'x' ])) floor + 1
								min: 1
								max: simulationModel cellXDivisions)
						yIndex:
							((self
								cellY:
									(self
										readVariable: 'y'
										agent: nil
										ifAbsent: [ ^ KeyNotFound signal: 'y' ])) floor + 1
								min: 1
								max: simulationModel cellYDivisions))
				definition: simulationModel cellDefinition ]
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
				definition: aRMDSpeciesInitializerNode)
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
				definition: aRMDSpeciesInitializerNode)
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
	^ {('min' -> RMDFunction min).
	('max' -> RMDFunction max).
	('mean' -> RMDFunction mean).
	('sum' -> RMDFunction sum).
	('sin' -> RMDFunction sin).
	('cos' -> RMDFunction cos).
	('exp' -> RMDFunction exp).
	('abs' -> RMDFunction abs).
	('squareRoot' -> RMDFunction squareRoot)} asDictionary
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
