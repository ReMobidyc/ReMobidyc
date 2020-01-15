Extension { #name : #RMDUtilityDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUtilityDefinitionNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		write: (definitionBody evalIn: aRMDInterpreter)
		toUtility: variable identifier
]
