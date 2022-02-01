Extension { #name : #RMDDeltaVariableNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDDeltaVariableNodeTest >> testAssignIn [
	interpreter context setMemoryAddressFor: 'x' agent: 'bar' to: 2.
	interpreter memory
		nextAt: 2 put: 4;
		tick.
	self
		assert:
			((parser attributeDefinition parse: 'bar''s delta x'' = 6')
				evalIn: interpreter)
		closeTo: 6.
	self
		assert:
			((parser attributeDefinition parse: 'bar''s delta x'' = 7')
				evalIn: interpreter)
		closeTo: 7.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: 4.
	self assert: (interpreter memory at: 2) equals: 4.
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		closeTo: 4 + 6 + 7.
	self assert: (interpreter memory at: 2) closeTo: 4 + 6 + 7
]
