Class {
	#name : #RMDFractionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDFractionNodeTest >> testEvalIn [
	| expr |
	expr := parser expression parse: '2[] / 5[m]'.
	self assert: (expr evalIn: interpreter) closeTo: 0.4
]
