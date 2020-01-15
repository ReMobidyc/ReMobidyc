Extension { #name : #RMDFractionNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDFractionNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2 / 5'.
	self assert: (expr evalIn: interpreter) closeTo: 0.4
]
