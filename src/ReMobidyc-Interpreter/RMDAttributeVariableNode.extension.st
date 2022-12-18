Extension { #name : #RMDAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter
		  readVariable: identifier
		  agent: agent
		  ifAbsent: [ RMDUndefinedAttributeError signal: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> typecheckIn: aRMDInterpreter [

	^ aRMDInterpreter
		  typeOfVariable: identifier
		  agent: agent
		  ifAbsent: [ RMDUndefinedAttributeError signal: self ]
]
