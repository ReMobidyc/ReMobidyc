Class {
	#name : #RMDOnMemory,
	#superclass : #RMDMemory,
	#instVars : [
		'valuesStorage',
		'animatsStorage',
		'stagesStorage'
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
	valuesStorage := (Array new: anInteger)
		replaceFrom: 1
		to: (anInteger min: valuesStorage size)
		with: valuesStorage
		startingAt: 1.
	animatsStorage := (Array new: anInteger)
		replaceFrom: 1
		to: (anInteger min: animatsStorage size)
		with: animatsStorage
		startingAt: 1.
	stagesStorage := (Array new: anInteger)
		replaceFrom: 1
		to: (anInteger min: stagesStorage size)
		with: stagesStorage
		startingAt: 1
]

{ #category : #private }
RMDOnMemory >> deepCopyAnimats: aDictionary [

	| copy |
	copy := Dictionary new: aDictionary size.
	aDictionary keysAndValuesDo: [ :animatName :individuals | 
		copy at: animatName put: individuals copy ].
	^ copy
]

{ #category : #initialization }
RMDOnMemory >> initialize [
	super initialize.
	valuesStorage := Array new: 1024.
	animatsStorage := Array new: 1024.
	stagesStorage := Array new: 1024.

]

{ #category : #'accessing-storage' }
RMDOnMemory >> readAnimatsForTime: anInteger [

	anInteger >= animatsStorage size ifTrue: [ 
		self changeStorageCapacityTo: anInteger + 1024 ].
	^ (animatsStorage at: anInteger + 1 ifAbsent: [ nil ])
		  ifNotNil: [ :dict | self deepCopyAnimats: dict ]
		  ifNil: [ Dictionary new ]
]

{ #category : #'accessing-storage' }
RMDOnMemory >> readValuesForTime: anInteger [
	anInteger >= valuesStorage size
		ifTrue: [ self changeStorageCapacityTo: anInteger + 1024 ].
	^ (valuesStorage at: anInteger + 1 ifAbsent: [ nil ])
		ifNotNil: [ :dict | dict copy ]
		ifNil: [ Dictionary new ]
]

{ #category : #'accessing-storage' }
RMDOnMemory >> writeAnimats: aDictionary forTime: anInteger [

	anInteger >= animatsStorage size ifTrue: [ 
		self changeStorageCapacityTo: anInteger + 1024 ].
	^ animatsStorage
		  at: anInteger + 1
		  put: (self deepCopyAnimats: aDictionary)
]

{ #category : #'accessing-storage' }
RMDOnMemory >> writeValues: aDictionary forTime: anInteger [
	anInteger >= valuesStorage size
		ifTrue: [ self changeStorageCapacityTo: anInteger + 1024 ].
	^ valuesStorage at: anInteger + 1 put: aDictionary copy
]
