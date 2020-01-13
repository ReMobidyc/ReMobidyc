Class {
	#name : #RMDConjunctionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDConjunctionNodeTest >> testEvalIn [
	| expr |
	expr := parser condition parse: '1 = 1 and 2 = 2'.
	self assert: (expr evalIn: interpreter) equals: true.
	expr := parser condition parse: '1 = 1 and 2 = 3'.
	self assert: (expr evalIn: interpreter) equals: false.
	expr := parser condition parse: '1 = 2 and 3 = 4'.
	self assert: (expr evalIn: interpreter) equals: false
]
