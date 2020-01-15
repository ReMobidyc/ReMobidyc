Extension { #name : #RMDSyntaxNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDSyntaxNodeTest >> setUpInterpreter [
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDContext new;
		yourself.
	parser := RMDGrammar new
]
