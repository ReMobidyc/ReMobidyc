Extension { #name : 'RMDAnimatDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDAnimatDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context
		subjectDefinition: (aRMDInterpreter simulationModel
				 animatDefinitionAt: self identifier
				 ifAbsent: [ RMDUndefinedAnimatError signal: self identifier ]);
		loadUtilityDefinitions: utilityDefinitions.
	^ super typecheckIn: aRMDInterpreter
]
