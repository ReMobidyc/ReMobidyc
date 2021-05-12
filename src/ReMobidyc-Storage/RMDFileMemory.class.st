Class {
	#name : #RMDFileMemory,
	#superclass : #RMDMemory,
	#instVars : [
		'digitsPerDirectoryLevel',
		'basePath',
		'digitsForTime',
		'stagesDirty',
		'spaceDirty',
		'allocationDirty'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #'instance creation' }
RMDFileMemory class >> on: aFileReference [
	^ self new
		basePath: aFileReference asFileReference;
		yourself
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
		initializeAllocation
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> cell: anInteger [
	super cell: anInteger.
	spaceDirty := true
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> cellSize: anInteger [
	super cellSize: anInteger.
	spaceDirty := true
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
	stagesDirty := false.
	spaceDirty := false.
	allocationDirty := false
]

{ #category : #initialization }
RMDFileMemory >> initializeAllocation [
	self readAllocation
		at: 'latestTime' ifPresent: [ :v | latestTime := v ];
		at: 'nextAvailableSlot' ifPresent: [ :v | nextAvailableSlot := v ].
	allocationDirty := false
]

{ #category : #initialization }
RMDFileMemory >> initializeSpace [
	self readSpace
		at: 'cell' ifPresent: [ :v | cell := v ];
		at: 'xCells' ifPresent: [ :v | xCells := v ];
		at: 'yCells' ifPresent: [ :v | yCells := v ];
		at: 'cellSize' ifPresent: [ :v | cellSize := v ].
	spaceDirty := false
]

{ #category : #accessing }
RMDFileMemory >> latestTime: anInteger [
	| oldLatestTime |
	oldLatestTime := self latestTime.
	super latestTime: anInteger.
	oldLatestTime = anInteger
		ifTrue: [ allocationDirty := true ]
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> migrate: anInteger animat: aString to: anotherInteger animat: anotherString [
	super
		migrate: anInteger
		animat: aString
		to: anotherInteger
		animat: anotherString.
	stagesDirty := true
]

{ #category : #accessing }
RMDFileMemory >> nextAvailableSlot: anInteger [
	| oldSlot |
	oldSlot := self nextAvailableSlot.
	super nextAvailableSlot: anInteger.
	oldSlot = anInteger
		ifTrue: [ allocationDirty := true ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readAllocation [
	self allocationFile
		ensureCreateFile;
		readStreamDo: [ :stream | 
			| params |
			params := Dictionary new.
			[ stream atEnd ]
				whileFalse: [ (stream nextLine truncate substrings: ',')
						ifNotEmpty: [ :pair | 
							pair size = 2
								ifTrue: [ params at: pair first put: pair second asInteger ] ] ].
			^ params ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readAnimatsForTime: anInteger [
	| ref |
	ref := (self directoryForId: anInteger) / self valuesFileBasename.
	ref exists
		ifFalse: [ ^ Dictionary new ].
	ref
		readStreamDo: [ :csvStream | 
			| vals |
			vals := Dictionary new.
			[ [ csvStream atEnd not and: [ csvStream peek isSeparator ] ]
				whileTrue: [ csvStream skip ].
			csvStream atEnd ]
				whileFalse: [ ((csvStream upTo: Character lf) substrings: ',')
						ifNotEmpty:
							[ :row | vals at: row first put: (row copyWithoutFirst collect: #asInteger) ] ].
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
				whileFalse: [ (stream nextLine truncate substrings: ',')
						ifNotEmpty: [ :pair | 
							pair size = 2
								ifTrue: [ params at: pair first put: pair second asInteger ] ] ].
			^ params ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readStages [
	self stagesFile
		ensureCreateFile;
		readStreamDo: [ :stream | 
			| newStages |
			newStages := Dictionary new: stages size * 3 // 2.
			[ stream atEnd ]
				whileFalse: [ | ids |
					ids := (stream nextLine truncate substrings: ',')
						collect: #asInteger.
					ids do: [ :id | newStages at: id put: ids ] ].
			^ newStages ]
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
				whileTrue: [ csvStream skip ].
			csvStream atEnd ]
				whileFalse: [ | id value |
					id := (csvStream upTo: $,) asInteger.
					[ csvStream peek isSeparator ] whileTrue: [ csvStream skip ].
					value := (csvStream upTo: Character lf) asNumber.
					vals at: id put: value ].
			^ vals ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> spaceFile [
	^ self basePath / self spaceFileBasename
]

{ #category : #'accessing-storage' }
RMDFileMemory >> spaceFileBasename [
	^ 'space.csv'
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
	spaceDirty
		ifTrue: [ self writeSpace.
			spaceDirty := false ].
	allocationDirty
		ifTrue: [ self writeAllocation.
			allocationDirty := false ]
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
			stream lf ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeAnimats: aDictionary forTime: anInteger [
	((self directoryForId: anInteger) ensureCreateDirectory
		/ self animatsFileBasename)
		ensureDelete;
		writeStreamDo: [ :csvStream | 
			aDictionary
				keysAndValuesDo: [ :animat :individuals | 
					animat printOn: csvStream.
					csvStream nextPut: $,.
					individuals
						do: [ :id | id storeOn: csvStream ]
						separatedBy: [ csvStream nextPut: $, ].
					csvStream lf ] ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeSpace [
	self spaceFile
		ensureDelete;
		writeStreamDo: [ :stream | 
			stream nextPutAll: 'cell,'.
			cell storeOn: stream.
			stream lf.
			stream nextPutAll: 'xCells,'.
			xCells storeOn: stream.
			stream lf.
			stream nextPutAll: 'yCells,'.
			yCells storeOn: stream.
			stream lf.
			stream nextPutAll: 'cellSize'.
			cellSize storeOn: stream.
			stream lf ]
]

{ #category : #'accessing-storage' }
RMDFileMemory >> writeStages [
	self stagesFile
		ensureDelete;
		writeStreamDo: [ :stream | 
			stages values asIdentitySet
				do: [ :individuals | 
					individuals
						do: [ :id | id storeOn: stream ]
						separatedBy: [ stream nextPut: $, ].
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
RMDFileMemory >> xCells: anInteger [
	super xCells: anInteger.
	spaceDirty := true
]

{ #category : #'accessing-individuals' }
RMDFileMemory >> yCells: anInteger [
	super yCells: anInteger.
	spaceDirty := true
]
