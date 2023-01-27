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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
RMDSimulationModelTest >> testAddRenderer [
	| backgroundRenderer colorAlphaRenderer |
	backgroundRenderer := RMDBackgroundColorRenderer color: Color red.
	colorAlphaRenderer := RMDPatchColorAlphaRenderer
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
RMDSimulationModelTest >> testAnimatInitializersDo [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
RMDSimulationModelTest >> testDeltaTime [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
RMDSimulationModelTest >> testDuration [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
RMDSimulationModelTest >> testEast [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
RMDSimulationModelTest >> testInstantiateWithMetaParameters [

	| sim sim1 |
	sim := RMDSimulationModel new.
	sim load: (parser simulationDefinition end parse: '
Simulation with
	during 300[day] by 1[day]
World
1 x 1 of 1 [m] Patch.' trim).
	sim load: (parser worldDefinition end parse: '
World with
	temperature [DegreeC] = the temp.' trim).
	sim load: (parser actionDefinition end parse: '
to warm is
	my delta temperature'' = the tempStep.' trim).
	sim load: (parser taskDefinition end parse: '
World warm
where
	the tempStep -> 0 [DegreeC].' trim).
	sim1 := sim instantiateWithMetaParameters: { 
			        ('the temp' asRMDExpression
			         -> '20 [DegreeC]' asRMDExpression).
			        ('the tempStep' asRMDExpression
			         -> '1 [DegreeC]' asRMDExpression) } asOrderedDictionary.
	self
		assert:
		sim worldDefinition attributeDeclarations first
			initializerExpression
		equals: 'the temp' asRMDExpression.
	self
		assert:
		sim1 worldDefinition attributeDeclarations first
			initializerExpression
		equals: '20 [DegreeC]' asRMDExpression.
	self
		assert: (sim actionDefinitionAt: 'warm' ifAbsent: [ self fail ])
				attributeDefinitions first definitionBody
		equals: 'the tempStep' asRMDExpression.
	self
		assert: (sim1 actionDefinitionAt: 'warm' ifAbsent: [ self fail ])
				attributeDefinitions first definitionBody
		equals: 'the tempStep' asRMDExpression.
	self
		assert: sim taskDefinitions first parameterInstantiations
		equals: { (parser parameterInstantiation end parse:
				 'the tempStep -> 0 [DegreeC]') }.
	self
		assert: sim1 taskDefinitions first parameterInstantiations
		equals: { 
				(parser parameterInstantiation end parse:
					 'the tempStep -> 0 [DegreeC]').
				(parser parameterInstantiation end parse:
					 'the temp -> 20 [DegreeC]') }.
	self
		assert: (sim taskDefinitions first actionWith: sim)
		equals: (sim1 taskDefinitions first actionWith: sim1)
]

{ #category : #tests }
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

{ #category : #tests }
RMDSimulationModelTest >> testNorth [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
RMDSimulationModelTest >> testPatchDefinition [

	| patch |
	patch := parser patchDefinition end parse: 'Patch with
	grass [kcal].'.
	model patchDefinition: patch.
	self assert: model patchDefinition equals: patch
]

{ #category : #tests }
RMDSimulationModelTest >> testPatchInitializer [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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
		assert: model patchInitializer
		equals:
			(parser patchInitializer end
				parse:
					'5 x 6 of 10 [m] Patch with
    grass = uniform 1000[kcal] to 5000[kcal]')
]

{ #category : #tests }
RMDSimulationModelTest >> testPatchLength [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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
	self assert: model patchLength closeTo: 10.0.
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 400 [m^2] Patch with
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
	self assert: model patchLength closeTo: 20.0.

]

{ #category : #tests }
RMDSimulationModelTest >> testPatchXDivisions [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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
	self assert: model patchXDivisions equals: 5
]

{ #category : #tests }
RMDSimulationModelTest >> testPatchYDivisions [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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
	self assert: model patchYDivisions equals: 6
]

{ #category : #tests }
RMDSimulationModelTest >> testRenderersDo [
	| backgroundRenderer colorAlphaRenderer |
	backgroundRenderer := RMDBackgroundColorRenderer color: Color red.
	colorAlphaRenderer := RMDPatchColorAlphaRenderer
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

{ #category : #tests }
RMDSimulationModelTest >> testSimulationDefinition [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
RMDSimulationModelTest >> testSouth [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
RMDSimulationModelTest >> testWest [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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

{ #category : #tests }
RMDSimulationModelTest >> testWorldDefinition [
	| world |
	world := parser worldDefinition end
		parse:
			'World with
	temperature [DegreeC].' trim.
	self assert: world isWorldDefinitionNode.
	model worldDefinition: world.
	self assert: model worldDefinition equals: world
]

{ #category : #tests }
RMDSimulationModelTest >> testWorldInitializer [
	| sim |
	sim := parser simulationDefinition end
		parse:
			'
Simulation with
	during 300[day] by 0.5[day]
World with
	temperature = 30 [DegreeC]
5 x 6 of 10 [m] Patch with
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
	temperature = 30 [DegreeC]')
]
