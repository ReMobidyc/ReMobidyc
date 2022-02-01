Extension { #name : #RMDVariableNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDVariableNodeTest >> testAssignIn [
	interpreter memory
		nextAt: 1 put: 3;
		tick.
	interpreter context
		setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	self
		assert: ((parser assignableAttributeVariable parse: 'foo''s x') assign: 5 in: interpreter)
		equals: 5.
	self assert: (interpreter memory nextAt: 1) closeTo: 5.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		equals: 3.
	self assert: (interpreter memory at: 1) equals: 3.
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: 5.
	self assert: (interpreter memory at: 1) closeTo: 5
]

{ #category : #'*ReMobidyc-Interpreter-Tests' }
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
