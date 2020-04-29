Class {
	#name : #RMDVisualizer,
	#superclass : #Object,
	#instVars : [
		'renderers'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #examples }
RMDVisualizer class >> exampleSugarScape [
	<script: 'RMDVisualizer exampleSugarScape'>
	| parser interpreter visualizer form morph |
	parser := RMDGrammar new.
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		yourself.
	interpreter
		load: RMDWorldDefinitionNode empty;
		load: RMDCellDefinitionNode grassField;
		load: RMDAnimatDefinitionNode goat;
		load: RMDActionDefinitionNode respire;
		load: RMDActionDefinitionNode move;
		load: RMDActionDefinitionNode eat_grass;
		load: (RMDBehaviorDefinitionNode goat_respire: '2000 [kcal/day]');
		load: RMDBehaviorDefinitionNode goat_walk_for_grass;
		load:
			(RMDBehaviorDefinitionNode
				goat_eat_grass: '3000 [kcal/day]'
				upto: '10000[kcal]');
		load: RMDActionDefinitionNode grow_grass;
		load:
			(RMDBehaviorDefinitionNode
				cell_grow_grass: '2000[kcal/day]'
				upto: '1000000[kcal]');
		load:
			(RMDSimulationDefinitionNode
				timeDefinition: (RMDSimulationTimeDefinitionNode during: '360[day]' by: '0.5[day]')
				worldInitializer: RMDWorldInitializerNode empty
				cellInitializer:
					(RMDCellInitializerNode
						grassInitializer: 10
						by: 10
						of: '5[km]'
						grass: '500000[kcal]'
						to: '1000000[kcal]')
				animatInitializers:
					{(RMDAnimatInitializerNode
						goatInitializer: 100
						bloodSugar: '500[kcal]'
						to: '1000[kcal]')}).
	interpreter setupSimulation.
	visualizer := RMDVisualizer new
		addCellRendererColor: Color green
			brightness: (parser expression end parse: 'here''s grass')
			between: 0
			and: '1000000[kcal]' asRMDExpression numeric;
		addAnimatDotRenderer: 'Goat' diameter: 7 color: Color yellow;
		yourself.
	form := visualizer visualize: interpreter extent: 500 @ 500.
	morph := form asMorph.
	morph openInWindowLabeled: 'Sugar Scape'.
	[ [ interpreter stepSimulation ]
		whileTrue: [ morph form: (visualizer visualize: interpreter extent: 500 @ 500).
			0.01 second wait ] ] forkAt: Processor userBackgroundPriority.
	^ morph
]

{ #category : #'adding-removing' }
RMDVisualizer >> addAnimatDotRenderer: aString diameter: aNumber color: aColor [
	^ self
		addRenderer:
			(RMDAnimatDotRenderer on: aString diameter: aNumber color: aColor)
]

{ #category : #'adding-removing' }
RMDVisualizer >> addCellRendererColor: aColor brightness: aRMDExpressionNode between: aNumber and: anotherNumber [
	^ self
		addRenderer:
			(RMDCellColorBrightnessRenderer
				color: aColor
				brightness: aRMDExpressionNode
				between: aNumber
				and: anotherNumber)
]

{ #category : #'adding-removing' }
RMDVisualizer >> addRenderer: aRMDRenderer [
	renderers add: aRMDRenderer.
	^ aRMDRenderer
]

{ #category : #initialization }
RMDVisualizer >> initialize [
	super initialize.
	renderers := OrderedCollection new
]

{ #category : #'adding-removing' }
RMDVisualizer >> removeRenderer: aRMDRenderer ifAbsent: errorBlock [
	renderers remove: aRMDRenderer ifAbsent: [ ^ errorBlock value ].
	^ aRMDRenderer
]

{ #category : #visualizing }
RMDVisualizer >> visualize: aRMDInterpreter extent: aPoint [
	| scale form canvas |
	scale := aPoint x asFloat / aRMDInterpreter cellXDivisions asFloat
		min: aPoint y asFloat / aRMDInterpreter cellYDivisions asFloat.
	form := Form extent: aPoint depth: 32.
	canvas := form getCanvas.
	renderers
		do:
			[ :renderer | renderer draw: aRMDInterpreter scale: scale on: canvas ].
	^ form
]
