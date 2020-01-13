Class {
	#name : #RMDNConjunctionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDNConjunctionNodeTest >> testEvalIn [
	self
		assert: ((parser condition parse: '1 = 1 and 2 = 2') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '1 = 1 and 1 = 2') evalIn: interpreter)
		equals: false.
	self
		assert:
			((parser condition parse: '1 = 1 and 2 = 2 and 3 = 3')
				evalIn: interpreter)
		equals: true.
	self
		assert:
			((parser condition parse: '1 = 1 and 2 = 2 and 3 = 4')
				evalIn: interpreter)
		equals: false
]
