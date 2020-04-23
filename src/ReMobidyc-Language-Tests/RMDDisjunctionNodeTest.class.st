Class {
	#name : #RMDDisjunctionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDisjunctionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser condition end
		parse: 'a1 = a2 or (b1 = b2 and c1 = c2)'.
	replacement := Dictionary new
		at: (parser condition end parse: 'b1 = b2 and c1 = c2')
			put: (parser condition end parse: 'd1 = d2');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser condition end parse: 'a1 = a2 or d1 = d2')
]
