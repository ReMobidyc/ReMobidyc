Class {
	#name : #RMDPowerFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDPowerFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	| argType1 argType2 |
	anArrayOfRMDExpression size = 2 ifFalse: [ 
		^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	argType1 := anArrayOfRMDExpression first typecheckIn: aRMDInterpreter.
	argType1 unify: RMDType noDimension.
	argType2 := anArrayOfRMDExpression first typecheckIn: aRMDInterpreter.
	argType2 unify: RMDType noDimension.
	^ RMDType noDimension
]

{ #category : #evaluating }
RMDPowerFunction >> value: aNumber1 value: aNumber2 [

	^ aNumber1 ** aNumber2
]
