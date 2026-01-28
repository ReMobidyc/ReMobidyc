Class {
	#name : 'RMDPlaceholderNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDPlaceholderNodeTest >> testCopyReplace [
	| node replacement |
	node := parser condition end
		parse: 'the condition and a1 = a2'.
	replacement := Dictionary new
		at: (parser condition end parse: 'the condition')
			put: (parser condition end parse: 'b1 = b2');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser condition end parse: 'b1 = b2 and a1 = a2')
]

{ #category : 'tests' }
RMDPlaceholderNodeTest >> testPrintOn [

	| node copy |
	node := parser placeholder end parse: 'the x'.
	copy := parser placeholder end parse: node printString.
	self assert: copy equals: node
]
