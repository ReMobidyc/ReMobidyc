Extension { #name : 'RMDPatchDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDPatchDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context
		subjectDefinition: aRMDInterpreter simulationModel patchDefinition;
		loadUtilityDefinitions: utilityDefinitions.
	^ super typecheckIn: aRMDInterpreter
]
