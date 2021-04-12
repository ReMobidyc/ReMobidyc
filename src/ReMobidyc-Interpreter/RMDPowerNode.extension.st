Extension { #name : #RMDPowerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPowerNode >> evalIn: aRMDInterpreter [
	^ (expression evalIn: aRMDInterpreter) ** order
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDPowerNode >> typecheckIn: aRMDInterpreter [
	^ RMDType
		unit: (expression typecheckIn: aRMDInterpreter) unit ** order
]
