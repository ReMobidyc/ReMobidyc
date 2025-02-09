Class {
	#name : 'RMDChronicleStore',
	#superclass : 'HiDeStorage',
	#classInstVars : [
		'current'
	],
	#category : 'ReMobidyc-Chronicle',
	#package : 'ReMobidyc-Chronicle'
}

{ #category : 'operations' }
RMDChronicleStore class >> chronicleRawModels [

	^ self current
		  loadChronicle;
		  chronicleRawModels
]

{ #category : 'sole instance' }
RMDChronicleStore class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : 'operations' }
RMDChronicleStore class >> recordModel: aRMDSimulationModel [

	^ self current recordModel: aRMDSimulationModel
]

{ #category : 'operations' }
RMDChronicleStore >> chronicleModels [

	^ self chronicleSuchThat: [ :metadata | metadata hasTag: 'model' ]
]

{ #category : 'operations' }
RMDChronicleStore >> chronicleRawModels [

	| payloads |
	payloads := chronicle values select: [ :payload |
		            payload hideMetadata hasTag: 'model' ].
	^ payloads asSortedCollection: [ :newer :older |
		  older hideMetadata timestamp <= newer hideMetadata timestamp ]
]

{ #category : 'initialization' }
RMDChronicleStore >> defaultBasepath [

	^ (FileLocator documents / 'ReMobidyc')
		  ensureCreateDirectory;
		  yourself
]

{ #category : 'initialization' }
RMDChronicleStore >> initialize [

	super initialize.
	self basepath: self defaultBasepath
]

{ #category : 'class access' }
RMDChronicleStore >> payloadClassFor: aHiDeMetadata [

	(aHiDeMetadata hasTag: 'model') ifTrue: [^ RMDChronicleModel].
	^ self error: 'No known tag at metadata'
]

{ #category : 'operations' }
RMDChronicleStore >> recordModel: aRMDSimulationModel [

	| chronicleModel |
	chronicleModel := RMDChronicleModel new
		                  simulationModel: aRMDSimulationModel;
		                  yourself.
	self chronicleAdd: chronicleModel.
	^ chronicleModel
]
