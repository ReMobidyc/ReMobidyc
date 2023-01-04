Class {
	#name : #RMDDeltaTimeDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDeltaTimeDirectiveNodeTest >> testCopyReplace [

	| node replacement |
	node := parser expression end parse: 'delta time'.
	replacement := Dictionary new
		               at: (self expression: 'delta time')
		               put: (self expression: '10 [ms]');
		               yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [ms]')
]

{ #category : #tests }
RMDDeltaTimeDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'delta time'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
