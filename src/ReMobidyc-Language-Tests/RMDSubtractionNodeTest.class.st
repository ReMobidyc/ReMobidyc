Class {
	#name : #RMDSubtractionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDSubtractionNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2 - 5'.
	self assert: (expr evalIn: interpreter) closeTo: -3
]
