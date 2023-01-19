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
		ifAbsent: [ ^ errorBlock value ])
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

	attributeDict
		at: nil
		put: (aRMDAgentDefinitionNode attributeOffsets copy
				 associationsDo: [ :assoc | assoc value: anInteger + assoc value ];
				 yourself).
	aRMDAgentDefinitionNode isPatchDefinitionNode ifTrue: [ 
		attributeDict at: 'here' put: (attributeDict at: nil) ].
	subject := anInteger.
	subjectDefinition := aRMDAgentDefinitionNode
]

{ #category : #accessing }
RMDExecutionContext >> subjectDefinition [
	^ subjectDefinition
]
