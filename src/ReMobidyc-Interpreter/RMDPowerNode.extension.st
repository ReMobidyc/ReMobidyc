Extension { #name : #RMDPowerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPowerNode >> evalIn: aRMDInterpreter [
	^ (expression evalIn: aRMDInterpreter) ** order
]
