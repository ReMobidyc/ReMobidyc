Extension { #name : #RMDBinaryRelationNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBinaryRelationNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := RMDType any.
	expressions do: [ :expression | 
		[ type := (expression typecheckIn: aRMDInterpreter) unify: type ]
			on: RMDTypeUnificationError
			do: [ :ex | 
				ex resignalAs: (RMDTypeError
						 on: self
						 subnode: expression
						 type: ex type1
						 subnode: expressions first
						 type: ex type2) ] ].
	^ nil
]
