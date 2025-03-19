Extension { #name : 'RMDObjectAttributeVariableNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDObjectAttributeVariableNode >> agentAddressIn: aRMDInterpreter [

	^ aRMDInterpreter context object
]

{ #category : '*ReMobidyc-Interpreter' }
RMDObjectAttributeVariableNode >> agentDefinitionIn: aRMDInterpreter [

	^ aRMDInterpreter context objectDefinition ifNil: [ 
		  RMDUndefinedAnimatError signal: self ]
]
