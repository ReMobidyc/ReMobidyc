Class {
	#name : #RMDLessOrEqualNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDLessOrEqualNodeTest >> testEvalIn [
	self
		assert: ((parser condition parse: '1 <= 2') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '1 <= 1') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '2 <= 1') evalIn: interpreter)
		equals: false.
	self
		assert: ((parser condition parse: '1 <= 2 <= 3') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '1 <= 3 <= 2') evalIn: interpreter)
		equals: false
]
