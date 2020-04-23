Extension { #name : #RMDDifferentialVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDifferentialVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDifferential: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]
