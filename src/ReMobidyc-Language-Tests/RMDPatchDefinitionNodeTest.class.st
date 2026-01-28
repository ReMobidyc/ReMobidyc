Class {
	#name : 'RMDPatchDefinitionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDPatchDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser patchDefinition end parse: 'Patch with
	x [m]
	y [kg].'.
	copy := parser patchDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser patchDefinition end parse: 'Patch.'.
	copy := parser patchDefinition end parse: node printString.
	self assert: copy equals: node
]
