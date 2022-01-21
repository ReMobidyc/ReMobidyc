Class {
	#name : #RMDLocalActionIdentifierNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDLocalActionIdentifierNodeTest >> testPrintOn [

	| node copy |
	node := parser localActionIdentifier end parse: 'move@model'.
	copy := parser localActionIdentifier end parse: node printString.
	self assert: copy equals: node
]
