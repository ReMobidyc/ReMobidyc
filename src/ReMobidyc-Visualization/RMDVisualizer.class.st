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
	| parser interpreter visualizer form |
	parser := RMDGrammar new.
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDActionContext new;
		yourself.
	interpreter
		load: RMDWorldDefinitionNode empty;
		load: RMDCellDefinitionNode grassField;
		load: RMDAnimatDefinitionNode goat;
		load:
			(RMDSimulationDefinitionNode
				timeDefinition: (RMDSimulationTimeDefinitionNode during: '365[day]' by: '0.5[day]')
				worldInitializer: RMDWorldInitializerNode default
				cellInitializer:
					(RMDCellInitializerNode
						grassInitializer: 5
						by: 6
						of: '1[km]'
						grass: '5000[kcal]'
						to: '10000[kcal]')
				animatInitializers:
					{(RMDAnimatInitializerNode
						goatInitializer: 10
						bloodSugar: '1000[kcal]'
						to: '10000[kcal]')}).
	interpreter setupSimulation.
	visualizer := RMDVisualizer new
		addCellRendererColor: Color green
			brightness: (parser expression end parse: 'here''s grass')
			between: 0
			and: '10000[kcal]' asRMDExpression numeric;
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
