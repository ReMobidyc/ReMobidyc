Extension { #name : #RMDNewAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> agentAddressIn: aRMDInterpreter [

	^ RMDUndefinedAttributeError signal: self
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> agentDefinitionIn: aRMDInterpreter [

	^ aRMDInterpreter context newDefinition ifNil: [ 
		  RMDUndefinedAnimatError signal: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewAttributeVariableNode >> evalIn: aRMDInterpreter [

	^ RMDUndefinedAttributeError signal: self
]
