Extension { #name : #RMDNewAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> evalIn: aRMDInterpreter [

	^ RMDUndefinedAttributeError signal: self
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> typecheckIn: aRMDInterpreter [

	^ aRMDInterpreter
		  typeOfVariable: identifier
		  agent: self agent
		  ifAbsent: [ RMDUndefinedAttributeError signal: self ]
]
