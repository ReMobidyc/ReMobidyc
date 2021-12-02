Class {
	#name : #RMDVisualizer,
	#superclass : #Object,
	#instVars : [
		'extent',
		'renderers',
		'formToWrite',
		'formToRead'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDVisualizer class >> extent: aPoint [
	^ self new
		extent: aPoint;
		yourself
]

{ #category : #'instance creation' }
RMDVisualizer class >> sugarScape [
	^ (self extent: 500 @ 500)
		addBackgroundRendererColor: Color brown;
		addCellRendererColor: Color green
			alpha: 'here''s grass' asRMDExpression
			between: '0[kcal]' asRMDExpression
			and: '1000000[kcal]' asRMDExpression;
		addAnimatDotRenderer: 'Goat' diameter: 7 color: Color yellow;
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
RMDVisualizer >> addCellRenderer: aRMDExpressionNode color: aColor1 value: aRMDLiteralNode1 color: aColor2 value: aRMDLiteralnode2 color: aColor3 [
	^ self
		addRenderer:
			(RMDCellColorMapRenderer
				expression: aRMDExpressionNode
				color: aColor1
				value: aRMDLiteralNode1
				color: aColor2
				value: aRMDLiteralnode2
				color: aColor3)
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
	extent := aPoint.
	(formToRead isNil or: [ formToRead extent ~= aPoint ])
		ifTrue: [ formToRead := Form extent: aPoint depth: 32 ].
	(formToWrite isNil or: [ formToWrite extent ~= aPoint ])
		ifTrue: [ formToWrite := Form extent: aPoint depth: 32 ]
]

{ #category : #private }
RMDVisualizer >> formToWrite [
	^ formToWrite
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

{ #category : #enumerating }
RMDVisualizer >> renderersDo: aBlock [
	renderers do: aBlock
]

{ #category : #enumerating }
RMDVisualizer >> renderersReverseDo: aBlock [
	renderers reverseDo: aBlock
]

{ #category : #visualizing }
RMDVisualizer >> visualize: aRMDInterpreter [
	| scale form canvas |
	scale := extent x asFloat / aRMDInterpreter cellXDivisions asFloat
		min: extent y asFloat / aRMDInterpreter cellYDivisions asFloat.
	form := self formToWrite.
	canvas := form getCanvas.
	canvas fillColor: Color white.
	renderers
		do: [ :renderer | renderer draw: aRMDInterpreter scale: scale on: canvas ].
	form := formToRead.
	formToRead := formToWrite.
	formToWrite := form.
	^ formToRead
]
