Class {
	#name : 'RMDSquareRootFunction',
	#superclass : 'RMDFunction',
	#category : 'ReMobidyc-Interpreter-Libraries',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Libraries'
}

{ #category : 'accessing' }
RMDSquareRootFunction >> expectedNumArgs [

	^ 1
]

{ #category : 'type checking' }
RMDSquareRootFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: aRMDApplyNode
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	^ RMDType unit:
		  (anArrayOfRMDExpression first typecheckIn: aRMDInterpreter) unit
		  ** (1 / 2)
]

{ #category : 'accessing' }
RMDSquareRootFunction >> value: aNumber [

	^ aNumber sqrt
]
