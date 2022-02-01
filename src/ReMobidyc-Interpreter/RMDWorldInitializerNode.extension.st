Extension { #name : #RMDWorldInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: aRMDInterpreter newTypecheckContextForWorld
		do: [ attributeInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
