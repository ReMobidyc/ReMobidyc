Class {
	#name : #RMDClientRunInfo,
	#superclass : #Object,
	#instVars : [
		'runId',
		'token',
		'lastUpdateTime'
	],
	#category : #'ReMobidyc-Client'
}

{ #category : #'instance creation' }
RMDClientRunInfo class >> fromJson: aDictionary [
	^ self new
		runId: (aDictionary at: 'id' ifAbsent: [ nil ]);
		token: (aDictionary at: 'token' ifAbsent: [ nil ]);
		yourself
]

{ #category : #initialization }
RMDClientRunInfo >> initialize [
	super initialize.
	self touch
]

{ #category : #accessing }
RMDClientRunInfo >> lastUpdateTime [
	^ lastUpdateTime
]

{ #category : #accessing }
RMDClientRunInfo >> lastUpdateTime: aDateAndTime [
	lastUpdateTime := aDateAndTime
]

{ #category : #accessing }
RMDClientRunInfo >> runId [
	^ runId
]

{ #category : #accessing }
RMDClientRunInfo >> runId: aString [
	runId := aString asString
]

{ #category : #accessing }
RMDClientRunInfo >> token [
	^ token
]

{ #category : #accessing }
RMDClientRunInfo >> token: aString [
	token := aString asString
]

{ #category : #accessing }
RMDClientRunInfo >> touch [
	lastUpdateTime := DateAndTime now
]
