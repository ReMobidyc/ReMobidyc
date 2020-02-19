Class {
	#name : #RMDInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'dt'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDInterpreterTest >> setUp [
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDContext new;
		deltaTime: 60.0;
		yourself.
	dt := interpreter deltaTime
]

{ #category : #tests }
RMDInterpreterTest >> testReadDeltaAgentIfAbsent [
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	interpreter memory
		at: 1 put: 4;
		nextAt: 1 put: 7;
		tick.
	self
		assert: (interpreter readDelta: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: 7 - 4.
	self
		assert: (interpreter readDelta: 'y' agent: 'foo' ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (interpreter readDelta: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #tests }
RMDInterpreterTest >> testReadDifferential2AgentIfAbsent [
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	interpreter memory
		at: 1 put: 4;
		nextAt: 1 put: 7;
		tick;
		nextAt: 1 put: 12;
		tick.
	self
		assert: (interpreter readDifferential2: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: ((12 - 7) / dt - ((7 - 4) / dt)) / dt.
	self
		assert: (interpreter readDifferential2: 'y' agent: 'foo' ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (interpreter readDifferential2: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #tests }
RMDInterpreterTest >> testReadDifferentialAgentIfAbsent [
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	interpreter memory
		at: 1 put: 4;
		nextAt: 1 put: 7;
		tick.
	self
		assert: (interpreter readDifferential: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: (7 - 4) / dt.
	self
		assert: (interpreter readDelta: 'y' agent: 'foo' ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (interpreter readDelta: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #tests }
RMDInterpreterTest >> testReadUtilityIfAbsent [
	| parser source |
	parser := RMDGrammar new.
	source := '
to test is
	my delta x'' = two
where
	x = y + 2
	y = 3.' trim.
	interpreter context action: (parser actionDefinition parse: source).
	self
		assert: (interpreter readUtility: 'x' ifAbsent: [ nil ])
		closeTo: 3 + 2.
	self
		assert: (interpreter readUtility: 'y' ifAbsent: [ nil ])
		closeTo: 3.
	self assert: (interpreter readUtility: 'z' ifAbsent: [ nil ]) isNil
]

{ #category : #tests }
RMDInterpreterTest >> testReadVariableAgentIfAbsent [
	interpreter context setMemoryAddressFor: 'x' agent: 'foo' to: 1.
	interpreter memory
		nextAt: 1 put: 2;
		tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: 2.
	self
		assert: (interpreter readDelta: 'y' agent: 'foo' ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (interpreter readDelta: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #tests }
RMDInterpreterTest >> testWriteToDeltaAgentIfAbsent [
	interpreter context
		setMemoryAddressFor: 'x' agent: 'foo' to: 1;
		setMemoryAddressFor: 'x' agent: 'bar' to: 2.
	interpreter memory
		nextAt: 1 put: 3;
		nextAt: 2 put: 4;
		tick.
	interpreter
		write: 5.0
			toDelta: 'x'
			agent: 'foo'
			ifAbsent: [ nil ];
		write: 6.0
			toDelta: 'x'
			agent: 'bar'
			ifAbsent: [ nil ];
		write: 7.0
			toDelta: 'x'
			agent: 'foo'
			ifAbsent: [ nil ].
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: 3 + 5.0 + 7.0.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		closeTo: 4 + 6.0
]

{ #category : #tests }
RMDInterpreterTest >> testWriteToUtility [
	interpreter
		write: 1.0 toUtility: 'foo';
		write: 2.0 toUtility: 'bar'.
	self
		assert: (interpreter readUtility: 'foo' ifAbsent: [ nil ])
		closeTo: 1.0.
	self
		assert: (interpreter readUtility: 'bar' ifAbsent: [ nil ])
		closeTo: 2.0.
	self
		assert: (interpreter readUtility: 'nothing' ifAbsent: [ nil ]) isNil
]

{ #category : #tests }
RMDInterpreterTest >> testWriteToVariableAgentIfAbsent [
	interpreter context
		setMemoryAddressFor: 'x' agent: 'foo' to: 1;
		setMemoryAddressFor: 'x' agent: 'bar' to: 2.
	interpreter memory
		nextAt: 1 put: 3;
		nextAt: 2 put: 4;
		tick.
	interpreter
		write: 5.0
			toVariable: 'x'
			agent: 'foo'
			ifAbsent: [ nil ];
		write: 6.0
			toVariable: 'x'
			agent: 'bar'
			ifAbsent: [ nil ];
		write: 7.0
			toVariable: 'x'
			agent: 'foo'
			ifAbsent: [ nil ].
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: 7.0.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		closeTo: 6.0
]
