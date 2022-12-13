Class {
	#name : #RMDRoundFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDRoundFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [
	anArrayOfRMDExpression size = 1
		ifFalse: [ ^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDRoundFunction >> value: aNumber [
	^ aNumber rounded asFloat
]
