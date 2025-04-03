Class {
	#name : 'RMDUnresolvedReferenceError',
	#superclass : 'RMDRuntimeError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'testing' }
RMDUnresolvedReferenceError class >> isAbstract [

	^ self == RMDUnresolvedReferenceError
]
