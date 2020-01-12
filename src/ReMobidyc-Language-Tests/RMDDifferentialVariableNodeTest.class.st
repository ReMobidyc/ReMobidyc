Class {
	#name : #RMDDifferentialVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDifferentialVariableNodeTest >> testEvalIn [
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	interpreter memory
		deltaTime: 0.1;
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
