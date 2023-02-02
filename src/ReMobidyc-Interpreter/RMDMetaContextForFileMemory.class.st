Class {
	#name : #RMDMetaContextForFileMemory,
	#superclass : #RMDMetaContext,
	#instVars : [
		'modelPath'
	],
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #'instance creation' }
RMDMetaContextForFileMemory class >> modelPath: aFileReference [

	^ self new
		  modelPath: aFileReference;
		  yourself
]

{ #category : #private }
RMDMetaContextForFileMemory >> createInterpreterOn: aRMDSimulationModel metaparameters: aDictionary randomSeed: anIntegerOrNil runId: anInteger [

	| memory |
	memory := self memoryClass
		          on: modelPath / ('run' , anInteger printString)
		          modelPath: modelPath.
	memory
		runId: anInteger
		metaparameters: aDictionary
		randomSeed: (anIntegerOrNil ifNil: [ 
				 SharedRandom globalGenerator nextInteger:
					 RMDFishmanMooreRandomGenerator modulo ]).
	^ (aRMDSimulationModel instantiateWithMetaParameters: aDictionary) 
		  interpreterOn: memory
]

{ #category : #private }
RMDMetaContextForFileMemory >> exportModel: aRMDSimulationModel [

	aRMDSimulationModel exportModel: modelPath
]

{ #category : #'class access' }
RMDMetaContextForFileMemory >> memoryClass [

	^ RMDFileMemory
]

{ #category : #accessing }
RMDMetaContextForFileMemory >> memoryName [

	^ modelPath ifNotNil: #basename ifNil: [ '' ]
]

{ #category : #accessing }
RMDMetaContextForFileMemory >> modelPath [

	^ modelPath
]

{ #category : #accessing }
RMDMetaContextForFileMemory >> modelPath: aFileReference [

	modelPath := aFileReference ensureCreateDirectory
]

{ #category : #enumerating }
RMDMetaContextForFileMemory >> restoreMemoriesDo: aBlock ifEmpty: emptyBlock [

	^ (modelPath directoriesMatching: 'run*')
		  ifNotEmpty: [ :refs | 
			  refs do: [ :ref | 
				  aBlock value: (self memoryClass on: ref modelPath: modelPath) ] ]
		  ifEmpty: emptyBlock
]
