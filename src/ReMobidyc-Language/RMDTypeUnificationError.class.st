Class {
	#name : #RMDTypeUnificationError,
	#superclass : #Exception,
	#instVars : [
		'type1',
		'type2'
	],
	#category : #'ReMobidyc-Language-Type'
}

{ #category : #'instance creation' }
RMDTypeUnificationError class >> on: aRMDType and: anotherRMDType [
	^ self new
		type1: aRMDType;
		type2: anotherRMDType;
		messageText: aRMDType printString , ' and ' , anotherRMDType printString;
		yourself
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
