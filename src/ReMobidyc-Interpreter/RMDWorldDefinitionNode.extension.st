Extension { #name : 'RMDWorldDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDWorldDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context
		subjectDefinition: aRMDInterpreter simulationModel worldDefinition;
		loadUtilityDefinitions: utilityDefinitions.
	^ super typecheckIn: aRMDInterpreter
]
