Extension { #name : 'RMDAssignableAttributeVariableNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDAssignableAttributeVariableNode >> assign: aNumber in: aRMDInterpreter [

	aRMDInterpreter
		writeNext: aNumber
		to: (attributeVariable addressIn: aRMDInterpreter).
	^ aNumber
]

{ #category : '*ReMobidyc-Interpreter' }
RMDAssignableAttributeVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	aRMDInterpreter
		writeNext: aNumber
		to: anInteger + (attributeVariable offsetIn: aRMDInterpreter).
	^ aNumber
]

{ #category : '*ReMobidyc-Interpreter' }
RMDAssignableAttributeVariableNode >> typecheckIn: aRMDInterpreter [
	^ attributeVariable typecheckIn: aRMDInterpreter
]
