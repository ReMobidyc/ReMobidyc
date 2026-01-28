Class {
	#name : 'RMDKillDirectiveNodeTest',
	#superclass : 'RMDLifeDirectiveNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDKillDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser lifeDirective end parse: 'kill'.
	copy := parser lifeDirective end parse: node printString.
	self assert: copy equals: node
]
