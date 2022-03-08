Extension { #name : #RMDNormalDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNormalDistributionNode >> evalIn: aRMDInterpreter [

	^ (aRMDInterpreter random ln * -2.0) sqrt
	  * (aRMDInterpreter random * Float pi * 2.0) cos
	  * sigmaLiteral numeric + meanLiteral numeric
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNormalDistributionNode >> typecheckIn: aRMDInterpreter [
	^ [ (meanLiteral typecheckIn: aRMDInterpreter)
		unify: (sigmaLiteral typecheckIn: aRMDInterpreter) ]
		on: RMDTypeUnificationError
		do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
