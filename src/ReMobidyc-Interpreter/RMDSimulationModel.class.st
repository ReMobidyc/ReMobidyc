Class {
	#name : #RMDSimulationModel,
	#superclass : #Object,
	#instVars : [
		'simulationDefinition',
		'animatDefinitions',
		'cellDefinition',
		'worldDefinition',
		'actionDefinitions',
		'behaviorDefinitions'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'definition access' }
RMDSimulationModel >> actionDefinitionAt: aString ifAbsent: errorBlock [
	^ actionDefinitions at: aString ifAbsent: errorBlock
]

{ #category : #adding }
RMDSimulationModel >> addActionDefinition: aRMDActionDefinitionNode [
	^ actionDefinitions
		at: aRMDActionDefinitionNode identifier
		put: aRMDActionDefinitionNode
]

{ #category : #adding }
RMDSimulationModel >> addAnimatDefinition: aRMDAnimatDefinitionNode [
	^ animatDefinitions
		at: aRMDAnimatDefinitionNode identifier
		put: aRMDAnimatDefinitionNode
]

{ #category : #adding }
RMDSimulationModel >> addBehaviorDefinition: aRMDBehaviorDefinitionNode [
	^ behaviorDefinitions add: aRMDBehaviorDefinitionNode
]

{ #category : #'definition access' }
RMDSimulationModel >> animatDefinitionAt: aString ifAbsent: errorBlock [
	^ animatDefinitions at: aString ifAbsent: errorBlock
]

{ #category : #enumerating }
RMDSimulationModel >> animatDefinitionsDo: aBlock [
	animatDefinitions valuesDo: aBlock
]

{ #category : #enumerating }
RMDSimulationModel >> animatInitializersDo: aBlock [
	simulationDefinition animatInitializers do: aBlock
]

{ #category : #enumerating }
RMDSimulationModel >> behaviorsDo: aBlock [
	behaviorDefinitions do: aBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> cellDefinition [
	^ cellDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> cellDefinition: aRMDCellDefinitionNode [
	cellDefinition := aRMDCellDefinitionNode
]

{ #category : #'accessing - initializers' }
RMDSimulationModel >> cellInitializer [
	^ simulationDefinition cellInitializer
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> cellLength [
	^ simulationDefinition cellInitializer length
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> cellXDivisions [
	^ simulationDefinition cellInitializer xDivisions
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> cellYDivisions [
	^ simulationDefinition cellInitializer yDivisions
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> deltaTime [
	^ simulationDefinition timeDefinition step numeric
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> east [
	^ self cellLength * self cellXDivisions
]

{ #category : #initialization }
RMDSimulationModel >> initialize [
	super initialize.
	simulationDefinition := RMDSimulationDefinitionNode default.
	cellDefinition := RMDCellDefinitionNode default.
	worldDefinition := RMDWorldDefinitionNode default.
	animatDefinitions := Dictionary new.
	actionDefinitions := Dictionary new.
	behaviorDefinitions := OrderedCollection new
]

{ #category : #accessing }
RMDSimulationModel >> load: aRMDSyntaxNode [
	aRMDSyntaxNode isWorldDefinitionNode
		ifTrue: [ ^ self loadWorldDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isCellDefinitionNode
		ifTrue: [ ^ self loadCellDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isAnimatDefinitionNode
		ifTrue: [ ^ self loadAnimatDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isActionDefinitionNode
		ifTrue: [ ^ self loadActionDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isBehaviorDefinitionNode
		ifTrue: [ ^ self loadBehaviorDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isWorldInitializerNode 
		ifTrue: [ ^ self loadWorldInitializer: aRMDSyntaxNode ].
	aRMDSyntaxNode isCellInitializerNode 
		ifTrue: [ ^ self loadCellInitializer: aRMDSyntaxNode ].
	aRMDSyntaxNode isAnimatInitializerNode 
		ifTrue: [ ^ self loadAnimatInitializer: aRMDSyntaxNode ].
	aRMDSyntaxNode isSimulationDefinitionNode
		ifTrue: [ ^self loadSimulationDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isSimulationTimeDefinitionNode
		ifTrue: [ ^self loadSimulationTimeDefinition: aRMDSyntaxNode ].
	^ self error: 'Unknown load'
]

{ #category : #accessing }
RMDSimulationModel >> loadActionDefinition: aRMDActionDefinitionNode [
	self addActionDefinition: aRMDActionDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> loadAnimatDefinition: aRMDAnimatDefinitionNode [
	^ self addAnimatDefinition: aRMDAnimatDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> loadAnimatInitializer: aRMDAnimatInitializerNode [
	self simulationDefinition
		addAnimatInitializer: aRMDAnimatInitializerNode
]

{ #category : #accessing }
RMDSimulationModel >> loadBehaviorDefinition: aRMDBehaviorDefinitionNode [
	^ self addBehaviorDefinition: aRMDBehaviorDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> loadCellDefinition: aRMDCellDefinitionNode [
	self cellDefinition: aRMDCellDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> loadCellInitializer: aRMDCellInitializerNode [
	self simulationDefinition cellInitializer: aRMDCellInitializerNode
]

{ #category : #accessing }
RMDSimulationModel >> loadSimulationDefinition: aRMDSimulationDefinitionNode [
	self simulationDefinition: aRMDSimulationDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> loadSimulationTimeDefinition: aRMDSimulationTimeDefinitionNode [
	self simulationDefinition
		timeDefinition: aRMDSimulationTimeDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> loadWorldDefinition: aRMDWorldDefinitionNode [
	self worldDefinition: aRMDWorldDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> loadWorldInitializer: aRMDWorldInitializerNode [
	self simulationDefinition worldInitializer: aRMDWorldInitializerNode
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> north [
	^ self cellLength * self cellYDivisions
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> simulationDefinition [
	^ simulationDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> simulationDefinition: aRMDSimulationDefinition [
	simulationDefinition := aRMDSimulationDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> south [
	^ 0.0
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> west [
	^ 0.0
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> worldDefinition [
	^ worldDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> worldDefinition: aRMDWorldDefinitionNode [
	worldDefinition := aRMDWorldDefinitionNode
]

{ #category : #'accessing - initializers' }
RMDSimulationModel >> worldInitializer [
	^ simulationDefinition worldInitializer
]
