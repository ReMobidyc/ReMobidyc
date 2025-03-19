Class {
	#name : 'RMDGaussianFunction',
	#superclass : 'RMDFunction',
	#category : 'ReMobidyc-Interpreter-Libraries',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Libraries'
}

{ #category : 'accessing' }
RMDGaussianFunction >> expectedNumArgs [

	^ 4
]

{ #category : 'type checking' }
RMDGaussianFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	| type |
	anArrayOfRMDExpression size = 4 ifFalse: [
		^ RMDNumArgsError
			  signal: aRMDApplyNode
			  actual: anArrayOfRMDExpression size
			  expected: 3 ].
	type := RMDType any.
	anArrayOfRMDExpression do: [ :expression |
		type := type unify: (expression typecheckIn: aRMDInterpreter) ].
	^ type
]

{ #category : 'accessing' }
RMDGaussianFunction >> value: a value: b value: c value: x [

	^ a * ((x - b) squared / (-2.0 * c squared)) exp
]
