Class {
	#name : #RMDDieDirectiveNodeTest,
	#superclass : #RMDLifeDirectiveNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDieDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser lifeDirective end parse: 'die'.
	copy := parser lifeDirective end parse: node printString.
	self assert: copy equals: node
]
