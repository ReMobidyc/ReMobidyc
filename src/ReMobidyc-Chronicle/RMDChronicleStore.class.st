Class {
	#name : 'RMDChronicleStore',
	#superclass : 'HiDeStorageWithExpiration',
	#classInstVars : [
		'current'
	],
	#category : 'ReMobidyc-Chronicle',
	#package : 'ReMobidyc-Chronicle'
}

{ #category : 'accessing' }
RMDChronicleStore class >> chronicleMaxDays [

	^ self current chronicleMaxDays
]

{ #category : 'accessing' }
RMDChronicleStore class >> chronicleMaxDays: anIntegerOrNil [

	self current
		chronicleMaxDays: anIntegerOrNil;
		saveSettings
]

{ #category : 'accessing' }
RMDChronicleStore class >> chronicleMaxSize [

	^ self current chronicleMaxSize
]

{ #category : 'accessing' }
RMDChronicleStore class >> chronicleMaxSize: anIntegerOrNil [

	self current
		chronicleMaxSize: anIntegerOrNil;
		saveSettings
]

{ #category : 'operations' }
RMDChronicleStore class >> chronicleModels [

	^ self current
		  loadChronicle;
		  chronicleModels
]

{ #category : 'sole instance' }
RMDChronicleStore class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : 'operations' }
RMDChronicleStore class >> recordModel: aRMDSimulationModel [

	^ self current recordModel: aRMDSimulationModel
]

{ #category : 'settings' }
RMDChronicleStore class >> settingOn: aBuilder [

	<systemsettings>
	(aBuilder group: #archives)
		parent: #remobidyc;
		label: 'Archives';
		description: 'Settings about archives';
		with: [
			(aBuilder pickOne: #chronicleMaxDays)
				label: 'Expiration';
				target: self;
				domainValues: {
						('week' -> 8).
						('month' -> 32).
						('year' -> 366).
						('never' -> nil) };
				description:
					'An archive will be automatically expired in the specified period.'.
			(aBuilder pickOne: #chronicleMaxSize)
				label: 'Capacity (# of items)';
				target: self;
				domainValues: {
						('100' -> 100).
						('1000' -> 1000).
						('10000' -> 10000).
						('no limit' -> nil) };
				description:
					'The storage will keep upto the specified number of archives. The oldest will be automatically removed when the archives exceed the capacity.' ]
]

{ #category : 'accessing' }
RMDChronicleStore class >> showSettingsBrowser [

	<script: 'RMDChronicleStore showSettingsBrowser'>
	SettingBrowser new
		changePackageSet: { self package };
		open
]

{ #category : 'operations' }
RMDChronicleStore >> chronicleModels [

	^ self chronicleSuchThat: [ :metadata | metadata hasTag: 'model' ]
]

{ #category : 'initialization' }
RMDChronicleStore >> defaultBasepath [

	^ (FileLocator documents / 'ReMobidyc')
		  ensureCreateDirectory;
		  yourself
]

{ #category : 'initialization' }
RMDChronicleStore >> defaultChronicleMaxDays [

	^ 365
]

{ #category : 'initialization' }
RMDChronicleStore >> defaultChronicleMaxSize [

	^ 100000
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
	self chronicleSave: chronicleModel.
	^ chronicleModel
]
