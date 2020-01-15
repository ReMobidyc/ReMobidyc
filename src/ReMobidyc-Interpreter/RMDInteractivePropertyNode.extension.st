Extension { #name : #RMDInteractivePropertyNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDInteractivePropertyNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter directive: identifier object: agentIdentifier
]
