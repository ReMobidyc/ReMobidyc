Class {
	#name : 'RMDChronicleModel',
	#superclass : 'Object',
	#traits : 'THiDePersistency',
	#classTraits : 'THiDePersistency classTrait',
	#instVars : [
		'simulationModel'
	],
	#category : 'ReMobidyc-Chronicle',
	#package : 'ReMobidyc-Chronicle'
}

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideLoad: aFileReference storage: aHiDeStorage [

	aFileReference / 'model' ifExists: [ :ref |
		simulationModel := RMDSimulationModel new importModel: ref ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideSave: aFileReference storage: aHiDeStorage [

	simulationModel ifNotNil: [
		simulationModel exportModel: ((aFileReference / 'model')
				 ensureCreateDirectory;
				 deleteAllChildren;
				 yourself) ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideUpdateMetadataStorage: aHiDeStorage [

	
]

{ #category : 'hideho-initialization' }
RMDChronicleModel >> initializeHideMetadata [

	super initializeHideMetadata.
	hideMetadata addTag: 'model'
]

{ #category : 'accessing' }
RMDChronicleModel >> simulationModel [

	^ simulationModel
]

{ #category : 'accessing' }
RMDChronicleModel >> simulationModel: aRMDSimulationModel [

	simulationModel := aRMDSimulationModel
]
