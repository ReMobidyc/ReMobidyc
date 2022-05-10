Class {
	#name : #RMDEnUnitExpressionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDEnUnitExpressionNodeTest >> testCopyReplace [

	| node replacement |
	node := parser expression end parse:
		        '1 + the length[m]'.
	replacement := Dictionary new
		               at:
			               (parser expression end parse: 'the length')
		               put: (parser expression end parse: 'len1+len2');
		               yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '1 + (len1+len2)[m]')
]

{ #category : #tests }
RMDEnUnitExpressionNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: '1+(2+3)[m]'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
