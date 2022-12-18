Class {
	#name : #RMDUndefinedAnimatError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDUndefinedAnimatError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined animat: '.
		  node printOn: stream.
		  stream nextPutAll: '.' ]
]
