Class {
	#name : #RMDPositiveFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDPositiveFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #evaluating }
RMDPositiveFunction >> value: aNumber [

	^ aNumber >= 0
		  ifTrue: [ aNumber ]
		  ifFalse: [ aNumber class zero ]
]
