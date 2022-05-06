Extension { #name : #RMDPatchInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPatchInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: aRMDInterpreter newTypecheckContextForPatch
		do: [ attributeInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
