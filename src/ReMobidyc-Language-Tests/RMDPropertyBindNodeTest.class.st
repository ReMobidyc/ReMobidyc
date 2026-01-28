Class {
	#name : 'RMDPropertyBindNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDPropertyBindNodeTest >> testPrintOn [

	| node copy |
	node := parser parameterInstantiation end parse: 'the x -> my y'.
	copy := parser parameterInstantiation end parse: node printString.
	self assert: copy equals: node
]
