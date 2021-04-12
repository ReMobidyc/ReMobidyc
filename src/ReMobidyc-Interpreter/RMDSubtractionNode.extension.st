Extension { #name : #RMDSubtractionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSubtractionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		- (expression2 evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDSubtractionNode >> typecheckIn: aRMDInterpreter [
	^ (expression1 typecheckIn: aRMDInterpreter)
		unify: (expression2 typecheckIn: aRMDInterpreter)
]
