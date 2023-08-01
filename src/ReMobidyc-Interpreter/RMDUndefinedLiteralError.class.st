Class {
	#name : #RMDUndefinedLiteralError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #private }
RMDUndefinedLiteralError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined literal number: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
