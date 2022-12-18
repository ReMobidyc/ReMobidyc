Class {
	#name : #RMDUnresolvedPlaceholderError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDUnresolvedPlaceholderError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Unresolved placeholder: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
