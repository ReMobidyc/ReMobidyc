Extension { #name : #RMDDeltaVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDeltaVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDelta: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]
