Class {
	#name : #RMDExpFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDExpFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	| argType |
	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	argType := anArrayOfRMDExpression first typecheckIn: aRMDInterpreter.
	argType unify: RMDType noDimension.
	^ RMDType noDimension
]

{ #category : #accessing }
RMDExpFunction >> value: aNumber [
	^ aNumber exp
]
