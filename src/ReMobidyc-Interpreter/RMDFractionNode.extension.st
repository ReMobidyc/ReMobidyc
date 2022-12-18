Extension { #name : #RMDFractionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDFractionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		/ (expression2 evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDFractionNode >> typecheckIn: aRMDInterpreter [

	^ (expression1 typecheckIn: aRMDInterpreter)
	  / (expression2 typecheckIn: aRMDInterpreter)
]
