Extension { #name : 'RMDPowerNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDPowerNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '5^2'.
	self assert: (expr evalIn: interpreter) closeTo: 25
]
