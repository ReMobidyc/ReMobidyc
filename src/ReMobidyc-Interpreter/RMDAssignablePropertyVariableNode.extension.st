Extension { #name : #RMDAssignablePropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignablePropertyVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toVariable: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]
