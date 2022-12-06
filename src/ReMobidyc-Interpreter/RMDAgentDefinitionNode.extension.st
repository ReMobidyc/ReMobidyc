Extension { #name : #RMDAgentDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentDefinitionNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter context loadUtilityDefinitions: utilityDefinitions.
	self allAttributeDeclarations do: [ :attributeDecl | 
		attributeDecl initializerExpression ifNotNil: [ :expr | 
			aRMDInterpreter
				write: (expr evalIn: self)
				toVariable: attributeDecl identifier
				agent: nil
				ifAbsent: [ RMDUnresolvedReferenceError signal ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentDefinitionNode >> typecheckIn: aRMDInterpreter [

	utilityDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ].
	attributeDeclarations do: [ :attributeDecl | 
		attributeDecl typecheckIn: aRMDInterpreter ]
]
