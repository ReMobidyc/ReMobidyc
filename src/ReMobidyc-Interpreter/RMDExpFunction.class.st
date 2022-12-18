Class {
	#name : #RMDExpFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDExpFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDExpFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

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
RMDExpFunction >> value: aNumber [
	^ aNumber exp
]
