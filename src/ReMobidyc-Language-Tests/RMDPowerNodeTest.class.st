Class {
	#name : #RMDPowerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPowerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '(a + b) ^ 2'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'c') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '(a + x) ^ 2')
]
