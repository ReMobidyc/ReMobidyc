Extension { #name : #RMDProductNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDProductNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		* (expression2 evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDProductNode >> typecheckIn: aRMDInterpreter [

	^ RMDUnitType unit: (expression1 typecheckIn: aRMDInterpreter) unit
		  * (expression2 typecheckIn: aRMDInterpreter) unit
]
