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

	| runId |
	runId := self nextRunId.
	aRMDSimulationModel runId: runId.
	interpreters
		at: runId
		put: (self createInterpreterFor: aRMDSimulationModel).
	^ aRMDSimulationModel
]

{ #category : #testing }
RMDMetaContext >> anyInterpreterRunning [

	self removeTerminatedProcesses.
	^ processes notEmpty
]

{ #category : #private }
RMDMetaContext >> createInterpreterFor: aRMDSimulationModel [

	^ self subclassResponsibility
]

{ #category : #initialization }
RMDMetaContext >> initialize [

	super initialize.
	processes := Dictionary new.
	processBarrier := true.
	lastRunId := 0
]

{ #category : #accessing }
RMDMetaContext >> interpreterAt: aString ifAbsent: errorBlock [

	^ interpreters at: aString ifAbsent: errorBlock
]

{ #category : #enumerating }
RMDMetaContext >> interpretersDo: aBlock [

	interpreters valuesDo: aBlock
]

{ #category : #private }
RMDMetaContext >> nextRunId [
	^ lastRunId := lastRunId + 1
]

{ #category : #accessing }
RMDMetaContext >> processAt: aString ifAbsent: errorBlock [
	self removeTerminatedProcesses.
	^ processes at: aString ifAbsent: errorBlock
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

	processes keys asArray do: [ :runId | 
		(processes at: runId) isTerminated ifTrue: [ 
			processes removeKey: runId ] ]
]

{ #category : #enumerating }
RMDMetaContext >> runIdsDo: aBlock [

	interpreters keysDo: aBlock
]

{ #category : #enumerating }
RMDMetaContext >> runningProcessesDo: aBlock [

	self removeTerminatedProcesses.
	processes valuesDo: aBlock
]

{ #category : #enumerating }
RMDMetaContext >> runningRunIdsDo: aBlock [

	self removeTerminatedProcesses.
	processes keysDo: aBlock
]
