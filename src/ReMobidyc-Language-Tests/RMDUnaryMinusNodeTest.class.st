Class {
	#name : #RMDUnaryMinusNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDUnaryMinusNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '-(a + b)'.
	replacement := Dictionary new
		at: (self expression: 'a') put: (self expression: 'x');
		at: (self expression: 'b') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '-(x + y)')
]

{ #category : #tests }
RMDUnaryMinusNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: '-(x + y)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
