Class {
	#name : #RMDFileMemory,
	#superclass : #RMDMemory,
	#instVars : [
		'oldValues',
		'values',
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

{ #category : #accessing }
RMDFileMemory >> at: anInteger ifAbsent: aBlock [
	^ values at: anInteger ifAbsent: aBlock
]

{ #category : #accessing }
RMDFileMemory >> at: anInteger put: aNumber [
	^ values at: anInteger put: aNumber
]

{ #category : #'accessing-storage' }
RMDFileMemory >> basePath [
	^ basePath
]

{ #category : #'accessing-storage' }
RMDFileMemory >> basePath: aFileReference [
	basePath := aFileReference
		ensureCreateDirectory;
		yourself
]

{ #category : #defaults }
RMDFileMemory >> defaultDigitsForTime [
	^ 3
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

{ #category : #timing }
RMDFileMemory >> fastSunrise [ 
	oldValues := values.
	values := Dictionary new
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
	digitsPerDirectoryLevel := self defaultDigitsPerDirectoryLevel.
	values := Dictionary new.
	oldValues := Dictionary new
]

{ #category : #accessing }
RMDFileMemory >> oldAt: anInteger ifAbsent: errorBlock [
	^ oldValues at: anInteger ifAbsent: errorBlock
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

{ #category : #timing }
RMDFileMemory >> sunrise [
	oldValues := self readValuesForTime: time - 1.
	values := self readValuesForTime: time
]

{ #category : #timing }
RMDFileMemory >> sunset [
	self writeValues: values forTime: time
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
