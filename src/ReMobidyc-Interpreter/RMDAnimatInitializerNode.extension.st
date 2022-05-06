Extension { #name : #RMDAnimatInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> evalIn: aRMDInterpreter [

	super evalIn: aRMDInterpreter.
	aRMDInterpreter
		initializeVariableIfNotInitialized: 'x'
		with: [ RMDUniformDistributionXNode current evalIn: aRMDInterpreter ]
		ifAbsent: [ ^ KeyNotFound signal: 'x' ];
		initializeVariableIfNotInitialized: 'y'
		with: [ RMDUniformDistributionYNode current evalIn: aRMDInterpreter ]
		ifAbsent: [ ^ KeyNotFound signal: 'y' ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForAnimat: self animat)
		do: [ attributeInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
