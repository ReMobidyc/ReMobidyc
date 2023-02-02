Class {
	#name : #RMDNotComputableError,
	#superclass : #RMDSemanticError,
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #private }
RMDNotComputableError >> composeMessageText [

	^ node printString, ' is not computable.'
]
