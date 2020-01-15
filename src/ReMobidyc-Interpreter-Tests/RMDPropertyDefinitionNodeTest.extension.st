Extension { #name : #RMDPropertyDefinitionNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDPropertyDefinitionNodeTest >> testEvalIn [
	interpreter context
		setMemoryAddressFor: 'x' agent: 'foo' to: 1;
		setMemoryAddressFor: 'x' agent: 'bar' to: 2.
	interpreter memory
		nextAt: 1 put: 3;
		nextAt: 2 put: 4;
		tick.
	self
		assert:
			((parser propertyDefinition parse: 'foo''s x'' = 5')
				evalIn: interpreter)
		closeTo: 5.
	self assert: (interpreter memory nextAt: 1) closeTo: 5.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		equals: 3.
	self assert: (interpreter memory at: 1) equals: 3.
	self
		assert:
			((parser propertyDefinition parse: 'bar''s delta x'' = 6')
				evalIn: interpreter)
		closeTo: 6.
	self
		assert:
			((parser propertyDefinition parse: 'bar''s delta x'' = 7')
				evalIn: interpreter)
		closeTo: 7.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: 4.
	self assert: (interpreter memory at: 2) equals: 4.
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: 5.
	self assert: (interpreter memory at: 1) closeTo: 5.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		closeTo: 4 + 6 + 7.
	self assert: (interpreter memory at: 2) closeTo: 4 + 6 + 7
]
