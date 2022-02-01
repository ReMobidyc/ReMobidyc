Class {
	#name : #RMDVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser attributeVariable end parse: 'my blood_sugar'.
	replacement := Dictionary new
		at: 'blood_sugar' put: 'energy';
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser attributeVariable end parse: 'my energy')
]
