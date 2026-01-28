Class {
	#name : 'RMDDirectionDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDDirectionDirectiveNodeTest >> testCopyReplace [
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

{ #category : 'tests' }
RMDDirectionDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'direction target'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse: '(direction target) + (direction another)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
