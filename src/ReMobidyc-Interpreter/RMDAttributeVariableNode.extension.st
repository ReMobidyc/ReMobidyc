Extension { #name : #RMDAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal: self printString ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> typecheckIn: aRMDInterpreter [
	^ aRMDInterpreter
		typeOfVariable: identifier
		agent: agent
		ifAbsent: [ (RMDUnresolvedReferenceError on: self) signal ]
]