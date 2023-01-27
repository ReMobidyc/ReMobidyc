Extension { #name : #RMDWorldAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldAttributeVariableNode >> agentAddressIn: aRMDInterpreter [

	^ aRMDInterpreter world
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldAttributeVariableNode >> agentDefinitionIn: aRMDInterpreter [

	^ aRMDInterpreter simulationModel worldDefinition
]
