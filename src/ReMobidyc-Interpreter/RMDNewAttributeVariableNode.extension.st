Extension { #name : #RMDNewAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> evalIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> typecheckIn: aRMDInterpreter [
	^ aRMDInterpreter
		typeOfVariable: identifier
		agent: self agent
		ifAbsent: [ (RMDUnresolvedReferenceError on: self) signal ]
]
