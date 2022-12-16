Extension { #name : #RMDNewAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> evalIn: aRMDInterpreter [

	^ RMDUnresolvedAttributeReferenceError signal: self
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> typecheckIn: aRMDInterpreter [

	^ aRMDInterpreter
		  typeOfVariable: identifier
		  agent: self agent
		  ifAbsent: [ RMDUnresolvedAttributeReferenceError signal: self ]
]
