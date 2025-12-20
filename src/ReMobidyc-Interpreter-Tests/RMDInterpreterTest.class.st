Class {
	#name : 'RMDInterpreterTest',
	#superclass : 'TestCase',
	#instVars : [
		'interpreter'
	],
	#category : 'ReMobidyc-Interpreter-Tests',
	#package : 'ReMobidyc-Interpreter-Tests'
}

{ #category : 'running' }
RMDInterpreterTest >> setUp [

	interpreter := RMDInterpreter new
		               setMemory: RMDOnMemory new;
		               setContext: RMDActionContext new;
		               yourself
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
RMDInterpreterTest >> testLoadDataSources [

	| parser memory inputs |
	parser := RMDGrammar current.
	memory := interpreter memory.
	interpreter
		load: ((parser worldDefinition end parse: 'World with
	temperature [DegreeC].')
				 dataSource: (RMDDataSource dataFrame: (DataFrame
								   withRows: #( #( 0.0 30.0 ) #( 10.0 30.1 ) )
								   columnNames: #( 'time[s]' 'temperature[DegreeC] linear' )));
				 yourself);
		load: ((parser patchDefinition end parse: 'Patch with
	grass [m].')
				 dataSource: (RMDDataSource dataFrame: (DataFrame
								   withRows: #( #( 0.0 1.0 ) #( 10.0 0.0 ) )
								   columnNames: #( 'time[s]' 'grass[m] linear' )));
				 yourself);
		load: ((parser animatDefinition parse: 'Goat is Animat with
	body [kg].')
				 dataSource: (RMDDataSource dataFrame: (DataFrame
								   withRows: #( #( 0.0 100.0 ) #( 10.0 200.0 ) )
								   columnNames: #( 'time[s]' 'body[kg] linear' )));
				 yourself);
		load: (parser simulationDefinition parse: 'Simulation with
	during 10 [s] by 2 [s]
	World
	5 x 6 of 10 [m] Patch
	10 Goat.').
	interpreter loadDataSources.
	inputs := memory instVarNamed: 'inputs'.
	self
		assert: inputs keys asSet
		equals: #( 'World' 'Patch' 'Goat' ) asSet.
	self
		assert: (((inputs at: 'World') at: 0) collect: [ :n | n round: 3 ])
		equals: #( 30.0 30.02 30.04 30.06 30.08 30.1 ).
	self
		assert: (((inputs at: 'Patch') at: 0) collect: [ :n | n round: 3 ])
		equals: #( 1.0 0.8 0.6 0.4 0.2 0.0 ).
	self
		assert: (((inputs at: 'Goat') at: 2) collect: [ :n | n round: 3 ])
		equals: #( 100.0 120.0 140.0 160.0 180.0 200.0 )
]

{ #category : 'tests' }
RMDInterpreterTest >> testReadUtilityIfAbsent [
	| parser source |
	parser := RMDGrammar current.
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

{ #category : 'tests' }
RMDInterpreterTest >> testSetUpSimulation [
	| parser memory kcal celsius |
	parser := RMDGrammar current.
	memory := interpreter memory.
	interpreter
		load:
			(parser worldDefinition end
				parse:
					'World with
	temperature [DegreeC].');
		load:
			(parser patchDefinition end
				parse:
					'Patch with
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
	5 x 6 of 10 [m] Patch with
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
	2 to: 5 * 6 * 2 + 1 by: 2 do: [ :patch | 
		self
			assert: ((memory at: patch) between: (kcal toSI: 1000) and: (kcal toSI: 5000)).
		self assert: (memory at: patch + 1) closeTo: (kcal toSI: 2000) ].
	5 * 6 * 2 + 1 + 1 to: 5 * 6 * 2 + 1 + (10 * 4) by: 4 do: [ :goat | 
		self assert: ((memory at: goat) between: 0.0 and: 50.0).
		self assert: ((memory at: goat + 1) between: 0.0 and: 60.0).
		self assert: (memory at: goat + 2) closeTo: (kcal toSI: 10000).
		self assert: (memory at: goat + 3) closeTo: 0.0 ]
]

{ #category : 'tests' }
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
