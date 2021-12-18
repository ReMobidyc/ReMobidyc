Extension { #name : #RMDNewPropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewPropertyVariableNode >> evalIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewPropertyVariableNode >> typecheckIn: aRMDInterpreter [
	^ aRMDInterpreter
		typeOfVariable: identifier
		agent: self agent
		ifAbsent: [ (RMDUnresolvedReferenceError on: self) signal ]
]
