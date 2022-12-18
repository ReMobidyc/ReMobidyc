Class {
	#name : #RMDAbsFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDAbsFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDAbsFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: self
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDAbsFunction >> value: aNumber [
	^ aNumber abs
]
