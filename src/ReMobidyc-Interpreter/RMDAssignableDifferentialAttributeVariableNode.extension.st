Extension { #name : #RMDAssignableDifferentialAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDifferential: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	^ aRMDInterpreter
		  write: aNumber
		  toDifferential: self identifier
		  agent: anInteger
		  ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> typecheckIn: aRMDInterpreter [
	^ RMDType
		unit: (attributeVariable typecheckIn: aRMDInterpreter) unit / RMDUnit s
]
