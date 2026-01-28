Class {
	#name : 'RMDConjunctionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDConjunctionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser condition end
		parse: 'a1 = a2 and (b1 = b2 or c1 = c2)'.
	replacement := Dictionary new
		at: (parser condition end parse: 'b1 = b2 or c1 = c2')
			put: (parser condition end parse: 'd1 = d2');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser condition end parse: 'a1 = a2 and d1 = d2')
]

{ #category : 'tests' }
RMDConjunctionNodeTest >> testPrintOn [

	| node copy |
	node := parser condition end parse: 'x > y and x > z'.
	copy := parser condition end parse: node printString.
	self assert: copy equals: node
]
