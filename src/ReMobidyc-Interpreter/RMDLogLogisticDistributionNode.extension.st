Extension { #name : #RMDLogLogisticDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDLogLogisticDistributionNode >> evalIn: aRMDInterpreter [

	| p |
	p := aRMDInterpreter random.
	^ (scaleExpression evalIn: aRMDInterpreter)
	  *
	  (p / (1 - p)
	   ** (shapeExpression evalIn: aRMDInterpreter) reciprocal)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLogLogisticDistributionNode >> typecheckIn: aRMDInterpreter [

	[ 
	(shapeExpression typecheckIn: aRMDInterpreter) unify:
		RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError on: shapeExpression with: ex type1) ].
	^ [ scaleExpression typecheckIn: aRMDInterpreter ]
		  on: RMDTypeUnificationError
		  do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
