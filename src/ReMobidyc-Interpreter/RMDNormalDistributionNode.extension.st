Extension { #name : #RMDNormalDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNormalDistributionNode >> evalIn: aRMDInterpreter [

	^ (aRMDInterpreter random ln * -2.0) sqrt
	  * (aRMDInterpreter random * Float pi * 2.0) cos
	  * (sigmaExpression evalIn: aRMDInterpreter)
	  + (meanExpression evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNormalDistributionNode >> typecheckIn: aRMDInterpreter [
	^ [ (meanExpression typecheckIn: aRMDInterpreter)
		unify: (sigmaExpression typecheckIn: aRMDInterpreter) ]
		on: RMDTypeUnificationError
		do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
