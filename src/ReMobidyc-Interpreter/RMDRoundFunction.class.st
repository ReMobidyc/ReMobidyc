Class {
	#name : #RMDRoundFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter-Libraries'
}

{ #category : #accessing }
RMDRoundFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDRoundFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: aRMDApplyNode
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDRoundFunction >> value: aNumber [
	^ aNumber rounded asFloat
]
