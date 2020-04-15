Extension { #name : #RMDDifferentialVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDifferentialVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDifferential: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]
