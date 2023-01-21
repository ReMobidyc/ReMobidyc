Extension { #name : #RMDAgentDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentDefinitionNode >> evalIn: aRMDInterpreter [

	[ 
	aRMDInterpreter context loadUtilityDefinitions: utilityDefinitions.
	aRMDInterpreter memory time > 0
		ifTrue: [ 
			| address |
			address := aRMDInterpreter context subject.
			self allAttributeDeclarations do: [ :attributeDecl | 
				attributeDecl initializerExpression ifNotNil: [ :expr | 
					aRMDInterpreter
						writeNext: ([ expr evalIn: aRMDInterpreter ]
								 on: RMDSemanticError
								 do: [ :ex | ex signalWithScope: expr ])
						to: address ].
				address := address + 1 ] ]
		ifFalse: [ 
			| address |
			address := aRMDInterpreter context subject.
			self allAttributeDeclarations do: [ :attributeDecl | 
				attributeDecl initializerExpression ifNotNil: [ :expr | 
					aRMDInterpreter
						write: ([ expr evalIn: aRMDInterpreter ]
								 on: RMDSemanticError
								 do: [ :ex | ex signalWithScope: expr ])
						to: address ].
				address := address + 1 ] ] ]
		on: RMDSemanticError
		do: [ :ex | ex signalWithScope: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentDefinitionNode >> typecheckIn: aRMDInterpreter [

	[ 
	utilityDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ].
	attributeDeclarations do: [ :attributeDecl | 
		attributeDecl typecheckIn: aRMDInterpreter ] ]
		on: RMDSemanticError
		do: [ :ex | ex signalWithScope: self ]
]
