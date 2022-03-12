Class {
	#name : #RMDSyntaxError,
	#superclass : #Error,
	#instVars : [
		'failure'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #signalling }
RMDSyntaxError class >> signal: aPetit2Failure [

	^ self new
		  failure: aPetit2Failure;
		  signal: aPetit2Failure printString
]

{ #category : #accessing }
RMDSyntaxError >> failure [

	^ failure
]

{ #category : #accessing }
RMDSyntaxError >> failure: aPetit2Failure [

	failure := aPetit2Failure
]
