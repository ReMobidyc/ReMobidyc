Class {
	#name : 'RMDUnresolvedObjectError',
	#superclass : 'RMDUnresolvedReferenceError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDUnresolvedObjectError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  node printOn: stream.
		  stream nextPutAll: ' needs animat.' ]
]
