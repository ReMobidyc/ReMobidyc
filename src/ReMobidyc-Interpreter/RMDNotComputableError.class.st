Class {
	#name : #RMDNotComputableError,
	#superclass : #RMDRuntimeError,
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #private }
RMDNotComputableError >> composeMessageText [

	^ node printString, ' is not computable.'
]
