Class {
	#name : #RMDUndefinedAttributeError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDUndefinedAttributeError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined attribute: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
