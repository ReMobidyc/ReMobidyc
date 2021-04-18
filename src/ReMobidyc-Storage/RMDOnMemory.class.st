Class {
	#name : #RMDOnMemory,
	#superclass : #RMDMemory,
	#instVars : [
		'storage'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #'instance creation' }
RMDOnMemory class >> new: anInteger [
	^ self new
		changeStorageCapacityTo: anInteger;
		yourself
]

{ #category : #private }
RMDOnMemory >> changeStorageCapacityTo: anInteger [
	storage := (Array new: anInteger)
		replaceFrom: 1
		to: (anInteger min: storage size)
		with: storage
		startingAt: 1
]

{ #category : #initialization }
RMDOnMemory >> initialize [
	super initialize.
	storage := Array new: 1024
]

{ #category : #timing }
RMDOnMemory >> latestTime [
	| index |
	index := storage findFirst: #isNil.
	^ index = 0
		ifTrue: [ storage size - 1 ]
		ifFalse: [ index - 2 max: 0 ]
]

{ #category : #'accessing-storage' }
RMDOnMemory >> readValuesForTime: anInteger [
	anInteger >= storage size
		ifTrue: [ self changeStorageCapacityTo: anInteger + 1024 ].
	^ (storage at: anInteger + 1 ifAbsent: [ nil ])
		ifNotNil: [ :dict | dict copy ]
		ifNil: [ Dictionary new ]
]

{ #category : #'accessing-storage' }
RMDOnMemory >> writeValues: aDictionary forTime: anInteger [
	anInteger >= storage size
		ifTrue: [ self changeStorageCapacityTo: anInteger + 1024 ].
	^ storage at: anInteger + 1 put: aDictionary copy
]
