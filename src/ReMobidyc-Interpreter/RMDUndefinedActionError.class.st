Class {
	#name : 'RMDUndefinedActionError',
	#superclass : 'RMDUnresolvedReferenceError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDUndefinedActionError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined action: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
