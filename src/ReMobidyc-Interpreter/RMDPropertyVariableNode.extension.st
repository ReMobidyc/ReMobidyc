Extension { #name : #RMDPropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]
