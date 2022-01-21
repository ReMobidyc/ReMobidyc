Class {
	#name : #RMDStageDirectiveNodeTest,
	#superclass : #RMDLifeDirectiveNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDStageDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser lifeDirective end parse: 'stage A'.
	copy := parser lifeDirective end parse: node printString.
	self assert: copy equals: node
]
