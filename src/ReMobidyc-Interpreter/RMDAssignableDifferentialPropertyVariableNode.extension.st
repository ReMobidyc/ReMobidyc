Extension { #name : #RMDAssignableDifferentialPropertyVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialPropertyVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDifferential: self identifier
		agent: self agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialPropertyVariableNode >> typecheckIn: aRMDInterpreter [
	^ RMDType
		unit: (propertyVariable typecheckIn: aRMDInterpreter) unit / RMDUnit s
]
