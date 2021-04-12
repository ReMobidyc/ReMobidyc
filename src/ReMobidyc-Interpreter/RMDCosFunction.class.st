Class {
	#name : #RMDCosFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDCosFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [
	| argType |
	anArrayOfRMDExpression size = 1
		ifFalse: [ ^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	argType := anArrayOfRMDExpression first typecheckIn: aRMDInterpreter.
	argType unify: RMDType rad.
	^ RMDType noDimension
]

{ #category : #accessing }
RMDCosFunction >> value: aNumber [
	^ aNumber cos
]
