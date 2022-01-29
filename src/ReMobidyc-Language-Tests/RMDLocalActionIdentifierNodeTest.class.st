Class {
	#name : #RMDLocalActionIdentifierNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDLocalActionIdentifierNodeTest >> testPrintOn [

	| node copy |
	node := parser actionIdentifier end parse: 'move'.
	copy := parser actionIdentifier end parse: node printString.
	self assert: copy equals: node
]
