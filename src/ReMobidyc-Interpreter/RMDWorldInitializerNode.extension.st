Extension { #name : #RMDWorldInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldInitializerNode >> evalIn: aRMDInterpreter [

	| worldDefinition world |
	worldDefinition := aRMDInterpreter simulationModel worldDefinition.
	world := aRMDInterpreter memory allocateWorld: worldDefinition.
	aRMDInterpreter
		withInitializerContextWithSubject: world
		definition: worldDefinition
		do: [ 
			worldDefinition allAttributeDeclarations do: [ 
				:attributeDeclaration | attributeDeclaration evalIn: self ].
			attributeInitializers do: [ :initializer | 
				initializer evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: aRMDInterpreter newTypecheckContextForWorld
		do: [ attributeInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
