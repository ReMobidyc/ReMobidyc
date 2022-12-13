Class {
	#name : #RMDCeilingFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDCeilingFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [
	anArrayOfRMDExpression size = 1
		ifFalse: [ ^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDCeilingFunction >> value: aNumber [
	^ aNumber ceiling asFloat
]
