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
RMDMetaContext >> addSimulationModel: aRMDSimulationModel [

	| runId |
	runId := interpreters size + 1.
	aRMDSimulationModel runId: runId.
	interpreters := interpreters copyWith:
		                (self createInterpreterFor: aRMDSimulationModel).
	^ runId
]

{ #category : #testing }
RMDMetaContext >> anyInterpreterRunning [

	self interpretersDo: [ :interpreter | 
		interpreter runState ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #private }
RMDMetaContext >> createInterpreterFor: aRMDSimulationModel [

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
