Extension { #name : 'RMDEnUnitExpressionNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDEnUnitExpressionNodeTest >> testEvalIn [

	| expr |
	expr := parser expression parse: '(10[])[km]'.
	self assert: (expr evalIn: interpreter) closeTo: 10000.0
]
