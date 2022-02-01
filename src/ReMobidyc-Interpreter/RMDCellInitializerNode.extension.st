Extension { #name : #RMDCellInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDCellInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: aRMDInterpreter newTypecheckContextForCell
		do: [ attributeInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
