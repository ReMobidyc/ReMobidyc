Class {
	#name : #RMDAbstractInterpreter,
	#superclass : #Model,
	#instVars : [
		'simulationModel',
		'context',
		'contextSemaphore'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'library access' }
RMDAbstractInterpreter class >> standardLibrary [

	^ { 
		  ('exp' -> RMDFunction exp).
		  ('log' -> RMDFunction ln).
		  ('ln' -> RMDFunction ln).
		  ('power' -> RMDFunction power).
		  ('sqrt' -> RMDFunction sqrt).
		  ('min' -> RMDFunction min).
		  ('max' -> RMDFunction max).
		  ('mean' -> RMDFunction mean).
		  ('sum' -> RMDFunction sum).
		  ('sin' -> RMDFunction sin).
		  ('cos' -> RMDFunction cos).
		  ('abs' -> RMDFunction abs).
		  ('positive' -> RMDFunction positive).
		  ('round' -> RMDFunction round).
		  ('floor' -> RMDFunction floor).
		  ('celing' -> RMDFunction ceiling) } asDictionary
]

{ #category : #private }
RMDAbstractInterpreter >> context [
	^ context
]

{ #category : #initialization }
RMDAbstractInterpreter >> initialize [
	super initialize.
	simulationModel := RMDSimulationModel new.
	contextSemaphore := Semaphore forMutualExclusion
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> load: aRMDSyntaxNode [
	simulationModel load: aRMDSyntaxNode
]

{ #category : #private }
RMDAbstractInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> simulationModel [
	^ simulationModel
]

{ #category : #'accessing - definitions' }
RMDAbstractInterpreter >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel
]

{ #category : #'context controls' }
RMDAbstractInterpreter >> withContext: aRMDContext do: aBlock [

	^ contextSemaphore critical: [ 
		  | originalContext |
		  originalContext := context.
		  self setContext: aRMDContext.
		  aBlock ensure: [ context := originalContext ] ]
]

{ #category : #'context controls' }
RMDAbstractInterpreter >> withSubContext: aRMDContext do: aBlock [

	| originalContext |
	originalContext := context.
	self setContext: aRMDContext.
	^ [ aBlock cull: self cull: context ] ensure: [ 
		  context := originalContext ]
]
