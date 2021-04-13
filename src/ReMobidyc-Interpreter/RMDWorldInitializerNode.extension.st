Extension { #name : #RMDWorldInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: aRMDInterpreter newTypecheckContextForWorld
		do: [ propertyInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
