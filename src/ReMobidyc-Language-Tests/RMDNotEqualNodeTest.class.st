Class {
	#name : #RMDNotEqualNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDNotEqualNodeTest >> testCopyReplace [
	| node replacement |
	node := parser condition end parse: 'a + b /= c * d'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'c') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser condition end parse: 'a + x /= y * d')
]

{ #category : #tests }
RMDNotEqualNodeTest >> testPrintOn [

	| node copy |
	node := parser condition end parse: 'x /= y'.
	copy := parser condition end parse: node printString.
	self assert: copy equals: node
]
