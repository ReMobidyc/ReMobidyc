Extension { #name : #RMDAssignableAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableAttributeVariableNode >> assign: aNumber in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toVariable: self identifier
		  agent: self agent
		  ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableAttributeVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toVariable: self identifier
		  agent: anInteger
		  ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableAttributeVariableNode >> typecheckIn: aRMDInterpreter [
	^ attributeVariable typecheckIn: aRMDInterpreter
]
