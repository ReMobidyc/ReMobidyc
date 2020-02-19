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
RMDContext >> subject: anInteger species: aRMDAnimatDefinition [
	subject := anInteger.
	subjectSpecies := aRMDAnimatDefinition
]
