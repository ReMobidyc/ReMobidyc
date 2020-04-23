Class {
	#name : #RMDEqualityNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDEqualityNodeTest >> testCopyReplace [
	| node replacement |
	node := parser condition end parse: 'a + b = c * d'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'c') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser condition end parse: 'a + x = y * d')
]
