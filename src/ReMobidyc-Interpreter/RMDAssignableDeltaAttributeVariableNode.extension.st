Extension { #name : 'RMDAssignableDeltaAttributeVariableNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDAssignableDeltaAttributeVariableNode >> assign: aNumber in: aRMDInterpreter [

	aRMDInterpreter
		writeDelta: aNumber
		to: (attributeVariable addressIn: aRMDInterpreter).
	^ aNumber
]

{ #category : '*ReMobidyc-Interpreter' }
RMDAssignableDeltaAttributeVariableNode >> assign: aNumber toNewIndividual: anInteger in: aRMDInterpreter [

	aRMDInterpreter
		writeDelta: aNumber
		to: anInteger + (attributeVariable offsetIn: aRMDInterpreter).
	^ aNumber
]

{ #category : '*ReMobidyc-Interpreter' }
RMDAssignableDeltaAttributeVariableNode >> typecheckIn: aRMDInterpreter [
	^ attributeVariable typecheckIn: aRMDInterpreter
]
