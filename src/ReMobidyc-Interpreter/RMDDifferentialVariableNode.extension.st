Extension { #name : #RMDDifferentialVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDifferentialVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readDifferential: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]
