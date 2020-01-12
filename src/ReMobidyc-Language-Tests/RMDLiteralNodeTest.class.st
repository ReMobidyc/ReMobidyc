Class {
	#name : #RMDLiteralNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #testEvalIn }
RMDLiteralNodeTest >> testEvalIn [
	| literal |
	literal := parser literal parse: '2'.
	self assert: (literal evalIn: interpreter) closeTo: 2.
	literal := parser literal parse: '2[]'.
	self assert: (literal evalIn: interpreter) closeTo: 2.
	literal := parser literal parse: '2[m]'.
	self assert: (literal evalIn: interpreter) closeTo: 2.
	literal := parser literal parse: '2[cm]'.
	self assert: (literal evalIn: interpreter) closeTo: 0.02
]
