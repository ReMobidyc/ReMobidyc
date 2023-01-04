Class {
	#name : #RMDTimeDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDTimeDirectiveNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: 'time'.
	replacement := Dictionary new
		at: (self expression: 'time')
			put: (self expression: '10 [day]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [day]')
]

{ #category : #tests }
RMDTimeDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'time'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse: 'time + time'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
