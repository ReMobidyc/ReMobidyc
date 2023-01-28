Class {
	#name : #RMDTimeChanged,
	#superclass : #RMDSimulationAnnouncement,
	#instVars : [
		'time'
	],
	#category : #'ReMobidyc-Interpreter-Announcements'
}

{ #category : #'instance creation' }
RMDTimeChanged class >> interpreter: aRMDInterpreter time: aNumber [

	^ (self interpreter: aRMDInterpreter)
		  time: aNumber;
		  yourself
]

{ #category : #printing }
RMDTimeChanged >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: (interpreter ifNotNil: #shortName ifNil: [ '-' ]);
		nextPutAll: ':'.
	time printOn: aStream.
	time ifNotNil: [ 
		aStream nextPutAll: ' [s], '.
		(RMDUnit day fromSI: time) printOn: aStream showingDecimalPlaces: 3.
		aStream nextPutAll: ' [day], '.
		(RMDUnit year fromSI: time) printOn: aStream showingDecimalPlaces: 3.
		aStream nextPutAll: ' [year]' ].
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
