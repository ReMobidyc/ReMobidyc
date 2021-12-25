Class {
	#name : #RMDAnimatTimeSeriesInspector,
	#superclass : #RMDTimeSeriesInspector,
	#instVars : [
		'#animat => ObservableSlot',
		'#populationPresenter',
		'#populationTimeSeries'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #specs }
RMDAnimatTimeSeriesInspector class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   hAlignCenter;
				   add: 'Population')
		  expand: false;
		  add: #populationPresenter height: self chartHeight;
		  add: (SpBoxLayout newHorizontal
				   add: #showsMin;
				   add: #showsMax;
				   add: #showsMean;
				   add: #showsSd;
				   add: #showsTotal)
		  height: self buttonHeight;
		  add: SpBoxLayout newVertical
]

{ #category : #accessing }
RMDAnimatTimeSeriesInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatTimeSeriesInspector >> animat: aString [

	animat := aString
]

{ #category : #accessing }
RMDAnimatTimeSeriesInspector >> chartWithPopulation [

	| chartWidth chartHeight font fontHeight form canvas times min max |
	chartWidth := self chartWidth.
	chartHeight := self chartHeight.
	font := TextStyle defaultFont.
	fontHeight := font height.
	form := Form
		        extent: chartWidth @ (chartHeight + fontHeight + fontHeight)
		        depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color white.

	times := populationTimeSeries keys sorted.
	min := populationTimeSeries ifNotEmpty: #min ifEmpty: [ 0.0 ].
	max := populationTimeSeries ifNotEmpty: #max ifEmpty: [ 0.0 ].
	min < max ifTrue: [ 
		| xScale yScale minString maxString |
		xScale := chartWidth
		          /
		          interpreter simulationDefinition timeDefinition duration
			          numeric.
		yScale := chartHeight / (max - min).
		minString := 'min = ', min printString.
		maxString := 'max = ', max printString.
		canvas
			drawString: minString
			at: 0 @ (chartHeight - fontHeight)
			font: font
			color: Color gray.
		canvas
			drawString: maxString
			at: 0 @ 0
			font: font
			color: Color gray.
		canvas
			line: interpreter time * xScale @ 0
			to: interpreter time * xScale @ chartHeight
			width: 1
			color: Color red.
		1 to: times size - 1 do: [ :index | 
			| time1 time2 value1 value2 |
			time1 := times at: index.
			time2 := times at: index + 1.
			value1 := populationTimeSeries at: time1.
			value2 := populationTimeSeries at: time2.
			canvas
				line: (time1 * xScale) rounded
					@ (chartHeight - (value1 - min * yScale) rounded)
				to: (time2 * xScale) rounded
					@ (chartHeight - (value2 - min * yScale) rounded)
				width: 1
				color: Color black ] ].
	canvas
		drawString: '0'
		at: 0 @ chartHeight
		font: font
		color: Color gray.
	times size > 1 ifTrue: [ 
		| time timeUnit timeString |
		time := times last.
		timeUnit := interpreter simulationDefinition timeDefinition duration
			            unit.
		timeString := ((timeUnit fromSI: time) printShowingDecimalPlaces: 1)
		              , ' [' , timeUnit printString , ']'.
		canvas
			drawString: timeString
			at: chartWidth - (font widthOfString: timeString) @ chartHeight
			font: font
			color: Color gray ].
	^ form
]

{ #category : #initialization }
RMDAnimatTimeSeriesInspector >> initializePresenters [

	super initializePresenters.
	populationTimeSeries := Dictionary new.
	populationPresenter := self newImage
		                       autoScale: false;
		                       yourself
]

{ #category : #updating }
RMDAnimatTimeSeriesInspector >> newLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   hAlignCenter;
				   add: 'Population')
		  expand: false;
		  add: populationPresenter height: self chartHeight;
		  add: (SpBoxLayout newHorizontal
				   add: showsMin;
				   add: showsMax;
				   add: showsMean;
				   add: showsSd;
				   add: showsTotal)
		  height: self class buttonHeight;
		  yourself
]

{ #category : #enumerating }
RMDAnimatTimeSeriesInspector >> speciesDefinitionDo: aBlock [

	interpreter animatDefinitionAt: self animat ifPresent: aBlock
]

{ #category : #updating }
RMDAnimatTimeSeriesInspector >> updateImage [

	super updateImage.
	populationPresenter image: self chartWithPopulation
]

{ #category : #updating }
RMDAnimatTimeSeriesInspector >> updateTimeSeries [

	super updateTimeSeries.
	(interpreter animatDefinitionAt: animat ifAbsent: [ nil ]) ifNotNil: [ 
		:animatDefinition | 
		populationTimeSeries
			at: interpreter time
			put: (interpreter numberOfIndivisualsOf: animatDefinition) ]
]
