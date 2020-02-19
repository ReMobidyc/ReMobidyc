Extension { #name : #RMDDifferentialVariableNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDDifferentialVariableNodeTest >> testEvalIn [
	interpreter deltaTime: 0.1.
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	interpreter memory
		nextAt: 1 put: 2;
		tick;
		nextAt: 1 put: 3;
		tick.
	self
		assert: ((parser expression parse: 'foo''s d/dt x') evalIn: interpreter)
		closeTo: 10.0.
	self
		should: [ (parser expression parse: 'my delta x') evalIn: interpreter ]
		raise: KeyNotFound.
	self
		should: [ (parser expression parse: 'foo''s delta y') evalIn: interpreter ]
		raise: KeyNotFound
]
