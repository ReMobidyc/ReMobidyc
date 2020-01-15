Extension { #name : #RMDDifferential2VariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDifferential2VariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readDifferential2: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]
