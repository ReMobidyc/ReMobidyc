Extension { #name : #RMDUniformDistributionXNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionXNode >> evalIn: aRMDInterpreter [
	^ (aRMDInterpreter east - aRMDInterpreter west)
		* aRMDInterpreter random + aRMDInterpreter west
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionXNode >> typecheckIn: aRMDInterpreter [
	^ RMDType m
]
