Extension { #name : #RMDGammaDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaDistributionNode >> evalIn: aRMDInterpreter [

	^ (self
		   gamma: (shapeExpression evalIn: aRMDInterpreter)
		   in: aRMDInterpreter) * (scaleExpression evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaDistributionNode >> typecheckIn: aRMDInterpreter [

	[ 
	(scaleExpression typecheckIn: aRMDInterpreter) unify:
		RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
		ex resignalAs: (RMDTypeError on: scaleExpression with: ex type1) ].
	^ [ shapeExpression typecheckIn: aRMDInterpreter ]
		  on: RMDTypeUnificationError
		  do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
