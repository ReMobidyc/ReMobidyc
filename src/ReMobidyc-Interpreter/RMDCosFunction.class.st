Class {
	#name : #RMDCosFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter-Libraries'
}

{ #category : #accessing }
RMDCosFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDCosFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: aRMDApplyNode
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	[ 
	(anArrayOfRMDExpression first typecheckIn: aRMDInterpreter) unify:
		RMDType rad ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: aRMDApplyNode
					 subnode: anArrayOfRMDExpression first
					 type: ex type1
					 subnode: aRMDApplyNode
					 type: ex type2) ].
	^ RMDType noDimension
]

{ #category : #accessing }
RMDCosFunction >> value: aNumber [
	^ aNumber cos
]
