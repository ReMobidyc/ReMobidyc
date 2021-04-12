Extension { #name : #RMDUniformDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionNode >> evalIn: aRMDInterpreter [
	^ (toLiteral numeric - fromLiteral numeric) * aRMDInterpreter random
		+ fromLiteral numeric
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionNode >> typecheckIn: aRMDInterpreter [
	^ (fromLiteral typecheckIn: aRMDInterpreter)
		unify: (toLiteral typecheckIn: aRMDInterpreter)
]
