Extension { #name : #RMDPropertyDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyDefinitionNode >> evalIn: aRMDInterpreter [
	^ variable
		assign: (definitionBody evalIn: aRMDInterpreter)
		in: aRMDInterpreter
]
