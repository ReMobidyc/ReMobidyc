Extension { #name : #RMDAgentDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentDirectiveNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter directive: directive object: agentIdentifier
]
