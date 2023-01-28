Class {
	#name : #RMDSyntaxError,
	#superclass : #RMDError,
	#instVars : [
		'failure'
	],
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #signalling }
RMDSyntaxError class >> failure: aPetit2Failure [

	^ self new
		  failure: aPetit2Failure;
		  yourself
]

{ #category : #signalling }
RMDSyntaxError class >> signal: aPetit2Failure [

	^ (self failure: aPetit2Failure) signal: aPetit2Failure printString
]

{ #category : #private }
RMDSyntaxError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Syntax error: '.
		  failure printOn: stream ]
]

{ #category : #accessing }
RMDSyntaxError >> failure [

	^ failure
]

{ #category : #accessing }
RMDSyntaxError >> failure: aPetit2Failure [

	failure := aPetit2Failure
]
