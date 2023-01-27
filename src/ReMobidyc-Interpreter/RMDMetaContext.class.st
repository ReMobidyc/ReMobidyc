Class {
	#name : #RMDMetaContext,
	#superclass : #RMDContext,
	#instVars : [
		'interpreters',
		'processes',
		'processBarrier',
		'lastRunId'
	],
	#category : #'ReMobidyc-Interpreter'
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
	processes := processes copyWith: nil.
	^ aRMDSimulationModel
]

{ #category : #testing }
RMDMetaContext >> anyInterpreterRunning [

	self removeTerminatedProcesses.
	^ processes anySatisfy: #notNil
]

{ #category : #private }
RMDMetaContext >> createInterpreterFor: aRMDSimulationModel [

	^ self subclassResponsibility
]

{ #category : #initialization }
RMDMetaContext >> initialize [

	super initialize.
	interpreters := Array new.
	processes := Array new.
	processBarrier := true
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
RMDMetaContext >> processAt: anInteger ifAbsent: errorBlock [

	self removeTerminatedProcesses.
	^ (processes at: anInteger ifAbsent: errorBlock) ifNil: errorBlock
]

{ #category : #accessing }
RMDMetaContext >> processBarrier [

	^ processBarrier
]

{ #category : #accessing }
RMDMetaContext >> processBarrier: aBoolean [

	processBarrier := aBoolean
]

{ #category : #private }
RMDMetaContext >> removeTerminatedProcesses [

	1 to: processes size do: [ :runId | 
		(processes at: runId) ifNotNil: [ :p | 
			p isTerminated ifTrue: [ processes at: runId put: nil ] ] ]
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

	self removeTerminatedProcesses.
	1 to: processes size do: [ :runId | 
	(processes at: runId) ifNotNil: [ aBlock value: runId ] ]
]
