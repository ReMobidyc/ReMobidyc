Extension { #name : #RMDVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]
