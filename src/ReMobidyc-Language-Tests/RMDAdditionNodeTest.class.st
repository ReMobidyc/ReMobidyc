Class {
	#name : #RMDAdditionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAdditionNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2[] + 5[m]'.
	self assert: (expr evalIn: interpreter) closeTo: 7.0
]
