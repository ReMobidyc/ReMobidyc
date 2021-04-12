Extension { #name : #RMDSpeciesInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSpeciesInitializerNode >> evalIn: aRMDInterpreter [
	propertyInitializers
		do: [ :initializer | initializer evalIn: aRMDInterpreter ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDSpeciesInitializerNode >> typecheckIn: aRMDInterpreter [
	propertyInitializers
		do: [ :initializer | initializer typecheckIn: aRMDInterpreter ]
]
