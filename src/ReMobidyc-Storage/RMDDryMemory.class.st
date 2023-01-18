Class {
	#name : #RMDDryMemory,
	#superclass : #RMDMemory,
	#category : #'ReMobidyc-Storage'
}

{ #category : #testing }
RMDDryMemory >> isRewindable [

	^ false
]

{ #category : #'accessing-storage' }
RMDDryMemory >> readAnimatsForTime: anInteger [

	^ Dictionary new 
]

{ #category : #'accessing-storage' }
RMDDryMemory >> readReproductionLinksForTime: anInteger [

	^ Dictionary new
]

{ #category : #'accessing-storage' }
RMDDryMemory >> readSeedsForTime: anInteger [

	^ Dictionary new 
]

{ #category : #'accessing-storage' }
RMDDryMemory >> readStageLinksForTime: anInteger [

	^ Dictionary new
]

{ #category : #'accessing-storage' }
RMDDryMemory >> readValuesForTime: anInteger [

	^  Dictionary new 
]

{ #category : #'accessing-storage' }
RMDDryMemory >> recordError [
	^ RMDStorageError signal: 'Unable to record timed data on this storage.'
]

{ #category : #'accessing-storage' }
RMDDryMemory >> rewindError [
	^ RMDStorageError signal: 'Unable to rewind time on this storage.'
]

{ #category : #timing }
RMDDryMemory >> sunrise [
	self fastSunrise
]

{ #category : #'accessing-storage' }
RMDDryMemory >> writeAnimats: aDictionary forTime: anInteger [

	
]

{ #category : #'accessing-storage' }
RMDDryMemory >> writeReproductionLinks: aDictionary forTime: anInteger [

	
]

{ #category : #'accessing-storage' }
RMDDryMemory >> writeSeeds: aDictionary forTime: anInteger [

	
]

{ #category : #'accessing-storage' }
RMDDryMemory >> writeStageLinks: aDictionary forTime: anInteger [

	
]

{ #category : #'accessing-storage' }
RMDDryMemory >> writeValues: aDictionary forTime: anInteger [

	
]
