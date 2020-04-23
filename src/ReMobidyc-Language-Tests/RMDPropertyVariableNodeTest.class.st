Class {
	#name : #RMDPropertyVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPropertyVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '1 [m] + my foo'.
	replacement := Dictionary new
		at: (self expression: 'my foo') put: (self expression: '10 [m]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '1 [m] + 10 [m]')
]
