Class {
	#name : #RMDTimeChanged,
	#superclass : #Announcement,
	#instVars : [
		'time'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDTimeChanged class >> time: aNumber [
	^ self new
		time: aNumber;
		yourself
]

{ #category : #printing }
RMDTimeChanged >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(.
	time printOn: aStream.
	time
		ifNotNil: [ aStream nextPutAll: ', '.
			(RMDUnit day fromSI: time) printOn: aStream showingDecimalPlaces: 3.
			aStream nextPutAll: ' [day], '.
			(RMDUnit year fromSI: time)
				printOn: aStream
				showingDecimalPlaces: 3.
			aStream nextPutAll: ' [year], ' ].
	aStream nextPut: $)
]

{ #category : #accessing }
RMDTimeChanged >> time [
	^ time
]

{ #category : #accessing }
RMDTimeChanged >> time: aNumber [
	time := aNumber
]
