Extension { #name : 'RMDRemainderNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDRemainderNodeTest >> testEvalIn [

	| expr |
	expr := parser expression parse: '13 % 5'.
	self assert: (expr evalIn: interpreter) closeTo: 3.0.
	expr := parser expression parse: '-13 % 5'.
	self assert: (expr evalIn: interpreter) closeTo: 2.0.
	expr := parser expression parse: '-13 % -5'.
	self assert: (expr evalIn: interpreter) closeTo: -3.0.
	expr := parser expression parse: '13 % -5'.
	self assert: (expr evalIn: interpreter) closeTo: -2.0
]
