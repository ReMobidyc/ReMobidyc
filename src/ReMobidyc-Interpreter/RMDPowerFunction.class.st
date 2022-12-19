Class {
	#name : #RMDPowerFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDPowerFunction >> expectedNumArgs [

	^ 2
]

{ #category : #'type checking' }
RMDPowerFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	anArrayOfRMDExpression size = 2 ifFalse: [ 
		^ RMDNumArgsError
			  signal: aRMDApplyNode
			  actual: anArrayOfRMDExpression size
			  expected: 2 ].
	[ 
	(anArrayOfRMDExpression first typecheckIn: aRMDInterpreter) unify:
		RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: aRMDApplyNode
					 subnode: anArrayOfRMDExpression first
					 type: ex type1
					 subnode: aRMDApplyNode
					 type: ex type2) ].
	[ 
	(anArrayOfRMDExpression second typecheckIn: aRMDInterpreter) unify:
		RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: aRMDApplyNode
					 subnode: anArrayOfRMDExpression second
					 type: ex type1
					 subnode: aRMDApplyNode
					 type: ex type2) ].
	^ RMDType noDimension
]

{ #category : #evaluating }
RMDPowerFunction >> value: aNumber1 value: aNumber2 [

	^ aNumber1 ** aNumber2
]
