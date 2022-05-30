Class {
	#name : #RMDFileMemory,
	#superclass : #RMDMemory,
	#instVars : [
		'digitsPerDirectoryLevel',
		'basePath',
		'digitsForTime',
		'spaceDirty',
		'allocationDirty',
		'stageLinksDirty',
		'reproductionLinksDirty'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #'instance creation' }
RMDFileMemory class >> on: aFileReference [
	^ self new
		basePath: aFileReference asFileReference;
		yourself
]

{ #category : #allocating }
RMDFileMemory >> allocateWorld: aRMDWorldDefinitionNode [

	| id |
	id := super allocateWorld: aRMDWorldDefinitionNode.
	allocationDirty := true.
	^ id
]

{ #category : #'accessing-storage' }
RMDFileMemory >> allocationFile [
	^ self basePath / self allocationFileBasename
]

{ #category : #'accessing-storage' }
RMDFileMemory >> allocationFileBasename [
	^ 'allocation.csv'
]

{ #category : #'accessing-storage' }
RMDFileMemory >> animatsFileBasename [
	^ 'animats.csv'
]

{ #category : #'accessing-storage' }
RMDFileMemory >> basePath [
	^ basePath
]

{ #category : #'accessing-storage' }
RMDFileMemory >> basePath: aFileReference [

	basePath := aFileReference
		            ensureCreateDirectory;
		            yourself.
	self
		initializeSpace;
		initializeAllocation;
		initializeStageLinks;
		initializeReproductionLinks
]

{ #category : #defaults }
RMDFileMemory >> defaultDigitsForTime [
	^ 6
]

{ #category : #defaults }
RMDFileMemory >> defaultDigitsPerDirectoryLevel [
	^ 3
]

{ #category : #'accessing-storage' }
RMDFileMemory >> digitsForTime [
	^ digitsForTime
]

{ #category : #'accessing-storage' }
RMDFileMemory >> digitsForTime: anInteger [
	digitsForTime := anInteger asInteger
]

{ #category : #'accessing-storage' }
RMDFileMemory >> digitsPerDirectoryLevel [
	^ digitsPerDirectoryLevel
]

{ #category : #'accessing-storage' }
RMDFileMemory >> digitsPerDirectoryLevel: anInteger [
	digitsPerDirectoryLevel := anInteger asInteger
]

{ #category : #'accessing-storage' }
RMDFileMemory >> directoryForId: anInteger [
	| stringId |
	stringId := anInteger asString.
	(String new: self digitsForTime - stringId size withAll: $0)
		, stringId
		readStreamDo: [ :idStream | 
			| ref |
			ref := self basePath.
			(self digitsForTime - 1) // self digitsPerDirectoryLevel + 1
				timesRepeat: [ ref := ref ensureCreateDirectory
						/ (idStream next: self digitsPerDirectoryLevel) ].
			^ ref ]
]

{ #category : #initialization }
RMDFileMemory >> initialize [
	super initialize.
	digitsForTime := self defaultDigitsForTime.
	digitsPerDirectoryLevel := self defaultDigitsPerDirectoryLevel.
	spaceDirty := false.
	allocationDirty := false.
	stageLinksDirty := false.
	reproductionLinksDirty := false
]

{ #category : #initialization }
RMDFileMemory >> initializeAllocation [

	self readAllocation
		at: 'latestTime' ifPresent: [ :v | latestTime := v ];
		at: 'nextAvailableSlot' ifPresent: [ :v | nextAvailableSlot := v ];
		at: 'world' ifPresent: [ :v | world := v ].
	allocationDirty := false
]

{ #category : #initialization }
RMDFileMemory >> initializeReproductionLinks [

	self readReproductionLinks ifNotNil: [ :links | 
		reproductionLinks := links.
		reproductionLinksDirty := false ]
]

{ #category : #initialization }
RMDFileMemory >> initializeSpace [
	self readSpace
		at: 'patch' ifPresent: [ :v | patch := v ];
		at: 'xPatches' ifPresent: [ :v | xPatches := v ];
		at: 'yPatches' ifPresent: [ :v | yPatches := v ];
		at: 'patchSize' ifPresent: [ :v | patchSize := v ].
	spaceDirty := false
]

{ #category : #initialization }
RMDFileMemory >> initializeStageLinks [

	self readStageLinks ifNotNil: [ :links | 
		stageLinks := links.
		stageLinksDirty := false ]
]

{ #category : #accessing }
RMDFileMemory >> latestTime: anInteger [
	| oldLatestTime |
	oldLatestTime := self latestTime.
	super latestTime: anInteger.
	oldLatestTime = latestTime
		ifFalse: [ allocationDirty := true ]
]

{ #category : #accessing }
RMDFileMemory >> nextAvailableSlot: anInteger [
	| oldSlot |
	oldSlot := self nextAvailableSlot.
	super nextAvailableSlot: anInteger.
	oldSlot = anInteger
		ifTrue: [ allocationDirty := true ]
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> patch: anInteger [
	super patch: anInteger.
	spaceDirty := true
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> patchSize: anInteger [
	super patchSize: anInteger.
	spaceDirty := true
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readAllocation [
	self allocationFile
		ensureCreateFile;
		readStreamDo: [ :stream | 
			| params |
			params := Dictionary new.
			[ stream atEnd ]
				whileFalse: [ (stream nextLine trim substrings: ',')
						ifNotEmpty: [ :pair | 
							pair size = 2
								ifTrue: [ params at: pair first put: pair second asInteger ] ] ].
			^ params ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readAnimatsForTime: anInteger [

	| ref |
	ref := (self directoryForId: anInteger) / self animatsFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref readStreamDo: [ :csvStream | 
		| vals |
		vals := Dictionary new.
		[ 
		[ csvStream atEnd not and: [ csvStream peek isSeparator ] ] 
			whileTrue: [ csvStream next ].
		csvStream atEnd ] whileFalse: [ 
			((csvStream upTo: Character lf) substrings: ',') ifNotEmpty: [ :row | 
				vals
					at: row first
					put: (row copyWithoutFirst collect: #asInteger) asSet ] ].
		^ vals ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readReproductionLinks [

	self reproductionLinksFile
		ensureCreateFile;
		readStreamDo: [ :stream | 
			| params |
			params := Dictionary new.
			[ stream atEnd ] whileFalse: [ 
					(stream nextLine trim substrings: ',') ifNotEmpty: [ :pair | 
							pair size = 2 ifTrue: [ 
									params
										at: pair first trim asInteger
										put: pair second trim asInteger ] ] ].
			^ params ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readSeedsForTime: anInteger [

	| ref |
	ref := (self directoryForId: anInteger) / self seedsFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref readStreamDo: [ :csvStream | 
		| vals |
		vals := Dictionary new.
		[ 
		[ csvStream atEnd not and: [ csvStream peek isSeparator ] ] 
			whileTrue: [ csvStream next ].
		csvStream atEnd ] whileFalse: [ 
			vals
				at: (csvStream upTo: $,) asInteger
				put: (csvStream upTo: Character lf) asInteger ].
		^ vals ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readSpace [
	self spaceFile
		ensureCreateFile;
		readStreamDo: [ :stream | 
			| params |
			params := Dictionary new.
			[ stream atEnd ]
				whileFalse: [ (stream nextLine trim substrings: ',')
						ifNotEmpty: [ :pair | 
							pair size = 2
								ifTrue: [ params at: pair first put: pair second asInteger ] ] ].
			^ params ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readStageLinks [

	self stageLinksFile
		ensureCreateFile;
		readStreamDo: [ :stream | 
			| params |
			params := Dictionary new.
			[ stream atEnd ] whileFalse: [ 
					(stream nextLine trim substrings: ',') ifNotEmpty: [ :pair | 
							pair size = 2 ifTrue: [ 
									params
										at: pair first trim asInteger
										put: pair second trim asInteger ] ] ].
			^ params ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readValuesForTime: anInteger [
	| ref |
	ref := (self directoryForId: anInteger) / self valuesFileBasename.
	ref exists
		ifFalse: [ ^ Dictionary new ].
	ref
		readStreamDo: [ :csvStream | 
			| vals |
			vals := Dictionary new.
			[ [ csvStream atEnd not and: [ csvStream peek isSeparator ] ]
				whileTrue: [ csvStream next ].
			csvStream atEnd ]
				whileFalse: [ | id value |
					id := (csvStream upTo: $,) asInteger.
					[ csvStream peek isSeparator ] whileTrue: [ csvStream next ].
					value := (csvStream upTo: Character lf) asNumber.
					vals at: id put: value ].
			^ vals ]
]

{ #category : #allocating }
RMDFileMemory >> reproduceAnimat: aRMDAnimatDefinitionNode with: anInteger [

	reproductionLinksDirty := true.
	^ super reproduceAnimat: aRMDAnimatDefinitionNode with: anInteger
]

{ #category : #'accessing-storage' }
RMDFileMemory >> reproductionLinksFile [
	^ self basePath / self reproductionLinksFileBasename
]

{ #category : #'accessing-storage' }
RMDFileMemory >> reproductionLinksFileBasename [
	^ 'reproductionLinks.csv'
]

{ #category : #'accessing-storage' }
RMDFileMemory >> seedsFileBasename [
	^ 'seeds.csv'
]

{ #category : #'accessing-storage' }
RMDFileMemory >> spaceFile [
	^ self basePath / self spaceFileBasename
]

{ #category : #'accessing-storage' }
RMDFileMemory >> spaceFileBasename [
	^ 'space.csv'
]

{ #category : #allocating }
RMDFileMemory >> stageAnimat: aRMDAnimatDefinitionNode with: anInteger [

	stageLinksDirty := true.
	^ super stageAnimat: aRMDAnimatDefinitionNode with: anInteger
]

{ #category : #'accessing-storage' }
RMDFileMemory >> stageLinksFile [
	^ self basePath / self stageLinksFileBasename
]

{ #category : #'accessing-storage' }
RMDFileMemory >> stageLinksFileBasename [
	^ 'stageLinks.csv'
]

{ #category : #'accessing-storage' }
RMDFileMemory >> stagesFile [
	^ self basePath / self stagesFileBasename
]

{ #category : #'accessing-storage' }
RMDFileMemory >> stagesFileBasename [
	^ 'stages.csv'
]

{ #category : #timing }
RMDFileMemory >> sunset [

	super sunset.
	spaceDirty ifTrue: [ 
		self writeSpace.
		spaceDirty := false ].
	allocationDirty ifTrue: [ 
		self writeAllocation.
		allocationDirty := false ].
	stageLinksDirty ifTrue: [ 
		self writeStageLinks.
		stageLinksDirty := false ].
	reproductionLinksDirty ifTrue: [ 
		self writeReproductionLinks.
		reproductionLinksDirty := false ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> valuesFileBasename [
	^ 'values.csv'
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeAllocation [

	self allocationFile
		ensureDelete;
		writeStreamDo: [ :stream | 
			stream nextPutAll: 'latestTime,'.
			latestTime storeOn: stream.
			stream lf.
			stream nextPutAll: 'nextAvailableSlot,'.
			nextAvailableSlot storeOn: stream.
			stream lf.
			stream nextPutAll: 'world,'.
			world storeOn: stream.
			stream lf ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeAnimats: aDictionary forTime: anInteger [

	((self directoryForId: anInteger) ensureCreateDirectory
	 / self animatsFileBasename)
		ensureDelete;
		writeStreamDo: [ :csvStream | 
			aDictionary keysAndValuesDo: [ :animat :individuals | 
					csvStream nextPutAll: animat.
					individuals ifNotEmpty: [ 
							csvStream nextPut: $,.
							individuals
								do: [ :id | id printOn: csvStream ]
								separatedBy: [ csvStream nextPut: $, ] ].
					csvStream lf ] ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeReproductionLinks [

	self reproductionLinksFile
		ensureDelete;
		writeStreamDo: [ :stream | 
			reproductionLinks keysAndValuesDo: [ :key :value | 
					key printOn: stream.
					stream nextPut: $,.
					value printOn: stream.
					stream nextPut: Character lf ] ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeSeeds: aDictionary forTime: anInteger [

	((self directoryForId: anInteger) ensureCreateDirectory
	 / self seedsFileBasename)
		ensureDelete;
		writeStreamDo: [ :csvStream | 
			aDictionary keysAndValuesDo: [ :animat :seed | 
					animat printOn: csvStream.
					csvStream nextPut: $,.
					seed printOn: csvStream.
					csvStream lf ] ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeSpace [

	self spaceFile
		ensureDelete;
		writeStreamDo: [ :stream | 
			stream nextPutAll: 'patch,'.
			patch storeOn: stream.
			stream lf.
			stream nextPutAll: 'xPatches,'.
			xPatches storeOn: stream.
			stream lf.
			stream nextPutAll: 'yPatches,'.
			yPatches storeOn: stream.
			stream lf.
			stream nextPutAll: 'patchSize,'.
			patchSize storeOn: stream.
			stream lf ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeStageLinks [

	self stageLinksFile
		ensureDelete;
		writeStreamDo: [ :stream | 
			stageLinks keysAndValuesDo: [ :key :value | 
					key printOn: stream.
					stream nextPut: $,.
					value printOn: stream.
					stream nextPut: Character lf ] ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeValues: aDictionary forTime: anInteger [
	((self directoryForId: anInteger) ensureCreateDirectory
		/ self valuesFileBasename)
		ensureDelete;
		writeStreamDo: [ :csvStream | 
			aDictionary
				keysAndValuesDo: [ :id :value | 
					id storeOn: csvStream.
					csvStream nextPut: $,.
					value storeOn: csvStream.
					csvStream lf ] ]
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> xPatches: anInteger [
	super xPatches: anInteger.
	spaceDirty := true
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> yPatches: anInteger [
	super yPatches: anInteger.
	spaceDirty := true
]
