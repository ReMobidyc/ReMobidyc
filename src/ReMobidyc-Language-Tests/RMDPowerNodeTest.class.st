Class {
	#name : #RMDPowerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPowerNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '5^2'.
	self assert: (expr evalIn: interpreter) closeTo: 25
]
