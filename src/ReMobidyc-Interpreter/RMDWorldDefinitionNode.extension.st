Extension { #name : #RMDWorldDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context subjectDefinition: aRMDInterpreter world.
	^ super typecheckIn: aRMDInterpreter
]
