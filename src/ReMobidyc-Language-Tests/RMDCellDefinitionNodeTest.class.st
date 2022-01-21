Class {
	#name : #RMDCellDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDCellDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser cellDefinition end parse: 'Cell with
	x [m]
	y [kg].'.
	copy := parser cellDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser cellDefinition end parse: 'Cell.'.
	copy := parser cellDefinition end parse: node printString.
	self assert: copy equals: node
]
