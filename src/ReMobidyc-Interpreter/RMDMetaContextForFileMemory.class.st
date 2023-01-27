Class {
	#name : #RMDMetaContextForFileMemory,
	#superclass : #RMDMetaContext,
	#instVars : [
		'modelPath'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDMetaContextForFileMemory >> createInterpreterFor: aRMDSimulationModel [

	^ aRMDSimulationModel
		  interpreterOnExistingFile: modelPath / aRMDSimulationModel runId
		  modelPath: modelPath
]

{ #category : #accessing }
RMDMetaContextForFileMemory >> modelPath [

	^ modelPath
]

{ #category : #accessing }
RMDMetaContextForFileMemory >> modelPath: aFileReference [

	modelPath := aFileReference
]
