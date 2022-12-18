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
RMDPowerFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 2 ifFalse: [ 
		^ RMDNumArgsError
			  signal: self
			  actual: anArrayOfRMDExpression size
			  expected: 2 ].
	[ 
	(anArrayOfRMDExpression first typecheckIn: aRMDInterpreter) unify:
		RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: anArrayOfRMDExpression first
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	[ 
	(anArrayOfRMDExpression second typecheckIn: aRMDInterpreter) unify:
		RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: anArrayOfRMDExpression second
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	^ RMDType noDimension
]

{ #category : #evaluating }
RMDPowerFunction >> value: aNumber1 value: aNumber2 [

	^ aNumber1 ** aNumber2
]
