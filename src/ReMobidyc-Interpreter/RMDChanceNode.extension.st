Extension { #name : 'RMDChanceNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDChanceNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter random < (probability evalIn: aRMDInterpreter)
]

{ #category : '*ReMobidyc-Interpreter' }
RMDChanceNode >> typecheckIn: aRMDInterpreter [

	[ 
	(probability typecheckIn: aRMDInterpreter) unify: RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: probability
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	^ nil
]
