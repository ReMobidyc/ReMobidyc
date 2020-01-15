Extension { #name : #RMDPropertyDeclarationNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDPropertyDeclarationNodeTest >> testEvalIn [
	| expr |
	expr := parser propertyDeclaration parse: 'x = 10[m]'.
	self assert: (expr evalIn: interpreter) closeTo: 10.0
]
