Class {
	#name : 'RMDFractionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDFractionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '(a + b) / (c * d)'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'c') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '(a + x) / (y * d)')
]

{ #category : 'tests' }
RMDFractionNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'x / y'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse: 'x / (y + z)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
