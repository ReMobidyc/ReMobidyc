Extension { #name : 'RMDDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDefinitionNode >> evalIn: aRMDInterpreter [
	^ self subclassResponsibility
]

{ #category : '*ReMobidyc-Interpreter' }
RMDDefinitionNode >> typecheckIn: aRMDInterpreter [
	^ self subclassResponsibility
]
