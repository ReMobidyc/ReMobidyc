Class {
	#name : #RMDSquareRootFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDSquareRootFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	^ RMDType unit:
		  (anArrayOfRMDExpression first typecheckIn: aRMDInterpreter) unit
		  ** (1 / 2)
]

{ #category : #accessing }
RMDSquareRootFunction >> value: aNumber [

	^ aNumber sqrt
]
