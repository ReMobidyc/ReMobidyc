Class {
	#name : #RMDInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDInterpreterTest >> setUp [
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		yourself
]

{ #category : #tests }
RMDInterpreterTest >> testAddLibraries [
	| foo bar buzz |
	foo := [ :x :y | x + y ].
	bar := [ :x | x abs ].
	buzz := [ :x :y | x ** y ].
	interpreter
		addLibraries:
			{{('foo' -> foo).
			('bar' -> bar)} asDictionary.
			{('buzz' -> buzz)} asDictionary}.
	self
		assert: (interpreter functionAt: 'foo' ifAbsent: [ nil ])
		equals: foo.
	self
		assert: (interpreter functionAt: 'bar' ifAbsent: [ nil ])
		equals: bar.
	self
		assert: (interpreter functionAt: 'buzz' ifAbsent: [ nil ])
		equals: buzz
]

{ #category : #tests }
RMDInterpreterTest >> testAddLibrary [
	| foo bar buzz |
	foo := [ :x :y | x + y ].
	bar := [ :x | x abs ].
	buzz := [ :x :y | x ** y ].
	interpreter
		addLibraries:
			{{('foo' -> foo).
			('bar' -> bar).
			('buzz' -> buzz)} asDictionary}.
	self
		assert: (interpreter functionAt: 'foo' ifAbsent: [ nil ])
		equals: foo.
	self
		assert: (interpreter functionAt: 'bar' ifAbsent: [ nil ])
		equals: bar.
	self
		assert: (interpreter functionAt: 'buzz' ifAbsent: [ nil ])
		equals: buzz
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
	interpreter context
		setMemoryAddressFor: 'x' agent: 'foo' to: 1;
		setMemoryAddressFor: 'x' agent: 'bar' to: 2.
	interpreter memory
		nextAt: 1 put: 3;
		nextAt: 2 put: 4;
		tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		equals: 3.
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		equals: 4.
	self
		assert: (interpreter readVariable: 'x' agent: 'buzz' ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (interpreter readVariable: 'y' agent: 'foo' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #tests }
RMDInterpreterTest >> testSetUpSimulation [
	| parser memory kcal celsius |
	parser := RMDGrammar new.
	memory := interpreter memory.
	interpreter
		load:
			(parser worldDefinition end
				parse:
					'World with
	temperature [DegreeC].');
		load:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]
	fertility [kcal].');
		load:
			(parser animatDefinition
				parse:
					'Goat is Animat with
	body [kcal]
	age [day].');
		load:
			(parser simulationDefinition
				parse: 'Simulation with
	during 300 [day] by 0.5 [day]
	World with
		temperature = 30 [DegreeC]
	5 x 6 of 10 [m] Cell with
		grass = uniform 1000 [kcal] to 5000 [kcal]
		fertility = 2000 [kcal]
	10 Goat with
		x = uniform 0 [m] to 50 [m]
		y = uniform 0 [m] to 60 [m]
		body = 10000 [kcal]
		age = 0 [day].').
	interpreter setupSimulation.
	kcal := RMDUnit kcal.
	celsius := RMDUnit celsius.
	self assert: (memory at: 1) closeTo: (celsius toSI: 30).
	2 to: 5 * 6 * 2 + 1 by: 2 do: [ :cell | 
		self
			assert: ((memory at: cell) between: (kcal toSI: 1000) and: (kcal toSI: 5000)).
		self assert: (memory at: cell + 1) closeTo: (kcal toSI: 2000) ].
	5 * 6 * 2 + 1 + 1 to: 5 * 6 * 2 + 1 + (10 * 4) by: 4 do: [ :goat | 
		self assert: ((memory at: goat) between: 0.0 and: 50.0).
		self assert: ((memory at: goat + 1) between: 0.0 and: 60.0).
		self assert: (memory at: goat + 2) closeTo: (kcal toSI: 10000).
		self assert: (memory at: goat + 3) closeTo: 0.0 ]
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
RMDInterpreterTest >> testWriteToDifferentialAgentIfAbsent [
	| dt |
	interpreter context
		setMemoryAddressFor: 'x' agent: 'foo' to: 1;
		setMemoryAddressFor: 'x' agent: 'bar' to: 2.
	interpreter memory
		nextAt: 1 put: 3;
		nextAt: 2 put: 4;
		tick.
	dt := interpreter deltaTime.
	interpreter
		write: 5.0
			toDifferential: 'x'
			agent: 'foo'
			ifAbsent: [ nil ];
		write: 6.0
			toDifferential: 'x'
			agent: 'bar'
			ifAbsent: [ nil ];
		write: 7.0
			toDifferential: 'x'
			agent: 'foo'
			ifAbsent: [ nil ].
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'x' agent: 'foo' ifAbsent: [ nil ])
		closeTo: 3 + (5.0 * dt) + (7.0 * dt).
	self
		assert: (interpreter readVariable: 'x' agent: 'bar' ifAbsent: [ nil ])
		closeTo: 4 + (6.0 * dt)
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
