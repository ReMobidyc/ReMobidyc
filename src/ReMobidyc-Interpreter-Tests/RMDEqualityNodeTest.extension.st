Extension { #name : 'RMDEqualityNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
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
