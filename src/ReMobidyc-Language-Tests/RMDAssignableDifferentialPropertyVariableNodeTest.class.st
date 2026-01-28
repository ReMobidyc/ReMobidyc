Class {
	#name : 'RMDAssignableDifferentialPropertyVariableNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'running' }
RMDAssignableDifferentialPropertyVariableNodeTest >> setUpParser [ 
	super setUpParser.
	parser := parser assignableDifferentialAttributeVariable end
]

{ #category : 'tests' }
RMDAssignableDifferentialPropertyVariableNodeTest >> testPrintOn [

	| node copy |
	node := parser parse: 'my d/dt x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'obj''s d/dt x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'new d/dt x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'the d/dt x'.
	copy := parser parse: node printString.
	self assert: copy equals: node
]
