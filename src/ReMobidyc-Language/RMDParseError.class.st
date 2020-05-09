Class {
	#name : #RMDParseError,
	#superclass : #Error,
	#instVars : [
		'petit2failure'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #signalling }
RMDParseError class >> signalPP2Failure: aPP2Failure [
	^ self new
		petit2failure: aPP2Failure;
		signal: aPP2Failure message
]

{ #category : #accessing }
RMDParseError >> petit2failure [
	^ petit2failure
]

{ #category : #accessing }
RMDParseError >> petit2failure: aPP2Failure [
	petit2failure := aPP2Failure
]
