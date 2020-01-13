Class {
	#name : #RMDDisjunctionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDisjunctionNodeTest >> testEvalIn [
	| expr |
	expr := parser condition parse: '1 = 1 or 2 = 2'.
	self assert: (expr evalIn: interpreter) equals: true.
	expr := parser condition parse: '1 = 1 or 2 = 3'.
	self assert: (expr evalIn: interpreter) equals: true.
	expr := parser condition parse: '1 = 2 or 3 = 4'.
	self assert: (expr evalIn: interpreter) equals: false
]
