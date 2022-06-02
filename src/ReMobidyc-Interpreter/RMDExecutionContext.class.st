Class {
	#name : #RMDExecutionContext,
	#superclass : #RMDContext,
	#instVars : [
		'subject',
		'subjectDefinition',
		'attributeDict'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDExecutionContext class >> subject: anInteger definition: aRMDAgentDefinitionNode [
	^ self new
		subject: anInteger definition: aRMDAgentDefinitionNode;
		yourself
]

{ #category : #'memory access' }
RMDExecutionContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [
	^ (attributeDict
		at: agentReference
		ifAbsentPut: [ ^ errorBlock value ])
		at: aString
		ifAbsent: errorBlock
]

{ #category : #initialization }
RMDExecutionContext >> initialize [
	super initialize.
	attributeDict := Dictionary new
]

{ #category : #'memory access' }
RMDExecutionContext >> setMemoryAddressFor: aString agent: agentReference to: anotherInteger [
	^ (attributeDict at: agentReference ifAbsentPut: [ Dictionary new ])
		at: aString
		put: anotherInteger
]

{ #category : #accessing }
RMDExecutionContext >> subject [
	^ subject
]

{ #category : #accessing }
RMDExecutionContext >> subject: anInteger definition: aRMDAgentDefinitionNode [
	| dict |
	dict := Dictionary new.
	aRMDAgentDefinitionNode
		attributeOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	attributeDict at: nil put: dict.
	aRMDAgentDefinitionNode isPatchDefinitionNode
		ifTrue: [ attributeDict at: 'here' put: dict ].
	aRMDAgentDefinitionNode isWorldDefinitionNode
		ifTrue: [ attributeDict at: 'world' put: dict ].
	subject := anInteger.
	subjectDefinition := aRMDAgentDefinitionNode 
]

{ #category : #accessing }
RMDExecutionContext >> subjectDefinition [
	^ subjectDefinition
]
