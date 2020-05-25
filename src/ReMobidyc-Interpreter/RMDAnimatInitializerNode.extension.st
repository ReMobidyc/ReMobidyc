Extension { #name : #RMDAnimatInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> evalIn: aRMDInterpreter [
	super evalIn: aRMDInterpreter.
	aRMDInterpreter
		initializeVariableIfNotInitialized: 'x'
			with: [ RMDUniformDistributionXNode current evalIn: aRMDInterpreter ]
			ifAbsent: [ ^ LibrarySymbolNotFoundError signal: 'x' ];
		initializeVariableIfNotInitialized: 'y'
			with: [ RMDUniformDistributionYNode current evalIn: aRMDInterpreter ]
			ifAbsent: [ ^ LibrarySymbolNotFoundError signal: 'y' ]
]
