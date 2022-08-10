Extension { #name : #RMDUtilityDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUtilityDefinitionNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		write: (definitionBody evalIn: aRMDInterpreter)
		toUtility: variable identifier
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDUtilityDefinitionNode >> typecheckIn: aRMDInterpreter [
	^ aRMDInterpreter
		typeUtilityVariable: variable identifier
		as: (definitionBody typecheckIn: aRMDInterpreter)
]
