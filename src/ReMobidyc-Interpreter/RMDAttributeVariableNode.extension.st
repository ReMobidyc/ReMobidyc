Extension { #name : #RMDAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter
		  readVariable: identifier
		  agent: agent
		  ifAbsent: [ RMDUnresolvedAttributeReferenceError signal: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> typecheckIn: aRMDInterpreter [

	^ aRMDInterpreter
		  typeOfVariable: identifier
		  agent: agent
		  ifAbsent: [ RMDUnresolvedAttributeReferenceError signal: self ]
]
