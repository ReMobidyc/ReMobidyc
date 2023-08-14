Class {
	#name : #RMDUnresolvedReferenceError,
	#superclass : #RMDRuntimeError,
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #testing }
RMDUnresolvedReferenceError class >> isAbstract [

	^ self == RMDUnresolvedReferenceError
]
