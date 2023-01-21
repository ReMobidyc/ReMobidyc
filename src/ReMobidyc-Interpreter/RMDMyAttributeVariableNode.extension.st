Extension { #name : #RMDMyAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDMyAttributeVariableNode >> agentAddressIn: aRMDInterpreter [

	^ aRMDInterpreter context subject
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDMyAttributeVariableNode >> agentDefinitionIn: aRMDInterpreter [

	^ aRMDInterpreter context subjectDefinition ifNil: [ 
		  RMDUndefinedAnimatError signal: self ]
]
