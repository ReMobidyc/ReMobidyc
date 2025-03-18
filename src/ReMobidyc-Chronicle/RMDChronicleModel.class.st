Class {
	#name : 'RMDChronicleModel',
	#superclass : 'Object',
	#traits : 'THiDePersistency',
	#classTraits : 'THiDePersistency classTrait',
	#instVars : [
		'#simulationModel => HiDePersistencySlot'
	],
	#category : 'ReMobidyc-Chronicle',
	#package : 'ReMobidyc-Chronicle'
}

{ #category : 'accessing' }
RMDChronicleModel >> authors [

	^ hideMetadata at: 'authors' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
RMDChronicleModel >> defaultFolderName [

	^ '-'
]

{ #category : 'accessing' }
RMDChronicleModel >> description [

	^ hideMetadata at: 'description' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
RMDChronicleModel >> folderName [

	^ hideMetadata at: 'folderName' ifAbsent: [ self defaultFolderName ]
]

{ #category : 'accessing' }
RMDChronicleModel >> folderName: aString [

	aString
		ifNotNil: [ hideMetadata at: 'folderName' put: aString ]
		ifNil: [ hideMetadata removeKey: 'folderName' ifAbsent: [  ] ]
]

{ #category : 'testing' }
RMDChronicleModel >> hasTag: aString [

	^ hideMetadata hasTag: aString
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideLoad: aFileReference [

	aFileReference / 'model' ifExists: [ :ref |
		simulationModel := RMDSimulationModel new importModel: ref ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideSave: aFileReference [

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

{ #category : 'initialization' }
RMDChronicleModel >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeHideMetadata
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
RMDChronicleModel >> tags [

	^ hideMetadata tags
]

{ #category : 'accessing' }
RMDChronicleModel >> tags: aCollectionOfString [

	hideMetadata tags: aCollectionOfString
]

{ #category : 'accessing' }
RMDChronicleModel >> timestamp [

	^ hideMetadata at: 'timestamp' ifAbsent: [ '' ]
]
