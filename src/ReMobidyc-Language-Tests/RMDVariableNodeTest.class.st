Class {
	#name : #RMDVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDVariableNodeTest >> testEvalIn [
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	interpreter memory
		nextAt: 1 put: 2;
		tick.
	self
		assert: ((parser expression parse: 'foo''s x') evalIn: interpreter)
		closeTo: 2.0.
	self
		should: [ (parser expression parse: 'my x') evalIn: interpreter ]
		raise: KeyNotFound.
	self
		should: [ (parser expression parse: 'foo''s y') evalIn: interpreter ]
		raise: KeyNotFound
]
