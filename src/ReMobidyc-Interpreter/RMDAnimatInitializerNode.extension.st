Extension { #name : #RMDAnimatInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> evalIn: aRMDInterpreter [

	super evalIn: aRMDInterpreter.
	aRMDInterpreter
		initializeVariableIfNotInitialized: 'x'
		with: [ RMDUniformDistributionXNode current evalIn: aRMDInterpreter ]
		ifAbsent: [ ^ RMDUnresolvedReferenceError on: self ];
		initializeVariableIfNotInitialized: 'y'
		with: [ RMDUniformDistributionYNode current evalIn: aRMDInterpreter ]
		ifAbsent: [ ^ RMDUnresolvedReferenceError on: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForAnimat: self animat)
		do: [ attributeInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
