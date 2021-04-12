Extension { #name : #RMDFractionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDFractionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		/ (expression2 evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDFractionNode >> typecheckIn: aRMDInterpreter [
	^ RMDUnitType
		unit:
			(expression1 typecheckIn: aRMDInterpreter) unit
				/ (expression2 typecheckIn: aRMDInterpreter) unit
]
