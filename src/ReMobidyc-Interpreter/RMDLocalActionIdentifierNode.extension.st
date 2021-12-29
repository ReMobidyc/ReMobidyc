Extension { #name : #RMDLocalActionIdentifierNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		actionDefinitionAt: shortName
		ifAbsent: [ KeyNotFound signal: shortName ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> removeActionDefinition: aRMDActionDefinitionNode in: aRMDSimulationModel [

	aRMDSimulationModel
		removeActionDefinition: aRMDActionDefinitionNode
		ifAbsent: [  ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> resolveWith: aRMDSimulationModel [

	^ aRMDSimulationModel
		  actionDefinitionAt: shortName
		  ifAbsent: [ RMDUnresolvedReferenceError signal: shortName ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		actionDefinitionAt: shortName
		ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> updateActionDefinition: aRMDActionDefinitionNode to: anotherRMDActionDefinitionNode in: aRMDSimulationModel [

	aRMDSimulationModel
		removeActionDefinition: aRMDActionDefinitionNode ifAbsent: [  ];
		addActionDefinition: anotherRMDActionDefinitionNode.
	shortName = aRMDActionDefinitionNode identifier ifTrue: [ 
		shortName := anotherRMDActionDefinitionNode identifier ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDLocalActionIdentifierNode >> writeActionDefinition: aRMDActionDefinitionNode in: aRMDSimulationModel [

	aRMDSimulationModel addActionDefinition: aRMDActionDefinitionNode
]
