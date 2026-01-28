Class {
	#name : 'RMDDeUnitExpressionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDDeUnitExpressionNodeTest >> testCopyReplace [

	| node replacement |
	node := parser expression end parse: '1 + (cm)the length'.
	replacement := Dictionary new
		               at: (parser expression end parse: 'the length')
		               put: (parser expression end parse: 'len1+len2');
		               yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '1 + (cm)(len1+len2)')
]

{ #category : 'tests' }
RMDDeUnitExpressionNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: '1+(m)(2+3)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
