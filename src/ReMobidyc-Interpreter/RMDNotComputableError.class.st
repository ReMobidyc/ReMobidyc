Class {
	#name : #RMDNotComputableError,
	#superclass : #RMDSemanticError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDNotComputableError >> composeMessageText [

	^ node printString, ' is not computable.'
]
