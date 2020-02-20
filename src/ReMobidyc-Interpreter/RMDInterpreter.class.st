Class {
	#name : #RMDInterpreter,
	#superclass : #Object,
	#instVars : [
		'memory',
		'libraries',
		'deltaTime',
		'context',
		'simulationDefinition',
		'animatDefinitions',
		'cellDefinition',
		'worldDefinition',
		'actionDefinitions',
		'behaviorDefinitions'
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
		collect: [ :i | interpreter allocateIndividualOf: goat ].
	(goats collect: [ :animat | goat asDictionary: animat in: memory ])
		inspect.
	1000
		timesRepeat: [ goatMetabolize evalIn: interpreter.
			interpreter tick ].
	(goats collect: [ :animat | goat asDictionary: animat in: memory ])
		inspect
]

{ #category : #'definition access' }
RMDInterpreter >> actionDefinitionAt: aString ifAbsent: errorBlock [
	^ actionDefinitions at: aString ifAbsent: errorBlock
]

{ #category : #'definition access' }
RMDInterpreter >> addBehaviorDefinition: aRMDBehaviorDefinitionNode [
	^ behaviorDefinitions add: aRMDBehaviorDefinitionNode
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
RMDInterpreter >> allocateIndividualOf: aRMDAnimatDefinition [
	| animat |
	animat := memory allocateIndividualOf: aRMDAnimatDefinition.
	self initializeAnimat: animat species: aRMDAnimatDefinition.
	^ animat
]

{ #category : #'definition access' }
RMDInterpreter >> animatDefinitionAt: aString ifAbsent: errorBlock [
	^ animatDefinitions at: aString ifAbsent: errorBlock
]

{ #category : #directives }
RMDInterpreter >> byChanceOf: aNumber [
	^ self random < aNumber
]

{ #category : #private }
RMDInterpreter >> context [
	^ context
]

{ #category : #timing }
RMDInterpreter >> deltaTime [
	^ deltaTime
		ifNil: [ deltaTime := simulationDefinition timeDefinition step numeric ]
]

{ #category : #timing }
RMDInterpreter >> deltaTime: aNumber [
	deltaTime := aNumber
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

{ #category : #'library access' }
RMDInterpreter >> functionAt: aString ifAbsent: errorBlock [
	libraries
		do:
			[ :library | library at: aString ifPresent: [ :function | ^ function ] ].
	^ errorBlock value
]

{ #category : #'animat operations' }
RMDInterpreter >> individualsOf: aRMDAnimatDefinitionNode do: aBlock [
	memory individualsOf: aRMDAnimatDefinitionNode do: aBlock
]

{ #category : #initialization }
RMDInterpreter >> initialize [
	super initialize.
	libraries := OrderedCollection with: self standardLibrary.
	animatDefinitions := Dictionary new.
	actionDefinitions := Dictionary new.
	behaviorDefinitions := OrderedCollection new
]

{ #category : #'animat operations' }
RMDInterpreter >> initializeAnimat: anInteger species: aRMDAnimatDefinitionNode [
	| offsets |
	offsets := aRMDAnimatDefinitionNode propertyOffsets.
	aRMDAnimatDefinitionNode propertyDeclarations
		do: [ :property | 
			memory
				at: anInteger + (offsets at: property identifier)
				put: (property expression evalIn: self) ]
]

{ #category : #'definition access' }
RMDInterpreter >> load: aRMDSyntaxNode [
	aRMDSyntaxNode isActionDefinitionNode
		ifTrue: [ ^ self loadActionDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isBehaviorDefinitionNode
		ifTrue: [ ^ self loadBehaviorDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isAnimatDefinitionNode
		ifTrue: [ ^ self loadAnimatDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isCellDefinitionNode
		ifTrue: [ ^ self loadCellDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isWorldDefinitionNode
		ifTrue: [ ^ self loadWorldDefinition: aRMDSyntaxNode ].
	^ self error: 'Unknown load'
]

{ #category : #'definition access' }
RMDInterpreter >> loadActionDefinition: aRMDActionDefinitionNode [
	^ actionDefinitions
		at: aRMDActionDefinitionNode identifier
		put: aRMDActionDefinitionNode
]

{ #category : #'definition access' }
RMDInterpreter >> loadAnimatDefinition: aRMDAnimatDefinitionNode [
	^ animatDefinitions
		at: aRMDAnimatDefinitionNode identifier
		put: aRMDAnimatDefinitionNode
]

{ #category : #'definition access' }
RMDInterpreter >> loadBehaviorDefinition: aRMDBehaviorDefinitionNode [
	^ behaviorDefinitions add: aRMDBehaviorDefinitionNode
]

{ #category : #'definition access' }
RMDInterpreter >> loadCellDefinition: aRMDCellDefinitionNode [
	cellDefinition := aRMDCellDefinitionNode
]

{ #category : #'definition access' }
RMDInterpreter >> loadWorldDefinition: aRMDWorldDefinitionNode [
	worldDefinition := aRMDWorldDefinitionNode
]

{ #category : #private }
RMDInterpreter >> memory [
	^ memory
]

{ #category : #simulating }
RMDInterpreter >> performBehaviors [
	behaviorDefinitions do: [ :behavior | behavior evalIn: self ]
]

{ #category : #private }
RMDInterpreter >> random [
	^ SharedRandom globalGenerator next
]

{ #category : #'variable access' }
RMDInterpreter >> readDelta: aString agent: anotherString ifAbsent: errorBlock [
	^ memory
		deltaAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: errorBlock
]

{ #category : #'variable access' }
RMDInterpreter >> readDifferential2: aString agent: anotherString ifAbsent: errorBlock [
	^ (memory
		delta2At:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: [ ^ errorBlock value ]) / self deltaTime squared
]

{ #category : #'variable access' }
RMDInterpreter >> readDifferential: aString agent: anotherString ifAbsent: errorBlock [
	^ (memory
		deltaAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: [ ^ errorBlock value ]) / self deltaTime
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

{ #category : #private }
RMDInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : #'context controls' }
RMDInterpreter >> setContextWithIndividual: anInteger species: aRMDAnimatDefinitionNode propertyBindMap: anArrayOfPropertyBindNode [
	self
		setContext:
			(RMDActionContext
				subject: anInteger
				species: aRMDAnimatDefinitionNode
				propertyBindMap: anArrayOfPropertyBindNode)
]

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [
	memory := aRMDMemory
]

{ #category : #'definition access' }
RMDInterpreter >> simulationDefinition [
	^ simulationDefinition
]

{ #category : #'definition access' }
RMDInterpreter >> simulationDefinition: aRMDSimulationDefinitionNode [
	simulationDefinition := aRMDSimulationDefinitionNode
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
