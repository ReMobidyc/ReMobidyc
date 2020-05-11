Class {
	#name : #RMDVisualizer,
	#superclass : #Object,
	#instVars : [
		'extent',
		'renderers'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #examples }
RMDVisualizer class >> exampleSugarScape [
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
	visualizer := (self extent: 500 @ 500)
		addBackgroundRendererColor: Color red;
		addCellRendererColor: Color green
			alpha: (parser expression end parse: 'here''s grass')
			between: 0
			and: '1000000[kcal]' asRMDExpression numeric;
		addAnimatDotRenderer: 'Goat' diameter: 7 color: Color yellow;
		yourself.
	form := visualizer visualize: interpreter.
	morph := form asMorph.
	morph openInWindowLabeled: 'Sugar Scape'.
	[ [ interpreter stepSimulation ]
		whileTrue: [ morph form: (visualizer visualize: interpreter).
			0.01 second wait ] ] forkAt: Processor userBackgroundPriority.
	^ morph
]

{ #category : #'instance creation' }
RMDVisualizer class >> extent: aPoint [
	^ self new
		extent: aPoint;
		yourself
]

{ #category : #'adding-removing' }
RMDVisualizer >> addAnimatDotRenderer: aString diameter: aNumber color: aColor [
	^ self
		addRenderer:
			(RMDAnimatDotRenderer on: aString diameter: aNumber color: aColor)
]

{ #category : #'adding-removing' }
RMDVisualizer >> addBackgroundRendererColor: aColor [
	^ self addRendererFirst: (RMDBackgroundColorRenderer color: aColor)
]

{ #category : #'adding-removing' }
RMDVisualizer >> addCellRendererColor: aColor alpha: aRMDExpressionNode between: aNumber and: anotherNumber [
	^ self
		addRenderer:
			(RMDCellColorAlphaRenderer
				color: aColor
				alpha: aRMDExpressionNode
				between: aNumber
				and: anotherNumber)
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

{ #category : #'adding-removing' }
RMDVisualizer >> addRendererFirst: aRMDRenderer [
	renderers addFirst: aRMDRenderer.
	^ aRMDRenderer
]

{ #category : #accessing }
RMDVisualizer >> extent [
	^ extent
]

{ #category : #accessing }
RMDVisualizer >> extent: aPoint [
	extent := aPoint
]

{ #category : #private }
RMDVisualizer >> formToWrite [
	^ self subclassResponsibility
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
RMDVisualizer >> visualize: aRMDInterpreter [
	| scale form canvas |
	scale := extent x asFloat / aRMDInterpreter cellXDivisions asFloat
		min: extent y asFloat / aRMDInterpreter cellYDivisions asFloat.
	form := self formToWrite.
	canvas := form getCanvas.
	renderers
		do:
			[ :renderer | renderer draw: aRMDInterpreter scale: scale on: canvas ].
	^ form
]
