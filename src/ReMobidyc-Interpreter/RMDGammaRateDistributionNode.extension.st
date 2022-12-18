Extension { #name : #RMDGammaRateDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaRateDistributionNode >> evalIn: aRMDInterpreter [

	^ (super evalIn: aRMDInterpreter)
	  / (rateExpression evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaRateDistributionNode >> typecheckIn: aRMDInterpreter [

	super typecheckIn: aRMDInterpreter.
	^ [ 
	  (rateExpression typecheckIn: aRMDInterpreter) unify:
		  RMDType noDimension ]
		  on: RMDTypeUnificationError
		  do: [ :ex | 
			  ex resignalAs: (RMDTypeError
					   on: self
					   subnode: rateExpression
					   type: ex type1
					   subnode: self
					   type: ex type2) ]
]
