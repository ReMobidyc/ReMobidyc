Class {
	#name : #RMDPropertyDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPropertyDefinitionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser propertyDefinition end parse: 'my blood_sugar'' = x'.
	replacement := Dictionary new
		at: 'blood_sugar' put: 'energy';
		at: (self expression: 'x') put: (self expression: '10 [m]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser propertyDefinition end parse: 'my energy'' = 10 [m]')
]
