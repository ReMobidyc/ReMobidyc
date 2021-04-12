Class {
	#name : #RMDIndividualContext,
	#superclass : #RMDContext,
	#instVars : [
		'propertyDict',
		'subject',
		'subjectDefinition'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'memory access' }
RMDIndividualContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [
	^ (propertyDict
		at: agentReference
		ifAbsentPut: [ ^ errorBlock value ])
		at: aString
		ifAbsent: errorBlock
]

{ #category : #initialization }
RMDIndividualContext >> initialize [
	super initialize.
	propertyDict := Dictionary new
]

{ #category : #'memory access' }
RMDIndividualContext >> setMemoryAddressFor: aString agent: agentReference to: anotherInteger [
	^ (propertyDict at: agentReference ifAbsentPut: [ Dictionary new ])
		at: aString
		put: anotherInteger
]

{ #category : #accessing }
RMDIndividualContext >> subject [
	^ subject
]

{ #category : #accessing }
RMDIndividualContext >> subject: anInteger definition: aRMDSpeciesDefinitionNode [
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
RMDIndividualContext >> subjectDefinition [
	^ subjectDefinition
]
