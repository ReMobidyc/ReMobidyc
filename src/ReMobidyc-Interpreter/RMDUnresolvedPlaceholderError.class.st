Class {
	#name : 'RMDUnresolvedPlaceholderError',
	#superclass : 'RMDUnresolvedReferenceError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDUnresolvedPlaceholderError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Unresolved placeholder: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
