Class {
	#name : #RMDNewPropertyVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDNewPropertyVariableNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'new x'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
