Class {
	#name : #RMDVisualizer,
	#superclass : #Object,
	#instVars : [
		'renderers'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #examples }
RMDVisualizer class >> exampleSugar [
	<script: 'RMDVisualizer exampleSugar'>
	| parser interpreter visualizer form |
	parser := RMDGrammar new.
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		yourself.
	interpreter
		load:
			(parser worldDefinition
				parse:
					'World with
	temperature [C].');
		load:
			(parser cellDefinition
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
			(parser simulationTimeDefinition
				parse: 'during 300 [day] by 0.5 [day]');
		load:
			(parser worldInitializer
				parse:
					'World with
	temperature = 30 [C]');
		load:
			(parser cellInitializer
				parse:
					'5 x 6 of 10 [m] Cell with
	grass = uniform 1000 [kcal] to 5000 [kcal]
	fertility = 2000 [kcal]');
		load:
			(parser animatInitializer
				parse:
					'10 Goat with
	x = uniform 0 [m] to 50 [m]
	y = uniform 0 [m] to 60 [m]
	body = 10000 [kcal]
	age = 0 [day]').
	interpreter setupSimulation.
	visualizer := RMDVisualizer new
		addCellRendererColor: Color green
			brightness: (parser expression end parse: 'here''s grass')
			between: 0
			and: (RMDUnit kcal toSI: 5000);
		addAnimatDotRenderer: 'Goat' diameter: 7 color: Color yellow;
		yourself.
	form := visualizer visualize: interpreter extent: 500 @ 500.
	form asMorph openInWindowLabeled: 'Sugar Scape'.
	^ form
]

{ #category : #examples }
RMDVisualizer class >> exampleSugarScape [
	<script: 'RMDVisualizer exampleSugarScape'>
	| parser interpreter visualizer form |
	parser := RMDGrammar new.
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		yourself.
	interpreter
		load:
			(parser worldDefinition end
				parse:
					'World with
	temperature [C]');
		load:
			(parser cellDefinition end
				parse:
					'Cell with
	grass [kcal]');
		load:
			(parser animatDefinition end
				parse:
					'Goat is Animat with
	bloodSugar [kcal]
	age [day].');
		load:
			(parser simulationTimeDefinition
				parse: 'during 300 [day] by 0.5 [day]');
		load:
			(parser worldInitializer
				parse:
					'World with
	temperature = 30 [C]');
		load:
			(parser cellInitializer
				parse:
					'5 x 6 of 10 [m] Cell with
	grass = uniform 1000 [kcal] to 5000 [kcal]');
		load:
			(parser animatInitializer
				parse:
					'10 Goat with
	x = uniform 0 [m] to 50 [m]
	y = uniform 0 [m] to 60 [m]
	bloodSugar = 10000 [kcal]
	age = 0 [day]').
	interpreter setupSimulation.
	visualizer := RMDVisualizer new
		addCellRendererColor: Color green
			brightness: (parser expression end parse: 'here''s grass')
			between: 0
			and: (RMDUnit kcal toSI: 5000);
		addAnimatDotRenderer: 'Goat' diameter: 7 color: Color yellow;
		yourself.
	form := visualizer visualize: interpreter extent: 500 @ 500.
	form asMorph openInWindowLabeled: 'Sugar Scape'.
	^ form
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
