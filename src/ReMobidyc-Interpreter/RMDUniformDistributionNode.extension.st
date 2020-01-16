Extension { #name : #RMDUniformDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionNode >> evalIn: aRMDInterpreter [
	^ (toLiteral numeric - fromLiteral numeric)
		* SharedRandom globalGenerator next + fromLiteral numeric
]
