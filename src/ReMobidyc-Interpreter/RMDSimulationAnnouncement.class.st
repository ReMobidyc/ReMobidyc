Class {
	#name : 'RMDSimulationAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'interpreter'
	],
	#category : 'ReMobidyc-Interpreter-Announcements',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Announcements'
}

{ #category : 'instance creation' }
RMDSimulationAnnouncement class >> interpreter: aRMDInterpreter [

	^ self new
		  interpreter: aRMDInterpreter;
		  yourself
]

{ #category : 'accessing' }
RMDSimulationAnnouncement >> interpreter [

	^ interpreter
]

{ #category : 'accessing' }
RMDSimulationAnnouncement >> interpreter: aRMDInterpreter [

	interpreter := aRMDInterpreter
]

{ #category : 'printing' }
RMDSimulationAnnouncement >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: (interpreter ifNotNil: #shortName ifNil: [ '-' ]);
		nextPutAll: ')'
]
