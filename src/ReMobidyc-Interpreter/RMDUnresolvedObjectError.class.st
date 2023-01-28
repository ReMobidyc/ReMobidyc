Class {
	#name : #RMDUnresolvedObjectError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #private }
RMDUnresolvedObjectError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  node printOn: stream.
		  stream nextPutAll: ' needs animat.' ]
]
