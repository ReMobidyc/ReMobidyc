Class {
	#name : 'RMDUndefinedAttributeError',
	#superclass : 'RMDUnresolvedReferenceError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDUndefinedAttributeError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined attribute: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
