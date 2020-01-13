Class {
	#name : #RMDNegationNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDNegationNodeTest >> testEvalIn [
	self
		assert: ((parser condition parse: 'not 1 = 2') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: 'not 1 = 1') evalIn: interpreter)
		equals: false
]
