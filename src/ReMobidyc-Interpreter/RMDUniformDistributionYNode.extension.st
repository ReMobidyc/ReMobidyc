Extension { #name : #RMDUniformDistributionYNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionYNode >> evalIn: aRMDInterpreter [
	^ (aRMDInterpreter north - aRMDInterpreter south)
		* aRMDInterpreter random + aRMDInterpreter south
]
