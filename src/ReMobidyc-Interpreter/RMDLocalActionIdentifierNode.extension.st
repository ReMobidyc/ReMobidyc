Extension { #name : #RMDLocalActionIdentifierNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		actionDefinitionAt: shortName
		ifAbsent: [ KeyNotFound signal: shortName ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> resolveWith: aRMDSimulationModel [
	^ aRMDSimulationModel
		actionDefinitionAt: shortName
		ifAbsent: [ KeyNotFound signal: shortName ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		actionDefinitionAt: shortName
		ifAbsent: [ ^ KeyNotFound signal: shortName ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> writeActionDefinition: aRMDActionDefinitionNode in: aRMDInterpreter [
	aRMDInterpreter addActionDefinition: aRMDActionDefinitionNode
]
