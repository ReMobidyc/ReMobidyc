Class {
	#name : #RMDUnresolvedAttributeReferenceError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDUnresolvedAttributeReferenceError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Unresolved attribute reference: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
