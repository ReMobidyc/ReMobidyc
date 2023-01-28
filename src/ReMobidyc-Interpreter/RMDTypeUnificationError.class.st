Class {
	#name : #RMDTypeUnificationError,
	#superclass : #RMDError,
	#instVars : [
		'type1',
		'type2'
	],
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #'instance creation' }
RMDTypeUnificationError class >> on: aRMDType and: anotherRMDType [

	^ self type1: aRMDType type2: anotherRMDType
]

{ #category : #'instance creation' }
RMDTypeUnificationError class >> type1: aRMDType type2: anotherRMDType [
	^ self new
		type1: aRMDType;
		type2: anotherRMDType;
		messageText: aRMDType printString , ' and ' , anotherRMDType printString;
		yourself
]

{ #category : #private }
RMDTypeUnificationError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Unification error between '.
		  type1 printOn: stream.
		  stream nextPutAll: ' and '.
		  type2 printOn: stream.
		  stream nextPutAll: '.' ]
]

{ #category : #accessing }
RMDTypeUnificationError >> defaultAction [
	^ UnhandledError signalForException: self
]

{ #category : #accessing }
RMDTypeUnificationError >> type1 [
	^ type1
]

{ #category : #accessing }
RMDTypeUnificationError >> type1: aRMDType [
	type1 := aRMDType
]

{ #category : #accessing }
RMDTypeUnificationError >> type2 [
	^ type2
]

{ #category : #accessing }
RMDTypeUnificationError >> type2: aRMDType [
	type2 := aRMDType
]
