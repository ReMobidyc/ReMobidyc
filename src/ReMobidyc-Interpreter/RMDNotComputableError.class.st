Class {
	#name : #RMDNotComputableError,
	#superclass : #RMDSemanticError,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDNotComputableError >> composeMessageText [

	^ 'Infinity occured: ' , node printString
]
