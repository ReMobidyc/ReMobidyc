Class {
	#name : #RMDPositiveFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDPositiveFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDPositiveFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: self
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #evaluating }
RMDPositiveFunction >> value: aNumber [

	^ aNumber >= 0
		  ifTrue: [ aNumber ]
		  ifFalse: [ aNumber class zero ]
]
