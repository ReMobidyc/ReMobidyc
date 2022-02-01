Class {
	#name : #RMDPropertyBindNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPropertyBindNodeTest >> testPrintOn [

	| node copy |
	node := parser attributeBind end parse: 'the x -> my y'.
	copy := parser attributeBind end parse: node printString.
	self assert: copy equals: node
]
