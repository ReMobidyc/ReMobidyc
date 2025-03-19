Extension { #name : 'RMDSimulationTimeDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDSimulationTimeDefinitionNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := RMDType time.
	[ (duration typecheckIn: aRMDInterpreter) unify: type ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: duration
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	[ (step typecheckIn: aRMDInterpreter) unify: type ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: step
					 type: ex type1
					 subnode: self
					 type: ex type2) ]
]
