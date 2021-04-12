Class {
	#name : #RMDAbsFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDAbsFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [
	anArrayOfRMDExpression size = 1
		ifFalse: [ ^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDAbsFunction >> value: aNumber [
	^ aNumber abs
]
