Extension { #name : #RMDPatchDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPatchDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context subjectDefinition: aRMDInterpreter patch.
	^ super typecheckIn: aRMDInterpreter
]
