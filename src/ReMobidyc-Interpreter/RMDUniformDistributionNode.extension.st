Extension { #name : #RMDUniformDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionNode >> evalIn: aRMDInterpreter [
	^ (toLiteral numeric - fromLiteral numeric) * aRMDInterpreter random
		+ fromLiteral numeric
]
