Class {
	#name : #RMDTimeSeriesInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'metrics'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDTimeSeriesInspector class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: '';
		  yourself
]

{ #category : #accessing }
RMDTimeSeriesInspector >> chartHeight [

	^ 200
]

{ #category : #accessing }
RMDTimeSeriesInspector >> chartWidth [

	^ 760
]

{ #category : #private }
RMDTimeSeriesInspector >> chartWith: aDictionary agent: aString property: anotherString aggregation: aSymbol [

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
	times := aDictionary keys sorted.
	min := aDictionary min.
	max := aDictionary max.
	min < max ifTrue: [ 
		| xScale yScale minString maxString |
		xScale := chartWidth / times last asFloat.
		yScale := chartHeight / (aDictionary max - aDictionary min).
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
			value1 := aDictionary at: time1.
			value2 := aDictionary at: time2.
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
		| time timeString |
		time := times last * interpreter deltaTime.
		timeString := (interpreter simulationDefinition timeDefinition
			               duration unit fromSI: time) 
			              printShowingDecimalPlaces: 1.
		canvas
			drawString: timeString
			at: chartWidth - (font widthOfString: timeString)
			font: font
			color: Color gray ].
	canvas
		drawString: (anotherString
				 ifNil: [ 'population of ' , aString ]
				 ifNotNil: [ 
				 aString , '''s ' , (aSymbol ifNil: [ '' ]) , ' ' , anotherString ])
		at: 100 @ (chartHeight + fontHeight)
		font: font
		color: Color black.
	^ form
]

{ #category : #evaluating }
RMDTimeSeriesInspector >> evalAgent: agent property: property aggregation: aggregation [

	agent = 'World' ifTrue: [ ^ self evalWorldProperty: property ].
	agent = 'Cell' ifTrue: [ 
		^ self evalCellProperty: property aggregation: aggregation ].
	^ self evalAnimat: agent property: property aggregation: aggregation
]

{ #category : #evaluating }
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

{ #category : #evaluating }
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

{ #category : #evaluating }
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
	metrics := OrderedDictionary new.
	metrics
		at: { 'Goat'. nil. nil } put: Dictionary new;
		at: { 'Cell'. 'grass'. #average } put: Dictionary new
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
RMDTimeSeriesInspector >> newLayout [

	| newLayout |
	newLayout := SpBoxLayout newVertical.
	metrics keysAndValuesDo: [ :triple :timeseries | 
		| agent property aggregation form |
		agent := triple first.
		property := triple second.
		aggregation := triple third.
		form := self
			        chartWith: timeseries
			        agent: agent
			        property: property
			        aggregation: aggregation.
		newLayout add: form asPresenter height: form height ].
	^ newLayout
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateMetrics [

	metrics keysAndValuesDo: [ :triple :timeseries | 
		| agent property aggregation |
		agent := triple first.
		property := triple second.
		aggregation := triple third.
		timeseries
			at: interpreter time
			put:
			(self evalAgent: agent property: property aggregation: aggregation) ]
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateObservation [

	self updateMetrics.
	self layout ifNotNil: [ self layout: self newLayout ].
	self changed
]
