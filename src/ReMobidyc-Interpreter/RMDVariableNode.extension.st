Extension { #name : #RMDVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toVariable: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]
