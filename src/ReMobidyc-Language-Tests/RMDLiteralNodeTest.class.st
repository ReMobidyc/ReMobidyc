Class {
	#name : #RMDLiteralNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDLiteralNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '10 [kcal]'.
	replacement := Dictionary new
		at: (parser type end parse: '[kcal]')
			put: (parser type end parse: '[J]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [J]')
]

{ #category : #tests }
RMDLiteralNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: '1 [m]'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse: '3.14'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
