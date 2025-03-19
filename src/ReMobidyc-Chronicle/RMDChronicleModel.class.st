Class {
	#name : 'RMDChronicleModel',
	#superclass : 'Object',
	#traits : 'THiDePersistency',
	#classTraits : 'THiDePersistency classTrait',
	#instVars : [
		'#simulationModel => HiDePersistencySlot loader: #hideLoadSimulationModel',
		'#charts => HiDePersistencySlot loader: #hideLoadCharts'
	],
	#category : 'ReMobidyc-Chronicle',
	#package : 'ReMobidyc-Chronicle'
}

{ #category : 'adding' }
RMDChronicleModel >> addChart: aForm [

	self hideMetadata addTag: 'chart'.
	charts
		ifNil: [ charts := Array with: aForm ]
		ifNotNil: [ charts := charts copyWith: aForm ].
	^ aForm
]

{ #category : 'accessing' }
RMDChronicleModel >> authors [

	^ hideMetadata at: 'authors' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
RMDChronicleModel >> charts [

	^ charts ifNil: [ #(  ) ]
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

	"self
		hideLoadSimulationModel: aFileReference;
		hideLoadCharts: aFileReference"
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideLoadCharts [

	self hideBaseDirectoryDo: [ :ref | self hideLoadCharts: ref ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideLoadCharts: aFileReference [

	charts := aFileReference / 'charts'
		          ifExists: [ :directory |
			          (((Array streamContents: [ :stream |
				             (directory filesMatching: '*.png') do: [ :fileRef |
					             stream nextPut:
						             (fileRef withoutExtension basename asNumber ifNil: [
							              0 ]) -> (Form fromFileNamed: fileRef) ] ])
				            asSortedCollection: #key ascending) collect: #value)
				          ifNotEmpty: #asArray
				          ifEmpty: [ nil ] ]
		          ifAbsent: [ nil ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideLoadSimulationModel [

	self hideBaseDirectoryDo: [ :ref | self hideLoadSimulationModel: ref ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideLoadSimulationModel: aFileReference [

	simulationModel := aFileReference / 'model'
		                   ifExists: [ :ref |
		                   RMDSimulationModel new importModel: ref ]
		                   ifAbsent: [ nil ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideSave: aFileReference [

	self
		hideSaveSimulationModel: aFileReference;
		hideSaveCharts: aFileReference
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideSaveCharts [

	self hideBaseDirectoryDo: [ :ref | self hideSaveCharts: ref ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideSaveCharts: aFileReference [

	charts ifNotNil: [
		| dir |
		dir := (aFileReference / 'charts')
			       ensureCreateDirectory;
			       deleteAllChildren.
		charts doWithIndex: [ :form :index |
			form writePNGFileNamed: dir / index printString , 'png' ] ]
]

{ #category : 'hideho-operations' }
RMDChronicleModel >> hideSaveSimulationModel: aFileReference [

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
