Extension { #name : 'RMDSubtractionNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDSubtractionNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2 - 5'.
	self assert: (expr evalIn: interpreter) closeTo: -3
]
