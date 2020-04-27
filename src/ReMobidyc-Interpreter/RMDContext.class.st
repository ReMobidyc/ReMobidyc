Class {
	#name : #RMDContext,
	#superclass : #Object,
	#instVars : [
		'propertyDict',
		'subject',
		'subjectDefinition'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDContext class >> subject: anInteger definition: aRMDSpeciesDefinitionNode [
	^ self new
		subject: anInteger definition: aRMDSpeciesDefinitionNode;
		yourself
]

{ #category : #'instance creation' }
RMDContext class >> subject: anInteger species: aRMDSpeciesDefinitionNode with: anRMDInterpreter [
	^ self new
		subject: anInteger definition: aRMDSpeciesDefinitionNode;
		setupLocationWith: anRMDInterpreter;
		yourself
]

{ #category : #'memory access' }
RMDContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [
	^ (propertyDict
		at: agentReference
		ifAbsentPut: [ ^ errorBlock value ])
		at: aString
		ifAbsent: errorBlock
]

{ #category : #initialization }
RMDContext >> initialize [
	super initialize.
	propertyDict := Dictionary new
]

{ #category : #'memory access' }
RMDContext >> setMemoryAddressFor: aString agent: agentReference to: anotherInteger [
	^ (propertyDict at: agentReference ifAbsentPut: [ Dictionary new ])
		at: aString
		put: anotherInteger
]

{ #category : #accessing }
RMDContext >> subject [
	^ subject
]

{ #category : #accessing }
RMDContext >> subject: anInteger definition: aRMDSpeciesDefinitionNode [
	| dict |
	dict := Dictionary new.
	aRMDSpeciesDefinitionNode
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict at: nil put: dict.
	aRMDSpeciesDefinitionNode isCellDefinitionNode
		ifTrue: [ propertyDict at: 'here' put: dict ].
	aRMDSpeciesDefinitionNode isWorldDefinitionNode
		ifTrue: [ propertyDict at: 'world' put: dict ].
	subject := anInteger.
	subjectDefinition := aRMDSpeciesDefinitionNode 
]

{ #category : #accessing }
RMDContext >> subjectDefinition [
	^ subjectDefinition
]
