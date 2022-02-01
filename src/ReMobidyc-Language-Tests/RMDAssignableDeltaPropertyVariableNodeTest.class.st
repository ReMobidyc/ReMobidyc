Class {
	#name : #RMDAssignableDeltaPropertyVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #running }
RMDAssignableDeltaPropertyVariableNodeTest >> setUpParser [ 
	super setUpParser.
	parser := parser assignableDeltaAttributeVariable end
]

{ #category : #tests }
RMDAssignableDeltaPropertyVariableNodeTest >> testPrintOn [

	| node copy |
	node := parser parse: 'my delta x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'obj''s delta x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'new delta x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'the delta x'.
	copy := parser parse: node printString.
	self assert: copy equals: node
]
