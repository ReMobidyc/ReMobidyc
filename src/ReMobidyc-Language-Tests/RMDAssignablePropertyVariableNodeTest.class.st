Class {
	#name : #RMDAssignablePropertyVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #running }
RMDAssignablePropertyVariableNodeTest >> setUpParser [ 
	super setUpParser.
	parser := parser assignablePropertyVariable end
]

{ #category : #tests }
RMDAssignablePropertyVariableNodeTest >> testPrintOn [

	| node copy |
	node := parser parse: 'my x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'obj''s x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'new x'.
	copy := parser parse: node printString.
	self assert: copy equals: node.
	node := parser parse: 'the x'.
	copy := parser parse: node printString.
	self assert: copy equals: node
]
