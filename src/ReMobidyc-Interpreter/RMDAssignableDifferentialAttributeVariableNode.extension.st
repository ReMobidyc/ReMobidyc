Extension { #name : #RMDAssignableDifferentialAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> assign: aNumber in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toDifferential: self identifier
		  agent: self agent
		  ifAbsent: [ 
		  RMDUndefinedAttributeError signal: attributeVariable ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toDifferential: self identifier
		  agent: anInteger
		  ifAbsent: [ 
		  RMDUndefinedAttributeError signal: attributeVariable ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> typecheckIn: aRMDInterpreter [

	^ (attributeVariable typecheckIn: aRMDInterpreter) / RMDType s
]
