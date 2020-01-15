Extension { #name : #RMDNegationNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDNegationNodeTest >> testEvalIn [
	self
		assert: ((parser condition parse: 'not 1 = 2') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: 'not 1 = 1') evalIn: interpreter)
		equals: false
]
