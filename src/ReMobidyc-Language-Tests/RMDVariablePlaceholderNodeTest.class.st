Class {
	#name : #RMDVariablePlaceholderNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDVariablePlaceholderNodeTest >> testCopyReplace [

	| node replacement |
	node := parser expression end parse: 'the expression + x'.
	replacement := Dictionary new
		               at: (parser expression end parse: 'the expression')
		               put: (parser expression end parse: 'y');
		               yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: 'y + x')
]
