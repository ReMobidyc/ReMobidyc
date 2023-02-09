Class {
	#name : #RMDReadOnlyFileMemory,
	#superclass : #RMDFileMemory,
	#instVars : [
		'numberOfAnimats'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #private }
RMDReadOnlyFileMemory >> animats [

	^ animats ifNil: [ animats := self readAnimatsForTime: time ]
]

{ #category : #timing }
RMDReadOnlyFileMemory >> fastSunrise [

	self sunrise
]

{ #category : #private }
RMDReadOnlyFileMemory >> loadValues [

	values := self readValuesForTime: time.
	nextValues := values copy.
	nextDeltas := Dictionary new
]

{ #category : #private }
RMDReadOnlyFileMemory >> nextDeltas [

	nextDeltas ifNil: [ self loadValues ].
	^ nextDeltas
]

{ #category : #private }
RMDReadOnlyFileMemory >> nextValues [

	nextValues ifNil: [ self loadValues ].
	^ nextValues
]

{ #category : #'accessing-individuals' }
RMDReadOnlyFileMemory >> numberOfAnimats: aString [

	^ animats ifNotNil: [ super numberOfAnimats: aString ] ifNil: [ 
		  (numberOfAnimats ifNil: [ 
			   numberOfAnimats := self readNumberOfAnimatsForTime: time ])
			  at: aString
			  ifAbsent: [ 0 ] ]
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> readNumberOfAnimatsForTime: anInteger [

	| ref |
	ref := (self directoryForTime: anInteger) / self animatsFileBasename.
	ref exists ifFalse: [ ^ Dictionary new ].
	ref binaryReadStreamDo: [ :stream | 
		| vals |
		vals := Dictionary new.
		[ stream atEnd ] whileFalse: [ 
			| len animat |
			len := stream uint32.
			animat := (stream next: len) utf8Decoded.
			len := stream uint32.
			vals at: animat put: len.
			stream skip: len * 4 ].
		^ vals ]
]

{ #category : #private }
RMDReadOnlyFileMemory >> reproductionLinks [

	^ reproductionLinks ifNil: [ 
		  reproductionLinks := self readReproductionLinksForTime: time ]
]

{ #category : #private }
RMDReadOnlyFileMemory >> seeds [

	^ seeds ifNil: [ seeds := self readSeedsForTime: time ]
]

{ #category : #private }
RMDReadOnlyFileMemory >> stageLinks [

	^ stageLinks ifNil: [ stageLinks := self readStageLinksForTime: time ]
]

{ #category : #timing }
RMDReadOnlyFileMemory >> sunrise [

	values := nil.
	nextValues := nil.
	nextDeltas := nil.
	animats := nil.
	seeds := nil.
	stageLinks := nil.
	reproductionLinks := nil.
	numberOfAnimats := nil.
	animatsInPatch := nil
]

{ #category : #timing }
RMDReadOnlyFileMemory >> sunset [

	
]

{ #category : #timing }
RMDReadOnlyFileMemory >> time: anInteger [

	time ~= anInteger ifTrue: [ super time: anInteger ]
]

{ #category : #private }
RMDReadOnlyFileMemory >> values [

	values ifNil: [ self loadValues ].
	^ values
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeAllocation [
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeAnimats: aDictionary forTime: anInteger [
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeMetaparameters [
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeReproductionLinks: aDictionary forTime: anInteger [
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeSeeds: aDictionary forTime: anInteger [
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeSpace [
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeStageLinks: aDictionary forTime: anInteger [
]

{ #category : #'accessing-storage' }
RMDReadOnlyFileMemory >> writeValues: aDictionary forTime: anInteger [
]
