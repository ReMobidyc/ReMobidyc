Class {
	#name : #RMDContext,
	#superclass : #Object,
	#instVars : [
		'subject',
		'subjectSpecies',
		'propertyDict'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDContext class >> subject: anInteger species: aRMDSpeciesDefinitionNode [
	^ self new
		subject: anInteger species: aRMDSpeciesDefinitionNode;
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
RMDContext >> subject: anInteger species: aRMDSpeciesDefinitionNode [
	| dict |
	subject := anInteger.
	subjectSpecies := aRMDSpeciesDefinitionNode.
	dict := Dictionary new.
	aRMDSpeciesDefinitionNode
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict at: nil put: dict.
	aRMDSpeciesDefinitionNode isCellDefinitionNode
		ifTrue: [ propertyDict at: 'here' put: dict ].
	aRMDSpeciesDefinitionNode isWorldDefinitionNode
		ifTrue: [ propertyDict at: 'world' put: dict ]
]
