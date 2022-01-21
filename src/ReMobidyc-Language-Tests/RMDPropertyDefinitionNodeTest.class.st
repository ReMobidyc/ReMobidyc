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

{ #category : #tests }
RMDPropertyDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser propertyDefinition end parse: 'my x'' = y'.
	copy := parser propertyDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser propertyDefinition end parse: 'agent''s delta x'' = y'.
	copy := parser propertyDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser propertyDefinition end parse: 'new d/dt x'' = y'.
	copy := parser propertyDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser propertyDefinition end parse: 'the delta x'' = y'.
	copy := parser propertyDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser propertyDefinition end parse: 'my x'' = y if a > b,
	z if c > d,
	zz'.
	copy := parser propertyDefinition end parse: node printString.
	self assert: copy equals: node.

]
