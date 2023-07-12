Class {
	#name : #RMDResidualNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDResidualNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '(a + b) % (c * d)'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'c') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '(a + x) % (y * d)')
]

{ #category : #tests }
RMDResidualNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'x % y'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse: '(x + y) % z'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
