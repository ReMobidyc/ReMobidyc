Extension { #name : 'RMDGreaterThanNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDGreaterThanNodeTest >> testEvalIn [
	self
		assert: ((parser condition parse: '2 > 1') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '1 > 1') evalIn: interpreter)
		equals: false.
	self
		assert: ((parser condition parse: '1 > 2') evalIn: interpreter)
		equals: false.
	self
		assert: ((parser condition parse: '3 > 2 > 1') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '2 > 1 > 3') evalIn: interpreter)
		equals: false
]
