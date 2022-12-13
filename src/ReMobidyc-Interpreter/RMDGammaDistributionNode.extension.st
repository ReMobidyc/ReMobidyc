Extension { #name : #RMDGammaDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaDistributionNode >> evalIn: aRMDInterpreter [

	^ self
		  gamma: (shapeExpression evalIn: aRMDInterpreter)
		  in: aRMDInterpreter
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaDistributionNode >> typecheckIn: aRMDInterpreter [

	^ [ shapeExpression typecheckIn: aRMDInterpreter ]
		  on: RMDTypeUnificationError
		  do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
