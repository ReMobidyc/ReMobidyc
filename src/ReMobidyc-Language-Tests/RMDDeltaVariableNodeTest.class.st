Class {
	#name : 'RMDDeltaVariableNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDDeltaVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser attributeDefinition end parse: 'my delta x'' = foo'.
	replacement := Dictionary new
		at: (parser assignableDeltaAttributeVariable end parse: 'my delta x')
			put: (parser assignableDeltaAttributeVariable end parse: 'my delta y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser attributeDefinition end parse: 'my delta y'' = foo')
]
