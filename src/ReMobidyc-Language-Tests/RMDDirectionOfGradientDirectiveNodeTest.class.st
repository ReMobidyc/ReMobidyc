Class {
	#name : #RMDDirectionOfGradientDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDirectionOfGradientDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'direction neighbor''s x'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(direction neighbor''s x) + (direction neighbor''s y)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
