Class {
	#name : #RMDExpressionPlaceholderNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDExpressionPlaceholderNodeTest >> testCopyReplace [

	| node replacement |
	node := parser expression end parse: 'the expression + x'.
	replacement := Dictionary new
		               at: (parser condition end parse: 'the expression')
		               put: (parser condition end parse: 'y');
		               yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser condition end parse: 'y + x')
]
