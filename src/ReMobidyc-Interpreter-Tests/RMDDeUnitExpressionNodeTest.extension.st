Extension { #name : 'RMDDeUnitExpressionNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDDeUnitExpressionNodeTest >> testEvalIn [

	| expr |
	expr := parser expression parse: '(km)(1000[m])'.
	self assert: (expr evalIn: interpreter) closeTo: 1.0
]
