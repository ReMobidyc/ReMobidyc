Extension { #name : #RMDSimulationTimeDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSimulationTimeDefinitionNode >> typecheckIn: aRMDInterpreter [
	| type |
	type := RMDType s.
	(duration typecheckIn: aRMDInterpreter) unify: type.
	(step typecheckIn: aRMDInterpreter) unify: type
]
