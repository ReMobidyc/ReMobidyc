Extension { #name : #RMDPropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal: self printString ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyVariableNode >> typecheckIn: aRMDInterpreter [
	^ aRMDInterpreter
		typeOfVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal: self printString ]
]
