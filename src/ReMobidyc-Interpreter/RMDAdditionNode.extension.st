Extension { #name : #RMDAdditionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAdditionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		+ (expression2 evalIn: aRMDInterpreter)
]
