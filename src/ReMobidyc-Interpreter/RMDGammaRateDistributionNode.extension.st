Extension { #name : #RMDGammaRateDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaRateDistributionNode >> evalIn: aRMDInterpreter [

	^ (super evalIn: aRMDInterpreter)
	  * (rateExpression evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaRateDistributionNode >> typecheckIn: aRMDInterpreter [

	super typecheckIn: aRMDInterpreter.
	^ [ rateExpression typecheckIn: aRMDInterpreter ]
		  on: RMDTypeUnificationError
		  do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
