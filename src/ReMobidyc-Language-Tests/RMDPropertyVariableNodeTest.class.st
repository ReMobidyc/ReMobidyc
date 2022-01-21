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

{ #category : #tests }
RMDPropertyVariableNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'my x'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse: 'here''s x'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
