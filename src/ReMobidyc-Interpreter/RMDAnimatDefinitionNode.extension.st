Extension { #name : #RMDAnimatDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context subjectDefinition: (aRMDInterpreter
			 animatDefinitionAt: self identifier
			 ifAbsent: [ RMDUndefinedAnimatError signal: self identifier ]).
	^ super typecheckIn: aRMDInterpreter
]
