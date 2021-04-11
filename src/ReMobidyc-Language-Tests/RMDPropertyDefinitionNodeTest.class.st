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
RMDPropertyDefinitionNodeTest >> testInferType [
	| node unit |
	node := parser propertyDefinition end parse: 'my d/dt x'' = 100[m/s]'.
	node variable propertyVariable unifyType: RMDUnit m.
	unit := RMDUnit m / RMDUnit s.
	node clearType.
	self assert: node type isNil.
	self assert: node inferType equals: unit.
	self assert: node type equals: unit.
	node := parser propertyDefinition end parse: 'my d/dt x'' = 100[m]'.
	node variable propertyVariable unifyType: RMDUnit m.
	node clearType.
	self assert: node type isNil.
	self should: [ node inferType ] raise: RMDTypeError
]
