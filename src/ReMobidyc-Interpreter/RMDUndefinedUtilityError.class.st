Class {
	#name : #RMDUndefinedUtilityError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDUndefinedUtilityError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined utility: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
