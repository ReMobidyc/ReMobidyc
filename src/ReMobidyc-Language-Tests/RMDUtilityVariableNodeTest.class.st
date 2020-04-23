Class {
	#name : #RMDUtilityVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDUtilityVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser utilityVariable end parse: 'x'.
	replacement := Dictionary new
		at: 'x' put: 'y';
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser utilityVariable end parse: 'y')
]
