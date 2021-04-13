Class {
	#name : #RMDExecutionContext,
	#superclass : #RMDContext,
	#instVars : [
		'propertyDict',
		'subject',
		'subjectDefinition'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDExecutionContext class >> subject: anInteger definition: aRMDSpeciesDefinitionNode [
	^ self new
		subject: anInteger definition: aRMDSpeciesDefinitionNode;
		yourself
]

{ #category : #'memory access' }
RMDExecutionContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [
	^ (propertyDict
		at: agentReference
		ifAbsentPut: [ ^ errorBlock value ])
		at: aString
		ifAbsent: errorBlock
]

{ #category : #initialization }
RMDExecutionContext >> initialize [
	super initialize.
	propertyDict := Dictionary new
]

{ #category : #'memory access' }
RMDExecutionContext >> setMemoryAddressFor: aString agent: agentReference to: anotherInteger [
	^ (propertyDict at: agentReference ifAbsentPut: [ Dictionary new ])
		at: aString
		put: anotherInteger
]

{ #category : #accessing }
RMDExecutionContext >> subject [
	^ subject
]

{ #category : #accessing }
RMDExecutionContext >> subject: anInteger definition: aRMDSpeciesDefinitionNode [
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
RMDExecutionContext >> subjectDefinition [
	^ subjectDefinition
]
