Class {
	#name : 'RMDNotComputableError',
	#superclass : 'RMDRuntimeError',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDNotComputableError >> composeMessageText [

	^ node printString, ' is not computable.'
]
