Class {
	#name : 'RMDNewDirectiveNodeTest',
	#superclass : 'RMDLifeDirectiveNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDNewDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser lifeDirective end parse: 'new 3 A'.
	copy := parser lifeDirective end parse: node printString.
	self assert: copy equals: node.
	node := parser lifeDirective end parse: 'new -'.
	copy := parser lifeDirective end parse: node printString.
	self assert: copy equals: node
]
