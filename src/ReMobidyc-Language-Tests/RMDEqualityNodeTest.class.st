Class {
	#name : #RMDEqualityNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDEqualityNodeTest >> testEvalIn [
	self
		assert: ((parser condition parse: '1 = 1') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '1 = 2') evalIn: interpreter)
		equals: false.
	self
		assert: ((parser condition parse: '1 = 1 = 1') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '1 = 1 = 2') evalIn: interpreter)
		equals: false
]
