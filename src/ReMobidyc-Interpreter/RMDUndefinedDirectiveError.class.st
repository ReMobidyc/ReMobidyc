Class {
	#name : #RMDUndefinedDirectiveError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDUndefinedDirectiveError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined directive: '.
		  node function printOn: stream.
		  stream nextPutAll: '.' ]
]
