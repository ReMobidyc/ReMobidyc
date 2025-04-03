Extension { #name : 'RMDHereAttributeVariableNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDHereAttributeVariableNode >> agentAddressIn: aRMDInterpreter [

	^ aRMDInterpreter context location
]

{ #category : '*ReMobidyc-Interpreter' }
RMDHereAttributeVariableNode >> agentDefinitionIn: aRMDInterpreter [

	^ aRMDInterpreter context locationDefinition ifNil: [ 
		  RMDUndefinedAnimatError signal: self ]
]
