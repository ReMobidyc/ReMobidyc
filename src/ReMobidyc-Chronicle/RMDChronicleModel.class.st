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

{ #category : 'accessing' }
RMDChronicleModel >> authors [

	^ hideMetadata at: 'authors' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
RMDChronicleModel >> description [

	^ hideMetadata at: 'description' ifAbsent: [ '' ]
]

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

{ #category : 'testing' }
RMDChronicleModel >> includesSubstring: aString [

	hideStorage ifNotNil: [
		hideStorage
			chronicleFileReferenceFor: hideMetadata
			do: [ :baseRef |
				(baseRef / 'model' filesMatching: '*.rmd') do: [ :ref |
					ref readStreamDo: [ :stream |
						(stream upToEnd includesSubstring: aString) ifTrue: [ ^ true ] ] ] ] ].
	^ false
]

{ #category : 'hideho-initialization' }
RMDChronicleModel >> initializeHideMetadata [

	hideMetadata := HiDeMetadata new.
	hideMetadata addTag: 'model'
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> load [

	^ self hideLoad
]

{ #category : 'accessing' }
RMDChronicleModel >> name [

	^ hideMetadata at: 'name' ifAbsent: [ '' ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> save [

	^ self hideSave
]

{ #category : 'accessing' }
RMDChronicleModel >> simulationModel [

	^ simulationModel
]

{ #category : 'accessing' }
RMDChronicleModel >> simulationModel: aRMDSimulationModel [

	(simulationModel := aRMDSimulationModel) ifNotNil: [
		simulationModel name ifNotNil: [ :name |
			hideMetadata at: 'name' put: name ].
		simulationModel authors ifNotNil: [ :authors |
			hideMetadata at: 'authors' put: authors asArray ].
		simulationModel description ifNotNil: [ :description |
			hideMetadata at: 'description' put: description ] ]
]

{ #category : 'accessing' }
RMDChronicleModel >> timestamp [

	^ hideMetadata at: 'timestamp' ifAbsent: [ '' ]
]
