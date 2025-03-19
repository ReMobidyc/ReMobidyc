Class {
	#name : 'RMDPositiveFunction',
	#superclass : 'RMDFunction',
	#category : 'ReMobidyc-Interpreter-Libraries',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Libraries'
}

{ #category : 'accessing' }
RMDPositiveFunction >> expectedNumArgs [

	^ 1
]

{ #category : 'type checking' }
RMDPositiveFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: aRMDApplyNode
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : 'evaluating' }
RMDPositiveFunction >> value: aNumber [

	^ aNumber >= 0
		  ifTrue: [ aNumber ]
		  ifFalse: [ aNumber class zero ]
]
