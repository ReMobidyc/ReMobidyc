Class {
	#name : #RMDCeilingFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter-Libraries'
}

{ #category : #accessing }
RMDCeilingFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDCeilingFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: aRMDApplyNode
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDCeilingFunction >> value: aNumber [
	^ aNumber ceiling asFloat
]
