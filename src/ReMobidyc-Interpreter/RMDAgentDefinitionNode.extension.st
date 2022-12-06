Extension { #name : #RMDAgentDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentDefinitionNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter context loadUtilityDefinitions: utilityDefinitions.
	aRMDInterpreter memory time > 0
		ifTrue: [ 
			self allAttributeDeclarations do: [ :attributeDecl | 
				attributeDecl initializerExpression ifNotNil: [ :expr | 
					aRMDInterpreter
						write: (expr evalIn: aRMDInterpreter)
						toVariable: attributeDecl identifier
						agent: nil
						ifAbsent: [ RMDUnresolvedReferenceError signal ] ] ] ]
		ifFalse: [ 
			self allAttributeDeclarations do: [ :attributeDecl | 
				attributeDecl initializerExpression ifNotNil: [ :expr | 
					aRMDInterpreter
						initializeVariable: attributeDecl identifier
						with: (expr evalIn: aRMDInterpreter)
						ifAbsent: [ RMDUnresolvedReferenceError signal ] ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentDefinitionNode >> typecheckIn: aRMDInterpreter [

	utilityDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ].
	attributeDeclarations do: [ :attributeDecl | 
		attributeDecl typecheckIn: aRMDInterpreter ]
]
