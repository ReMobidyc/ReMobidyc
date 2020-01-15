Extension { #name : #RMDProductNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDProductNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2 * 5'.
	self assert: (expr evalIn: interpreter) closeTo: 10.0
]
