Class {
	#name : #RMDLnFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDLnFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	| argType |
	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	argType := anArrayOfRMDExpression first typecheckIn: aRMDInterpreter.
	argType unify: RMDType noDimension.
	^ RMDType noDimension
]

{ #category : #accessing }
RMDLnFunction >> value: aNumber [

	^ aNumber >= 0
		  ifTrue: [ aNumber ln ]
		  ifFalse: [ 
			  ArithmeticError signal:
				  'A non-negative number should be given to the logarithm function.' ]
]
