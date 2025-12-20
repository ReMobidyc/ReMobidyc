Extension { #name : 'RMDAdditionNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDAdditionNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2 + 5'.
	self assert: (expr evalIn: interpreter) closeTo: 7.0
]
