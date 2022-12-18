Class {
	#name : #RMDSinFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDSinFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDSinFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: self
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	[ 
	(anArrayOfRMDExpression first typecheckIn: aRMDInterpreter) unify:
		RMDType rad ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: anArrayOfRMDExpression first
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	^ RMDType noDimension
]

{ #category : #accessing }
RMDSinFunction >> value: aNumber [
	^ aNumber sin
]
