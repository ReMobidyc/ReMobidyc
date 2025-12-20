Class {
	#name : 'RMDAbstractInterpreter',
	#superclass : 'Model',
	#instVars : [
		'simulationModel',
		'context',
		'contextSemaphore'
	],
	#category : 'ReMobidyc-Interpreter-Core',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Core'
}

{ #category : 'library access' }
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
		  ('celing' -> RMDFunction ceiling).
		  ('gaussian' -> RMDFunction gaussian) } asDictionary
]

{ #category : 'private' }
RMDAbstractInterpreter >> context [
	^ context
]

{ #category : 'timing' }
RMDAbstractInterpreter >> deltaTimeUnit [

	^ simulationModel deltaTimeUnit
]

{ #category : 'timing' }
RMDAbstractInterpreter >> durationUnit [

	^ simulationModel durationUnit
]

{ #category : 'initialization' }
RMDAbstractInterpreter >> initialize [

	super initialize.
	simulationModel := RMDSimulationModel new.
	contextSemaphore := Semaphore forMutualExclusion
]

{ #category : 'testing' }
RMDAbstractInterpreter >> isMetaInterpreter [
	^ false
]

{ #category : 'testing' }
RMDAbstractInterpreter >> isTypechecker [
	^ false
]

{ #category : 'accessing' }
RMDAbstractInterpreter >> kindName [

	^ self subclassResponsibility
]

{ #category : 'accessing - definitions' }
RMDAbstractInterpreter >> load: aRMDSyntaxNode [
	simulationModel load: aRMDSyntaxNode
]

{ #category : 'accessing' }
RMDAbstractInterpreter >> modelName [

	^ simulationModel ifNotNil: #name ifNil: [ '' ]
]

{ #category : 'accessing' }
RMDAbstractInterpreter >> name [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: self kindName;
			  nextPutAll: ':';
			  nextPutAll: self modelName;
			  nextPutAll: '[';
			  nextPutAll: self metaparametersString;
			  nextPutAll: ']' ]
]

{ #category : 'accessing - definitions' }
RMDAbstractInterpreter >> patchLengthUnit [

	^ simulationModel patchLengthUnit
]

{ #category : 'private' }
RMDAbstractInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : 'accessing' }
RMDAbstractInterpreter >> shortName [

	^ self modelName
]

{ #category : 'accessing - definitions' }
RMDAbstractInterpreter >> simulationModel [
	^ simulationModel
]

{ #category : 'accessing - definitions' }
RMDAbstractInterpreter >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel
]

{ #category : 'context controls' }
RMDAbstractInterpreter >> withContext: aRMDContext do: aBlock [

	contextSemaphore critical: [
			| originalContext ret |
			originalContext := context.
			self setContext: aRMDContext.
			ret := aBlock value.
			context := originalContext.
			^ ret ]
]

{ #category : 'context controls' }
RMDAbstractInterpreter >> withSubContext: aRMDContext do: aBlock [

	| originalContext |
	originalContext := context.
	self setContext: aRMDContext.
	^ [ aBlock cull: self cull: context ] ensure: [ 
		  context := originalContext ]
]
