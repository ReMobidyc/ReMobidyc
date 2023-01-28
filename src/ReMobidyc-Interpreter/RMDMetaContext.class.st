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
RMDMetaContext >> addSimulationModel: aRMDSimulationModel ifPresent: errorBlock [

	aRMDSimulationModel runId: interpreters size + 1.
	interpreters := interpreters copyWith:
		                (self createInterpreterFor: aRMDSimulationModel).
	^ aRMDSimulationModel
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
