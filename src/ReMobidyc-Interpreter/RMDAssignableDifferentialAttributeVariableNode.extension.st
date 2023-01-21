Extension { #name : #RMDAssignableDifferentialAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> assign: aNumber in: aRMDInterpreter [

	aRMDInterpreter
		writeDelta: aNumber * aRMDInterpreter deltaTime
		to: (attributeVariable addressIn: aRMDInterpreter).
	^ aNumber
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	aRMDInterpreter
		writeDelta: aNumber * aRMDInterpreter deltaTime
		to: anInteger + (attributeVariable offsetIn: aRMDInterpreter).
	^ aNumber
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAssignableDifferentialAttributeVariableNode >> typecheckIn: aRMDInterpreter [

	^ (attributeVariable typecheckIn: aRMDInterpreter) / RMDType s
]
