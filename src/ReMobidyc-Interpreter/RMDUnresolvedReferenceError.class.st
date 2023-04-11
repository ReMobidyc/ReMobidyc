Class {
	#name : #RMDUnresolvedReferenceError,
	#superclass : #RMDSemanticError,
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #testing }
RMDUnresolvedReferenceError class >> isAbstract [

	^ self == RMDUnresolvedReferenceError
]
