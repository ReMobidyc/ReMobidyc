Class {
	#name : #RMDLnFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDLnFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDLnFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: self
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	[ 
	^ (anArrayOfRMDExpression first typecheckIn: aRMDInterpreter) unify:
		  RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: anArrayOfRMDExpression first
					 type: ex type1
					 subnode: self
					 type: ex type2) ]
]

{ #category : #accessing }
RMDLnFunction >> value: aNumber [

	^ aNumber >= 0
		  ifTrue: [ aNumber ln ]
		  ifFalse: [ 
			  ArithmeticError signal:
				  'A non-negative number should be given to the logarithm function.' ]
]
