Extension { #name : #RMDNDisjunctionNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDNDisjunctionNodeTest >> testEvalIn [
	self
		assert: ((parser condition parse: '1 = 1 or 2 = 2') evalIn: interpreter)
		equals: true.
	self
		assert: ((parser condition parse: '1 = 2 or 2 = 3') evalIn: interpreter)
		equals: false.
	self
		assert:
			((parser condition parse: '1 = 2 or 2 = 3 or 3 = 3')
				evalIn: interpreter)
		equals: true.
	self
		assert:
			((parser condition parse: '1 = 2 or 2 = 3 or 3 = 4')
				evalIn: interpreter)
		equals: false
]
