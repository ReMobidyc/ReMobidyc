Extension { #name : #RMDDeltaVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDeltaVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDelta: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]
