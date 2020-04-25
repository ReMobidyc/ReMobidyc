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

{ #category : #'accessing - definitions' }
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

{ #category : #'accessing - definitions' }
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

{ #category : #'accessing-cells' }
RMDSimulationModel >> cellLength [
	^ simulationDefinition cellInitializer length
]

{ #category : #'accessing-cells' }
RMDSimulationModel >> cellXDivisions [
	^ simulationDefinition cellInitializer xDivisions
]

{ #category : #'accessing-cells' }
RMDSimulationModel >> cellYDivisions [
	^ simulationDefinition cellInitializer yDivisions
]

{ #category : #'accessing - time' }
RMDSimulationModel >> deltaTime [
	^ simulationDefinition timeDefinition step numeric
]

{ #category : #'accessing - time' }
RMDSimulationModel >> duration [
	^ simulationDefinition timeDefinition duration numeric
]

{ #category : #'accessing-cells' }
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
		ifTrue: [ ^ self worldDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isCellDefinitionNode
		ifTrue: [ ^ self cellDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isAnimatDefinitionNode
		ifTrue: [ ^ self addAnimatDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isActionDefinitionNode
		ifTrue: [ ^ self addActionDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isBehaviorDefinitionNode
		ifTrue: [ ^ self addBehaviorDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isSimulationDefinitionNode
		ifTrue: [ ^self simulationDefinition: aRMDSyntaxNode ].
	^ self error: 'Unknown load'
]

{ #category : #'accessing-cells' }
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

{ #category : #'accessing-cells' }
RMDSimulationModel >> south [
	^ 0.0
]

{ #category : #'accessing-cells' }
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
