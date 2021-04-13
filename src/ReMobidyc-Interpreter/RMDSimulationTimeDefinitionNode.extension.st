Extension { #name : #RMDSimulationTimeDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSimulationTimeDefinitionNode >> typecheckIn: aRMDInterpreter [
	| type |
	type := RMDType s.
	[ (duration typecheckIn: aRMDInterpreter) unify: type ]
		on: RMDTypeUnificationError
		do: [ :ex | ex resignalAs: (RMDTypeError on: duration with: ex type1) ].
	[ (step typecheckIn: aRMDInterpreter) unify: type ]
		on: RMDTypeUnificationError
		do: [ :ex | ex resignalAs: (RMDTypeError on: step with: ex type1) ]
]
