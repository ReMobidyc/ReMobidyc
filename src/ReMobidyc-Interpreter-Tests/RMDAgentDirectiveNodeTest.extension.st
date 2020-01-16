Extension { #name : #RMDAgentDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDAgentDirectiveNodeTest >> testEvalIn [
	interpreter context setMemoryAddressFor: 'x' agent: nil to: 1.
	interpreter context setMemoryAddressFor: 'y' agent: nil to: 2.
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 3.
	interpreter context setMemoryAddressFor: 'y' agent: 'foo' to: 4.
	interpreter memory
		nextAt: 1 put: 2.0;
		nextAt: 2 put: 3.0;
		nextAt: 3 put: 5.0;
		nextAt: 4 put: 7.0;
		tick.
	self
		assert: ((parser expression parse: 'distance foo') evalIn: interpreter)
		closeTo: (3 * 3 + (4 * 4)) sqrt.
	self
		assert: ((parser expression parse: 'direction foo') evalIn: interpreter)
		closeTo: (3 @ 4) theta
]
