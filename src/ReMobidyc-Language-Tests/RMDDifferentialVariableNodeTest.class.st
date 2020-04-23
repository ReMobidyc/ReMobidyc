Class {
	#name : #RMDDifferentialVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDifferentialVariableNodeTest >> testAssignIn [
	| dt |
	dt := interpreter deltaTime.
	interpreter context setMemoryAddressFor: 'x' agent: 'bar' to: 2.
	interpreter memory
		nextAt: 2 put: 4;
		tick.
	self
		assert:
			((parser propertyDefinition parse: 'bar''s d/dt x'' = 6')
				evalIn: interpreter)
		closeTo: 6.
	self
		assert:
			((parser propertyDefinition parse: 'bar''s d/dt x'' = 7')
				evalIn: interpreter)
		closeTo: 7.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: 4.
	self assert: (interpreter memory at: 2) equals: 4.
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		closeTo: 4 + (6 * dt) + (7 * dt).
	self assert: (interpreter memory at: 2) closeTo: 4 + (6 * dt) + (7 * dt)
]

{ #category : #tests }
RMDDifferentialVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser propertyDefinition end parse: 'my d/dt x'' = foo'.
	replacement := Dictionary new
		at: (parser differentialVariable end parse: 'my d/dt x')
			put: (parser differentialVariable end parse: 'my d/dt y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser propertyDefinition end parse: 'my d/dt y'' = foo')
]
