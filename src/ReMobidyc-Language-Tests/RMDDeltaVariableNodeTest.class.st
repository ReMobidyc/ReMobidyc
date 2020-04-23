Class {
	#name : #RMDDeltaVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDeltaVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser propertyDefinition end parse: 'my delta x'' = foo'.
	replacement := Dictionary new
		at: (parser deltaVariable end parse: 'my delta x')
			put: (parser deltaVariable end parse: 'my delta y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser propertyDefinition end parse: 'my delta y'' = foo')
]
