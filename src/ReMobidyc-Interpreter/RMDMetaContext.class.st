Class {
	#name : #RMDMetaContext,
	#superclass : #RMDContext,
	#instVars : [
		'interpreters'
	],
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #testing }
RMDMetaContext class >> isAbstract [

	^ self = RMDMetaContext
]

{ #category : #adding }
RMDMetaContext >> addInterpreter: aRMDInterpreter [

	aRMDInterpreter runId > interpreters size ifTrue: [ 
		interpreters := interpreters
		                ,
		                (Array new:
			                 aRMDInterpreter runId - interpreters size) ].
	interpreters at: aRMDInterpreter runId put: aRMDInterpreter.
	^ aRMDInterpreter runId
]

{ #category : #adding }
RMDMetaContext >> addInterpreterOn: aRMDSimulationModel metaparameters: aDictionary randomSeed: anIntegerOrNil [

	| runId |
	runId := interpreters size + 1.
	interpreters := interpreters copyWith: (self
			                 createInterpreterOn: aRMDSimulationModel
			                 metaparameters: aDictionary
			                 randomSeed: anIntegerOrNil
			                 runId: runId).
	^ runId
]

{ #category : #private }
RMDMetaContext >> createInterpreterOn: aRMDSimulationModel metaparameters: aDictionary randomSeed: anIntegerOrNil runId: anInteger [

	^ self subclassResponsibility
]

{ #category : #private }
RMDMetaContext >> exportModel: aRMDSimulationModel [

	^ self subclassResponsibility
]

{ #category : #initialization }
RMDMetaContext >> initialize [

	super initialize.
	interpreters := Array new
]

{ #category : #accessing }
RMDMetaContext >> interpreterAt: anInteger ifAbsent: errorBlock [

	^ (interpreters at: anInteger ifAbsent: [ nil ]) ifNil: errorBlock
]

{ #category : #enumerating }
RMDMetaContext >> interpretersDo: aBlock [

	interpreters do: [ :i | i ifNotNil: aBlock ]
]

{ #category : #testing }
RMDMetaContext >> isForFileMemory [

	^ false
]

{ #category : #testing }
RMDMetaContext >> isRunningSimulation [

	self interpretersDo: [ :interpreter | 
		interpreter isRunningSimulation ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
RMDMetaContext >> memoryName [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDMetaContext >> numberOfInterpreters [

	^ interpreters size
]

{ #category : #enumerating }
RMDMetaContext >> restoreMemoriesDo: aBlock ifEmpty: emptyBlock [

	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDMetaContext >> runIdsDo: aBlock [

	self interpretersDo: [ :interpreter | 
		aBlock value: interpreter runId ]
]

{ #category : #enumerating }
RMDMetaContext >> runningRunIdsDo: aBlock [

	self interpretersDo: [ :interpreter | 
		interpreter runState ifTrue: [ aBlock value: interpreter runId ] ]
]
