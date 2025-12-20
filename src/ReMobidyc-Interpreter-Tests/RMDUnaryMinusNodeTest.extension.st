Extension { #name : 'RMDUnaryMinusNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDUnaryMinusNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '-(1+2)'.
	self assert: (expr evalIn: interpreter) closeTo: -3.
	expr := parser expression parse: '-4 * -(1+2)'.
	self assert: (expr evalIn: interpreter) closeTo: -4 * (1 + 2) negated
]
