Extension { #name : #RMDActionIdentifierNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionIdentifierNode >> evalIn: aRMDInterpreter [
	^ self subclassResponsibility 
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionIdentifierNode >> removeActionDefinition: aRMDActionDefinitionNode in: aRMDSimulationModel [
	^ self error: 'Failed to update an action definition'
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionIdentifierNode >> resolveWith: aRMDSimulationModel [
	^ self subclassResponsibility 
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionIdentifierNode >> typecheckIn: aRMDInterpreter [
	^ self subclassResponsibility 
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionIdentifierNode >> updateActionDefinition: aRMDActionDefinitionNode to: anotherRMDActionDefinitionNode in: aRMDSimulationModel [

	^ self error: 'Failed to update an action definition'
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionIdentifierNode >> writeActionDefinition: aRMDActionDefinitionNode in: aRMDInterpreter [
	^ self error: 'Failed to update an action definition'
]
