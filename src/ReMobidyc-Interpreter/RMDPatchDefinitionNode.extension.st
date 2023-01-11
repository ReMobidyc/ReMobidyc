Extension { #name : #RMDPatchDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPatchDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context
		subjectDefinition: aRMDInterpreter patchDefinition;
		loadUtilityDefinitions: utilityDefinitions.
	^ super typecheckIn: aRMDInterpreter
]
