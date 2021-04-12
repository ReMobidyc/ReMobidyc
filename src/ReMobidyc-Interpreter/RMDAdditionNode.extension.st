Extension { #name : #RMDAdditionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAdditionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		+ (expression2 evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAdditionNode >> typecheckIn: aRMDInterpreter [
	^ (expression1 typecheckIn: aRMDInterpreter)
		unify: (expression2 typecheckIn: aRMDInterpreter)
]
