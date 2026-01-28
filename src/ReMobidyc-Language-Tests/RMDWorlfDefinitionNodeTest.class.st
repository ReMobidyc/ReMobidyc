Class {
	#name : 'RMDWorlfDefinitionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDWorlfDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser worldDefinition end parse: 'World with
	x [m]
	y [kg].'.
	copy := parser worldDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser worldDefinition end parse: 'World.'.
	copy := parser worldDefinition end parse: node printString.
	self assert: copy equals: node
]
