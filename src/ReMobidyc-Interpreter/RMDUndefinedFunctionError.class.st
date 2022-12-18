Class {
	#name : #RMDUndefinedFunctionError,
	#superclass : #RMDUnresolvedReferenceError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDUndefinedFunctionError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Undefined function: '.
		  node function printOn: stream.
		  stream nextPutAll: '.' ]
]
