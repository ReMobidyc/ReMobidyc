Class {
	#name : #RMDRecursionError,
	#superclass : #RMDSemanticError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDRecursionError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Mutual recursion in "'.
		  node name printOn: stream.
		  stream nextPutAll: '" .' ]
]
