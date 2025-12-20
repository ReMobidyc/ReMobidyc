Extension { #name : 'RMDTaskDefinitionNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDTaskDefinitionNodeTest >> testEvalDisabled [

	| model horseDefinition drinkTaskDefinition |
	model := RMDSimulationModel new.
	model
		load: RMDWorldDefinitionNode empty;
		load: RMDPatchDefinitionNode empty;
		load: (horseDefinition := parser animatDefinition end parse:
					                    'Horse is Animat with
		water [].');
		load: (parser actionDefinition end parse: 'to err is
		my delta water'' = 1/0.');
		load: (drinkTaskDefinition := parser taskDefinition end parse:
					                        'Horse drink disabled.');
		load: (RMDSimulationDefinitionNode
				 timeDefinition:
					 (RMDSimulationTimeDefinitionNode during: '10 [s]' by: '1[s]')
				 worldInitializer: RMDWorldInitializerNode empty
				 patchInitializer:
					 (parser patchInitializer end parse: '1x1 of 10 [m] Patch')
				 animatInitializers:
					 { (parser animatInitializer end parse: '1 Horse with
					x = 5[m]
					y = 5[m]
					water = 0 []') }).
	interpreter
		simulationModel: model;
		setupSimulation.
	interpreter tick.
	drinkTaskDefinition evalIn: interpreter
]

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDTaskDefinitionNodeTest >> testEvalEnabled [

	| model horseDefinition drinkTaskDefinition |
	model := RMDSimulationModel new.
	model
		load: RMDWorldDefinitionNode empty;
		load: RMDPatchDefinitionNode empty;
		load: (horseDefinition := parser animatDefinition end parse:
					                    'Horse is Animat with
		water [].');
		load: (parser actionDefinition end parse: 'to err is
		my delta water'' = 1/0.');
		load: (drinkTaskDefinition := parser taskDefinition end parse:
					                        'Horse drink.');
		load: (RMDSimulationDefinitionNode
				 timeDefinition:
					 (RMDSimulationTimeDefinitionNode during: '10 [s]' by: '1[s]')
				 worldInitializer: RMDWorldInitializerNode empty
				 patchInitializer:
					 (parser patchInitializer end parse: '1x1 of 10 [m] Patch')
				 animatInitializers:
					 { (parser animatInitializer end parse: '1 Horse with
					x = 5[m]
					y = 5[m]
					water = 0 []') }).
	interpreter
		simulationModel: model;
		setupSimulation.
	interpreter tick.
	self
		should: [ drinkTaskDefinition evalIn: interpreter ]
		raise: RMDError
]

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDTaskDefinitionNodeTest >> testEvalWithAllObjectsIn [

	| model horseDefinition tankDefinition drinkTaskDefinition waterInTank waterInHorse |
	model := RMDSimulationModel new.
	model
		load: RMDWorldDefinitionNode empty;
		load: RMDPatchDefinitionNode empty;
		load: (horseDefinition := parser animatDefinition end parse:
					                    'Horse is Animat with
		water [kg].');
		load: (tankDefinition := parser animatDefinition end parse:
					                   'Tank is Animat with
		water [kg].');
		load: (parser actionDefinition end parse: 'to drink Something is
		my delta water'' = amount
		something''s delta water'' = -amount
		where
		amount = 1 [kg].');
		load: (drinkTaskDefinition := parser taskDefinition end parse:
					                        'Horse drink Tank within 1[m].');
		load: (RMDSimulationDefinitionNode
				 timeDefinition:
					 (RMDSimulationTimeDefinitionNode during: '10 [s]' by: '1[s]')
				 worldInitializer: RMDWorldInitializerNode empty
				 patchInitializer:
					 (parser patchInitializer end parse: '1x1 of 10 [m] Patch')
				 animatInitializers: { 
						 (parser animatInitializer end parse: '1 Horse with
					x = 5[m]
					y = 5[m]
					water = 0 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 1[m]
					y = 1[m]
					water = 10 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 5[m]
					y = 4.5[m]
					water = 10 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 4.5[m]
					y = 5[m]
					water = 10 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 9[m]
					y = 9[m]
					water = 10 [kg]') }).
	interpreter
		simulationModel: model;
		setupSimulation.
	interpreter tick.
	drinkTaskDefinition evalIn: interpreter.
	interpreter tick.
	waterInTank := 0.0.
	interpreter individualsOf: tankDefinition do: [ :tank | 
		interpreter
			withObserverContextWithSubject: tank
			definition: tankDefinition
			do: [ 
				| x y water |
				x := interpreter my: 'x'.
				y := interpreter my: 'y'.
				water := interpreter my: 'water'.
				self
					assert: water < 9.5
					equals: (x - 5) squared + (y - 5) squared < 1. "water reduced" "within 1m from the horse"
				waterInTank := waterInTank + water ] ].
	self assert: waterInTank closeTo: 40.0 - 2.0. "tanks lost 2kg of water at total."

	waterInHorse := 0.0.
	interpreter individualsOf: horseDefinition do: [ :horse | 
		interpreter
			withObserverContextWithSubject: horse
			definition: horseDefinition
			do: [ waterInHorse := waterInHorse + (interpreter my: 'water') ] ].
	self assert: waterInHorse closeTo: 2.0. "the horse drunk 2kg of water."

	^ interpreter
]

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDTaskDefinitionNodeTest >> testEvalWithNearestObjectsIn [

	| model horseDefinition tankDefinition drinkTaskDefinition waterInTank waterInHorse |
	model := RMDSimulationModel new.
	model
		load: RMDWorldDefinitionNode empty;
		load: RMDPatchDefinitionNode empty;
		load: (horseDefinition := parser animatDefinition end parse:
					                    'Horse is Animat with
		water [kg].');
		load: (tankDefinition := parser animatDefinition end parse:
					                   'Tank is Animat with
		water [kg].');
		load: (parser actionDefinition end parse: 'to drink Something is
		my delta water'' = amount
		something''s delta water'' = -amount
		where
		amount = 1 [kg].');
		load: (drinkTaskDefinition := parser taskDefinition end parse:
					                        'Horse drink nearest Tank within 1[m].');
		load: (RMDSimulationDefinitionNode
				 timeDefinition:
					 (RMDSimulationTimeDefinitionNode during: '10 [s]' by: '1[s]')
				 worldInitializer: RMDWorldInitializerNode empty
				 patchInitializer:
					 (parser patchInitializer end parse: '1x1 of 10 [m] Patch')
				 animatInitializers: { 
						 (parser animatInitializer end parse: '1 Horse with
					x = 5[m]
					y = 5[m]
					water = 0 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 1[m]
					y = 1[m]
					water = 10 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 5[m]
					y = 4.8[m]
					water = 10 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 4.5[m]
					y = 5[m]
					water = 10 [kg]').
						 (parser animatInitializer end parse: '1 Tank with
					x = 9[m]
					y = 9[m]
					water = 10 [kg]') }).
	interpreter
		simulationModel: model;
		setupSimulation.
	interpreter tick.
	drinkTaskDefinition evalIn: interpreter.
	interpreter tick.
	waterInTank := 0.0.
	interpreter individualsOf: tankDefinition do: [ :tank | 
		interpreter
			withObserverContextWithSubject: tank
			definition: tankDefinition
			do: [ 
				| x y water |
				x := interpreter my: 'x'.
				y := interpreter my: 'y'.
				water := interpreter my: 'water'.
				self
					assert: water < 9.5
					equals: ((x closeTo: 5.0) and: [ y closeTo: 4.8 ]). "the tank at 5@4.8 is drunk."
				waterInTank := waterInTank + water ] ].
	self assert: waterInTank closeTo: 40.0 - 1.0. "tanks lost 1kg of water at total."

	waterInHorse := 0.0.
	interpreter individualsOf: horseDefinition do: [ :horse | 
		interpreter
			withObserverContextWithSubject: horse
			definition: horseDefinition
			do: [ waterInHorse := waterInHorse + (interpreter my: 'water') ] ].
	self assert: waterInHorse closeTo: 1.0. "the horse drunk 1kg of water."

	^ interpreter
]
