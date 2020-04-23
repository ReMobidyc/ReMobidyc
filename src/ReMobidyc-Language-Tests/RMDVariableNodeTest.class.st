Class {
	#name : #RMDVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser variable end parse: 'my blood_sugar'.
	replacement := Dictionary new
		at: 'blood_sugar' put: 'energy';
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser variable end parse: 'my energy')
]
