Extension { #name : #RMDBinaryCombinatorNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBinaryCombinatorNode >> typecheckIn: aRMDInterpreter [
	conditions
		do: [ :condition | condition typecheckIn: aRMDInterpreter ]
]
