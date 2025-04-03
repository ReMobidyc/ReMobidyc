Class {
	#name : 'RMDRecursionError',
	#superclass : 'RMDRuntimeError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDRecursionError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Mutual recursion in "'.
		  node name printOn: stream.
		  stream nextPutAll: '" .' ]
]
