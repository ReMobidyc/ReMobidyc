Class {
	#name : #RMDProductNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDProductNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2 * 5'.
	self assert: (expr evalIn: interpreter) closeTo: 10.0
]
