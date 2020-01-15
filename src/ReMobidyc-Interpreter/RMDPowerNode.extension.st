Extension { #name : #RMDPowerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPowerNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		** (expression2 evalIn: aRMDInterpreter)
]
