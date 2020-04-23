Class {
	#name : #RMDAgentDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAgentDirectiveNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: 'direction target'.
	replacement := Dictionary new
		at: (self expression: 'direction target')
			put: (self expression: '10 [degree]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [degree]')
]
