Class {
	#name : #RMDChanceNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDChanceNodeTest >> testCopyReplace [

	| node replacement |
	node := parser condition end parse: 'the a + the b chance'.
	replacement := Dictionary new
		               at: (self expression: 'the a')
		               put: (self expression: '10 [%]');
		               at: (self expression: 'the b')
		               put: (self expression: '5 [%]');
		               yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser condition end parse: '10 [%] + 5 [%] chance')
]

{ #category : #tests }
RMDChanceNodeTest >> testPrintOn [

	| node copy |
	node := parser condition end parse: 'the p chance'.
	copy := parser condition end parse: node printString.
	self assert: copy equals: node.
	node := parser condition end parse: 'the p + 10 [%] chance'.
	copy := parser condition end parse: node printString.
	self assert: copy equals: node
]
