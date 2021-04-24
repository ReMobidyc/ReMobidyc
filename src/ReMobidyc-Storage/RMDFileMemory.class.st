Class {
	#name : #RMDFileMemory,
	#superclass : #RMDMemory,
	#instVars : [
		'digitsPerDirectoryLevel',
		'basePath',
		'digitsForTime'
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
RMDFileMemory >> basePath [
	^ basePath
]

{ #category : #'accessing-storage' }
RMDFileMemory >> basePath: aFileReference [
	basePath := aFileReference
		ensureCreateDirectory;
		yourself.
	self initializeLatestTime
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
RMDFileMemory >> fileReferenceForId: anInteger [
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
	digitsPerDirectoryLevel := self defaultDigitsPerDirectoryLevel
]

{ #category : #initialization }
RMDFileMemory >> initializeLatestTime [
	| dirRef |
	dirRef := self basePath asFileReference.
	latestTime := (String
		streamContents: [ :stream | 
			(self digitsForTime - 1) // self digitsPerDirectoryLevel
				timesRepeat: [ dirRef := dirRef
						/
							((dirRef directoryNames
								select: [ :name | 
									name size = self digitsPerDirectoryLevel
										and: [ name allSatisfy: #isDigit ] ]
								thenCollect: [ :name | name asInteger -> name ])
								ifEmpty: [ ^ 0 ]
								ifNotEmpty: #max) value.
					stream nextPutAll: dirRef basename ].
			stream
				nextPutAll:
					((dirRef fileNames
						select: [ :name | 
							name size = self digitsPerDirectoryLevel
								and: [ name allSatisfy: #isDigit ] ]
						thenCollect: [ :name | name asInteger -> name ])
						ifEmpty: [ ^ 0 ]
						ifNotEmpty: #max) value ]) asInteger
]

{ #category : #'accessing-storage' }
RMDFileMemory >> readValuesForTime: anInteger [
	| ref |
	ref := self fileReferenceForId: anInteger.
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
RMDFileMemory >> writeValues: aDictionary forTime: anInteger [
	(self fileReferenceForId: anInteger)
		writeStreamDo: [ :csvStream | 
			csvStream position: 0.
			aDictionary
				keysAndValuesDo: [ :id :value | 
					id storeOn: csvStream.
					csvStream nextPut: $,.
					value storeOn: csvStream.
					csvStream lf ] ]
]
