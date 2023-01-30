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
RMDMetaContextForFileMemory >> createInterpreterFor: aRMDSimulationModel [

	^ aRMDSimulationModel
		  interpreterOnExistingFile:
		  modelPath / aRMDSimulationModel runBasename
		  modelPath: modelPath
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
				  aBlock value: (RMDFileMemory on: ref modelPath: modelPath) ] ]
		  ifEmpty: emptyBlock
]
