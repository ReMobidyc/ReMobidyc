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

	interpreters size + 1 = aRMDInterpreter runId ifFalse: [ 
		aRMDInterpreter runId: interpreters size + 1 ].
	interpreters := interpreters copyWith: aRMDInterpreter.
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

	^ interpreters at: anInteger ifAbsent: errorBlock
]

{ #category : #enumerating }
RMDMetaContext >> interpretersDo: aBlock [

	interpreters do: aBlock
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

{ #category : #accessing }
RMDMetaContext >> runIdString: anInteger [

	^ 'run' , anInteger printString
]

{ #category : #enumerating }
RMDMetaContext >> runIdsDo: aBlock [

	1 to: interpreters size do: aBlock
]

{ #category : #enumerating }
RMDMetaContext >> runningRunIdsDo: aBlock [

	1 to: interpreters size do: [ :runId | 
		(interpreters at: runId) runState ifTrue: [ aBlock value: runId ] ]
]
