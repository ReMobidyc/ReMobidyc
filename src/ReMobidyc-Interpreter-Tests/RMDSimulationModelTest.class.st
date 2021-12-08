Class {
	#name : #RMDSimulationModelTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'model'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDSimulationModelTest >> setUp [
	parser := RMDGrammar new.
	model := RMDSimulationModel new
]

{ #category : #running }
RMDSimulationModelTest >> testActionDefinitionAtIfAbsent [
	| action |
	action := parser actionDefinition end
		parse:
			'to walk is
	my d/dt x'' = cos(heading) * my speed
	my d/dt y'' = sin(heading) * my speed.'.
	model addActionDefinition: action.
	self
		assert: (model actionDefinitionAt: 'walk' ifAbsent: [ nil ])
		equals: action.
	self
		assert: (model actionDefinitionAt: 'run' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #running }
RMDSimulationModelTest >> testActionDefinitionAtIfPresent [
	| action |
	action := parser actionDefinition end
		parse:
			'to walk is
	my d/dt x'' = cos(heading) * my speed
	my d/dt y'' = sin(heading) * my speed.'.
	model addActionDefinition: action.
	self
		assert: (model actionDefinitionAt: 'walk' ifPresent: [:def | def ])
		equals: action.
	self
		assert: (model actionDefinitionAt: 'run' ifPresent: [ nil ])
		equals: nil
]

{ #category : #running }
RMDSimulationModelTest >> testActionNames [
	model
		addActionDefinition:
			(parser actionDefinition end
				parse:
					'to walk is
	my d/dt x'' = cos(heading) * my speed
	my d/dt y'' = sin(heading) * my speed.').
	model
		addActionDefinition:
			(parser actionDefinition end
				parse:
					'to run is
	my d/dt x'' = cos(heading) * my max_speed
	my d/dt y'' = sin(heading) * my max_speed.').
	self
		assert: model actionNames asArray
		equals: #('walk' 'run') asSortedCollection asArray
]

{ #category : #running }
RMDSimulationModelTest >> testAddActionDefinition [
	| action |
	action := parser actionDefinition end
		parse:
			'to walk is
	my d/dt x'' = cos(heading) * my speed
	my d/dt y'' = sin(heading) * my speed.'.
	self
		assert: (model actionDefinitionAt: 'walk' ifAbsent: [ nil ])
		equals: nil.
	model addActionDefinition: action.
	self
		assert: (model actionDefinitionAt: 'walk' ifAbsent: [ nil ])
		equals: action.
	action := parser actionDefinition end
		parse:
			'to walk is
	my d/dt x'' = cos(heading) * my speed
	my d/dt y'' = sin(heading) * my speed.'.
	model addActionDefinition: action.
	self
		assert: (model actionDefinitionAt: 'walk' ifAbsent: [ nil ])
		equals: action
]

{ #category : #running }
RMDSimulationModelTest >> testAddAnimatDefinition [
	| animat |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	speed [km/h].'.
	self
		assert: (model animatDefinitionAt: 'Goat' ifAbsent: [ nil ])
		equals: nil.
	model addAnimatDefinition: animat.
	self
		assert: (model animatDefinitionAt: 'Goat' ifAbsent: [ nil ])
		equals: animat.
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	walking_speed [km/h]
	running_speed [km/h].'.
	model addAnimatDefinition: animat.
	self
		assert: (model animatDefinitionAt: 'Goat' ifAbsent: [ nil ])
		equals: animat
]

{ #category : #running }
RMDSimulationModelTest >> testAddRenderer [
	| backgroundRenderer colorAlphaRenderer |
	backgroundRenderer := RMDBackgroundColorRenderer color: Color red.
	colorAlphaRenderer := RMDCellColorAlphaRenderer
		color: Color white
		alpha: 'my x' asRMDExpression
		between: 0
		and: 100.
	model
		addRenderer: backgroundRenderer;
		addRenderer: colorAlphaRenderer.
	self
		assert: model renderers asSet
		equals:
			{backgroundRenderer.
			colorAlphaRenderer} asSet
]

{ #category : #running }
RMDSimulationModelTest >> testAddTaskDefinition [
	| task |
	task := parser taskDefinition end
		parse:
			'Goat walk with
	my speed -> my walking_speed.'.
	model addTaskDefinition: task.
	self
		assert:
			(Array
				streamContents: [ :stream | model tasksDo: [ :b | stream nextPut: b ] ])
		equals: {task}
]

{ #category : #running }
RMDSimulationModelTest >> testAnimatDefinitionAtIfAbsent [
	| animat |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	speed [km/h].'.
	model addAnimatDefinition: animat.
	self
		assert: (model animatDefinitionAt: 'Goat' ifAbsent: [ nil ])
		equals: animat.
	self
		assert: (model animatDefinitionAt: 'Wolf' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #running }
RMDSimulationModelTest >> testAnimatDefinitionAtIfPresent [
	| animat |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	speed [km/h].'.
	model addAnimatDefinition: animat.
	self
		assert: (model animatDefinitionAt: 'Goat' ifPresent: [ :def | def ])
		equals: animat.
	self
		assert: (model animatDefinitionAt: 'Wolf' ifPresent: [ :def | def ])
		equals: nil
]

{ #category : #running }
RMDSimulationModelTest >> testAnimatDefinitionsDo [
	| animat1 animat2 animat3 |
	animat1 := parser animatDefinition end
		parse:
			'Goat is Animat with
	speed [km/h].'.
	animat2 := parser animatDefinition end
		parse:
			'Sheep is Animat with
	speed [km/h].'.
	animat3 := parser animatDefinition end
		parse:
			'Wolf is Animat with
	speed [km/h].'.
	model
		addAnimatDefinition: animat1;
		addAnimatDefinition: animat2;
		addAnimatDefinition: animat3.
	self
		assert:
			(Array
				streamContents: [ :stream | model animatDefinitionsDo: [ :a | stream nextPut: a ] ])
				asSet
		equals:
			{animat1.
			animat2.
			animat3} asSet
]

{ #category : #running }
RMDSimulationModelTest >> testAnimatInitializersDo [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self
		assert:
			(Array
				streamContents: [ :stream | model animatInitializersDo: [ :i | stream nextPut: i ] ])
				asSet
		equals: sim animatInitializers asSet
]

{ #category : #running }
RMDSimulationModelTest >> testCellDefinition [
	| cell |
	cell := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal].'.
	model cellDefinition: cell.
	self assert: model cellDefinition equals: cell
]

{ #category : #running }
RMDSimulationModelTest >> testCellInitializer [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self
		assert: model cellInitializer
		equals:
			(parser cellInitializer end
				parse:
					'5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]')
]

{ #category : #running }
RMDSimulationModelTest >> testCellLength [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model cellLength closeTo: 10.0.
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 400 [m^2] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model cellLength closeTo: 20.0.

]

{ #category : #running }
RMDSimulationModelTest >> testCellXDivisions [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model cellXDivisions equals: 5
]

{ #category : #running }
RMDSimulationModelTest >> testCellYDivisions [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model cellYDivisions equals: 6
]

{ #category : #running }
RMDSimulationModelTest >> testDeltaTime [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model deltaTime closeTo: 12 * 60 * 60
]

{ #category : #running }
RMDSimulationModelTest >> testDuration [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model duration closeTo: 300 * 24 * 60 * 60
]

{ #category : #running }
RMDSimulationModelTest >> testEast [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model east closeTo: 50
]

{ #category : #running }
RMDSimulationModelTest >> testLoadAnimatDefinition [
	| animat |
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	speed [km/h].'.
	self
		assert: (model animatDefinitionAt: 'Goat' ifAbsent: [ nil ])
		equals: nil.
	model addAnimatDefinition: animat.
	self
		assert: (model animatDefinitionAt: 'Goat' ifAbsent: [ nil ])
		equals: animat.
	animat := parser animatDefinition end
		parse:
			'Goat is Animat with
	walking_speed [km/h]
	running_speed [km/h].'.
	model addAnimatDefinition: animat.
	self
		assert: (model animatDefinitionAt: 'Goat' ifAbsent: [ nil ])
		equals: animat
]

{ #category : #running }
RMDSimulationModelTest >> testNorth [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model north closeTo: 60
]

{ #category : #running }
RMDSimulationModelTest >> testRenderersDo [
	| backgroundRenderer colorAlphaRenderer |
	backgroundRenderer := RMDBackgroundColorRenderer color: Color red.
	colorAlphaRenderer := RMDCellColorAlphaRenderer
		color: Color white
		alpha: 'my x' asRMDExpression
		between: 0
		and: 100.
	model
		addRenderer: backgroundRenderer;
		addRenderer: colorAlphaRenderer.
	self
		assert:
			(Array
				streamContents:
					[ :stream | model renderersDo: [ :renderer | stream nextPut: renderer ] ])
				asSet
		equals:
			{backgroundRenderer.
			colorAlphaRenderer} asSet
]

{ #category : #running }
RMDSimulationModelTest >> testSimulationDefinition [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model simulationDefinition equals: sim
]

{ #category : #running }
RMDSimulationModelTest >> testSouth [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model south closeTo: 0
]

{ #category : #running }
RMDSimulationModelTest >> testTaskDefinitions [
	| task1 task2 task3 |
	task1 := parser taskDefinition end parse: 'Goat walk.'.
	model addTaskDefinition: task1.
	task2 := parser taskDefinition end
		parse:
			'Goat eat where
	my energy -> my blood_sugar
	here''s energy -> here''s grass.'.
	model addTaskDefinition: task2.
	task3 := parser taskDefinition end
		parse:
			'Wolf walk where
	my speed -> my walking_speed.'.
	model addTaskDefinition: task3.
	self
		assert: model taskDefinitions
		equals:
			{task1.
			task2.
			task3}
]

{ #category : #running }
RMDSimulationModelTest >> testTaskDo [
	| task1 task2 task3 |
	task1 := parser taskDefinition end parse: 'Goat walk.'.
	model addTaskDefinition: task1.
	task2 := parser taskDefinition end
		parse:
			'Goat eat where
	my energy -> my blood_sugar
	here''s energy -> here''s grass.'.
	model addTaskDefinition: task2.
	task3 := parser taskDefinition end
		parse:
			'Wolf walk where
	my speed -> my walking_speed.'.
	model addTaskDefinition: task3.
	self
		assert:
			(Array
				streamContents: [ :stream | model tasksDo: [ :b | stream nextPut: b ] ])
				asSet
		equals:
			{task1.
			task2.
			task3} asSet
]

{ #category : #running }
RMDSimulationModelTest >> testTaskNames [
	| task1 task2 task3 |
	task1 := parser taskDefinition end parse: 'Goat walk.'.
	model addTaskDefinition: task1.
	task2 := parser taskDefinition end
		parse:
			'Goat eat
where
	the energy -> my blood_sugar.'.
	model addTaskDefinition: task2.
	task3 := parser taskDefinition end
		parse:
			'Wolf walk
where
	the speed -> my walking_speed.'.
	model addTaskDefinition: task3.
	self
		assert: model taskNames
		equals: #('Goat walk' 'Goat eat' 'Wolf walk') asSortedCollection
]

{ #category : #running }
RMDSimulationModelTest >> testWest [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self assert: model west closeTo: 0
]

{ #category : #running }
RMDSimulationModelTest >> testWorldDefinition [
	| world |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [C].' trim.
	self assert: world isWorldDefinitionNode.
	model worldDefinition: world.
	self assert: model worldDefinition equals: world
]

{ #category : #running }
RMDSimulationModelTest >> testWorldInitializer [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [C]
5 x 6 of 10 [m] Cell with
    grass = uniform 1000[kcal] to 5000[kcal]
10 Goat with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day]
2 Wolf with
    x = uniform 0[m] to 50[m]
    y = uniform 0[m] to 50[m]
    blood_sugar = 1000[kcal]
    age = 0[day].' trim.
	self assert: sim isSimulationDefinitionNode.
	model simulationDefinition: sim.
	self
		assert: model worldInitializer
		equals:
			(parser worldInitializer end
				parse:
					'World with
	temperature = 30 [C]')
]
