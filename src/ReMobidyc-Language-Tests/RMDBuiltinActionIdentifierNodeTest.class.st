Class {
	#name : #RMDBuiltinActionIdentifierNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDBuiltinActionIdentifierNodeTest >> testPrintOn [

	| node copy |
	node := parser builtinActionIdentifier end parse: 'move'.
	copy := parser builtinActionIdentifier end parse: node printString.
	self assert: copy equals: node.
]
