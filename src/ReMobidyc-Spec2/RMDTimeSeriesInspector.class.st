Class {
	#name : #RMDTimeSeriesInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'image',
		'timeSeries',
		'titleLabel'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #accessing }
RMDTimeSeriesInspector class >> chartHeight [
	^ 200
]

{ #category : #accessing }
RMDTimeSeriesInspector class >> chartWidth [
	^ 760
]

{ #category : #specs }
RMDTimeSeriesInspector class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: #titleLabel expand: false;
		  add: #image height: 200;
		  yourself
]

{ #category : #accessing }
RMDTimeSeriesInspector >> chartHeight [

	^ self class chartHeight
]

{ #category : #accessing }
RMDTimeSeriesInspector >> chartWidth [

	^ self class chartWidth
]

{ #category : #accessing }
RMDTimeSeriesInspector >> createChart [

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
	times := timeSeries keys sorted.
	min := timeSeries min.
	max := timeSeries max.
	min < max ifTrue: [ 
		| xScale yScale minString maxString |
		xScale := chartWidth / times last asFloat.
		yScale := chartHeight / (timeSeries max - timeSeries min).
		minString := min printShowingDecimalPlaces: 1.
		maxString := max printShowingDecimalPlaces: 1.
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
		1 to: times size - 1 do: [ :index | 
			| time1 time2 value1 value2 |
			time1 := times at: index.
			time2 := times at: index + 1.
			value1 := timeSeries at: time1.
			value2 := timeSeries at: time2.
			canvas
				line: (time1 * xScale) rounded
					@ (chartHeight - (value1 - min * yScale) rounded)
				to: (time2 * xScale) rounded
					@ (chartHeight - (value2 - min * yScale) rounded)
				width: 1
				color: Color gray ] ].
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

{ #category : #evaluating }
RMDTimeSeriesInspector >> eval [

	^ self subclassResponsibility
]

{ #category : #obsolete }
RMDTimeSeriesInspector >> evalAgent: agent property: property aggregation: aggregation [

	agent = 'World' ifTrue: [ ^ self evalWorldProperty: property ].
	agent = 'Cell' ifTrue: [ 
		^ self evalCellProperty: property aggregation: aggregation ].
	^ self evalAnimat: agent property: property aggregation: aggregation
]

{ #category : #obsolete }
RMDTimeSeriesInspector >> evalAnimat: aString property: anotherString aggregation: aSymbol [

	| animatDefinition |
	animatDefinition := interpreter
		                    animatDefinitionAt: aString
		                    ifAbsent: [ ^ nil ].
	anotherString ifNil: [ 
		^ interpreter numberOfIndivisualsOf: animatDefinition ].
	^ ((Array streamContents: [ :stream | 
		    interpreter
			    individualsOf: animatDefinition
			    do: [ :individual | 
				    interpreter
					    withObserverContextWithSubject: individual
					    species: animatDefinition
					    do: [ 
						    (interpreter
							     readVariable: anotherString
							     agent: nil
							     ifAbsent: [ nil ]) ifNotNil: [ :value | 
							    stream nextPut: value ] ] ] ])
		   ifEmpty: [ nil ]
		   ifNotEmpty: aSymbol) ifNotNil: [ :value | 
		  (animatDefinition unitOfProperty: anotherString ifAbsent: [ nil ]) 
			  ifNotNil: [ :unit | unit fromSI: value ] ]
]

{ #category : #obsolete }
RMDTimeSeriesInspector >> evalCellProperty: aString aggregation: aSymbol [

	^ ((Array streamContents: [ :stream | 
		    interpreter cellsDo: [ :cell | 
			    interpreter
				    withObserverContextWithSubject: cell
				    species: interpreter cellDefinition
				    do: [ 
					    (interpreter
						     readVariable: aString
						     agent: nil
						     ifAbsent: [ nil ]) ifNotNil: [ :value | 
						    stream nextPut: value ] ] ] ])
		   ifEmpty: [ nil ]
		   ifNotEmpty: aSymbol) ifNotNil: [ :value | 
		  (interpreter cellDefinition
			   unitOfProperty: aString
			   ifAbsent: [ nil ]) ifNotNil: [ :unit | unit fromSI: value ] ]
]

{ #category : #obsolete }
RMDTimeSeriesInspector >> evalWorldProperty: aString [

	^ (interpreter
		   withObserverContextWithSubject: interpreter world
		   species: interpreter worldDefinition
		   do: [ 
		   interpreter readVariable: aString agent: nil ifAbsent: [ nil ] ]) 
		  ifNotNil: [ :value | 
			  (interpreter worldDefinition
				   unitOfProperty: aString
				   ifAbsent: [ nil ]) ifNotNil: [ :unit | unit fromSI: value ] ]
]

{ #category : #initialization }
RMDTimeSeriesInspector >> initialize [

	super initialize.
	timeSeries := Dictionary new
]

{ #category : #initialization }
RMDTimeSeriesInspector >> initializePresenters [

	super initializePresenters.
	titleLabel := self newLabel
		              label: '';
		              yourself.
	image := self newImage
		         autoScale: false;
		         yourself
]

{ #category : #accessing }
RMDTimeSeriesInspector >> interpreter [
	^ interpreter 
]

{ #category : #accessing }
RMDTimeSeriesInspector >> interpreter: aRMDInterpreter [

	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateObservation
		to: self
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateImage [

	image image: self createChart
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateObservation [

	self updateTimeSeries.
	self updateImage.
	self changed
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateTimeSeries [

	timeSeries at: interpreter time put: self eval
]

{ #category : #accessing }
RMDTimeSeriesInspector >> updateTitleLabel [

	^ self subclassResponsibility
]
