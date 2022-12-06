Extension { #name : #RMDAgentInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentInitializerNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter context loadUtilityDefinitions: utilityDefinitions.
	attributeInitializers do: [ :initializer | 
		initializer evalIn: aRMDInterpreter ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAgentInitializerNode >> typecheckIn: aRMDInterpreter [

	utilityDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ].
	attributeInitializers do: [ :initializer | 
		initializer typecheckIn: aRMDInterpreter ]
]
