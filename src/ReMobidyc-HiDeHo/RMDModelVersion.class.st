Class {
	#name : 'RMDModelVersion',
	#superclass : 'Object',
	#traits : 'THiDePersistency',
	#classTraits : 'THiDePersistency classTrait',
	#instVars : [
		'simulationModel'
	],
	#category : 'ReMobidyc-HiDeHo',
	#package : 'ReMobidyc-HiDeHo'
}

{ #category : 'hideho-operations' }
RMDModelVersion >> hideLoad: aFileReference storage: aHiDeStorage [

	aFileReference / 'model' ifExists: [ :ref |
		simulationModel := RMDSimulationModel new importModel: ref ]
]

{ #category : 'hideho-operations' }
RMDModelVersion >> hideSave: aFileReference storage: aHiDeStorage [

	simulationModel exportModel: ((aFileReference / 'model')
			 ensureCreateDirectory;
			 deleteAllChildren;
			 yourself)
]

{ #category : 'hideho-operations' }
RMDModelVersion >> hideUpdateMetadataStorage: aHiDeStorage [

	
]

{ #category : 'accessing' }
RMDModelVersion >> simulationModel [

	^ simulationModel
]

{ #category : 'accessing' }
RMDModelVersion >> simulationModel: aRMDSimulationModel [

	simulationModel := aRMDSimulationModel
]
