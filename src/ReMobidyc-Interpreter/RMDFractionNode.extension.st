Extension { #name : #RMDFractionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDFractionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		/ (expression2 evalIn: aRMDInterpreter)
]
