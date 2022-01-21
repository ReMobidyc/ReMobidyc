Class {
	#name : #RMDApplyNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDApplyNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: 'my a + min(my b, my c)'.
	replacement := Dictionary new
		at: (self expression: 'min(my b, my c)')
			put: (self expression: 'my z');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: 'my a + my z')
]

{ #category : #tests }
RMDApplyNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'sin(theta)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse: 'min(x, y)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
