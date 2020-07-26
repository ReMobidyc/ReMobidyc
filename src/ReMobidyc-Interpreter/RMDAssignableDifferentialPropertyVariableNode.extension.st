Extension { #name : #RMDAssignableDifferentialPropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialPropertyVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDifferential: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]
