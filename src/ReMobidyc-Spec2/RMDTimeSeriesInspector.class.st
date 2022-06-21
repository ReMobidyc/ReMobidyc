Class {
	#name : #RMDTimeSeriesInspector,
	#superclass : #RMDAgentInspector,
	#instVars : [
		'chartPresenters',
		'showsMin',
		'showsMax',
		'showsMean',
		'showsSd',
		'showsTotal',
		'visibleAttributes',
		'attributeTimeSeries',
		'spawnedPresenters'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #accessing }
RMDTimeSeriesInspector class >> chartHeight [
	^ 200
]

{ #category : #accessing }
RMDTimeSeriesInspector class >> chartWidth [
	^ 760
]

{ #category : #layout }
RMDTimeSeriesInspector class >> defaultLayout [

	^ SpBoxLayout newVertical
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
RMDTimeSeriesInspector >> chartHeight [

	^ self class chartHeight
]

{ #category : #accessing }
RMDTimeSeriesInspector >> chartWidth [

	^ self class chartWidth
]

{ #category : #accessing }
RMDTimeSeriesInspector >> chartWith: attributeDefinition timeSeries: aDictionaryOfStats [

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

	times := aDictionaryOfStats keys sorted.
	min := (aDictionaryOfStats
		        collect: [ :dict | dict at: #min ifAbsent: [ nil ] ]
		        thenSelect: #notNil) ifNotEmpty: #min ifEmpty: [ 0.0 ].
	max := (aDictionaryOfStats
		        collect: [ :dict | dict at: #max ifAbsent: [ nil ] ]
		        thenSelect: #notNil) ifNotEmpty: #max ifEmpty: [ 0.0 ].
	showsTotal state ifTrue: [ 
		max := max max: ((aDictionaryOfStats
				         collect: [ :dict | dict at: #total ifAbsent: [ nil ] ]
				         thenSelect: #notNil) ifNotEmpty: #max ifEmpty: [ 0.0 ]) ].
	min < max ifTrue: [ 
		| xScale yScale minString maxString |
		xScale := chartWidth
		          /
		          interpreter simulationDefinition timeDefinition duration
			          numeric.
		yScale := chartHeight / (max - min).
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
		canvas
			line: interpreter time * xScale @ 0
			to: interpreter time * xScale @ chartHeight
			width: 1
			color: Color red.
		1 to: times size - 1 do: [ :index | 
			| time1 time2 stats1 stats2 min1 max1 sd1 total1 mean1 min2 max2 sd2 mean2 total2 curves |
			time1 := times at: index.
			time2 := times at: index + 1.
			stats1 := aDictionaryOfStats at: time1.
			stats2 := aDictionaryOfStats at: time2.
			min1 := stats1 at: #min ifAbsent: [ nil ].
			max1 := stats1 at: #max ifAbsent: [ nil ].
			sd1 := stats1 at: #sd ifAbsent: [ nil ].
			mean1 := stats1 at: #mean ifAbsent: [ nil ].
			total1 := stats1 at: #total ifAbsent: [ nil ].
			min2 := stats2 at: #min ifAbsent: [ nil ].
			max2 := stats2 at: #max ifAbsent: [ nil ].
			sd2 := stats2 at: #sd ifAbsent: [ nil ].
			mean2 := stats2 at: #mean ifAbsent: [ nil ].
			total2 := stats2 at: #total ifAbsent: [ nil ].
			curves := OrderedCollection new: 4.
			(showsMean state and: [ mean1 notNil and: [ mean2 notNil ] ]) 
				ifTrue: [ 
					curves add: { 
							mean1.
							mean2.
							1.
							Color black } ].
			(showsMin state and: [ min1 notNil and: [ min2 notNil ] ]) ifTrue: [ 
				curves add: { 
						min1.
						min2.
						1.
						Color black } ].
			(showsMax state and: [ max1 notNil and: [ max2 notNil ] ]) ifTrue: [ 
				curves add: { 
						max1.
						max2.
						1.
						Color black } ].
			(showsSd state and: [ 
				 mean1 notNil and: [ 
					 sd1 notNil and: [ mean2 notNil and: [ sd2 notNil ] ] ] ]) 
				ifTrue: [ 
					curves
						add: { 
								(mean1 - sd1).
								(mean2 - sd2).
								1.
								Color black };
						add: { 
								(mean1 + sd1).
								(mean2 + sd2).
								1.
								Color black } ].
			(showsTotal state and: [ total1 notNil and: [ total2 notNil ] ]) 
				ifTrue: [ 
					curves add: { 
							total1.
							total2.
							1.
							Color black } ].

			curves do: [ :args | 
				[ :value1 :value2 :width :color | 
				canvas
					line: (time1 * xScale) rounded
						@ (chartHeight - (value1 - min * yScale) rounded)
					to: (time2 * xScale) rounded
						@ (chartHeight - (value2 - min * yScale) rounded)
					width: width
					color: color ] valueWithArguments: args ] ] ].
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

{ #category : #private }
RMDTimeSeriesInspector >> collapseButtonFor: attributeDef [

	^ self newButton
		  label: attributeDef printString;
		  icon: self expandedIcon;
		  action: [ 
			  visibleAttributes remove: attributeDef identifier ifAbsent: [  ].
			  self
				  updateLayout;
				  updateObservation ]
]

{ #category : #private }
RMDTimeSeriesInspector >> expandButtonFor: attributeDef [

	^ self newButton
		  label: attributeDef printString;
		  icon: self collapsedIcon;
		  borderWidth: 0;
		  borderColor: Color transparent;
		  action: [ 
			  visibleAttributes add: attributeDef identifier.
			  self
				  updateLayout;
				  updateObservation ]
]

{ #category : #initialization }
RMDTimeSeriesInspector >> initializePresenters [

	super initializePresenters.
	visibleAttributes := Set new.
	attributeTimeSeries := Dictionary new.
	spawnedPresenters := Dictionary new.
	showsMin := self newCheckBox
		            labelOnRight;
		            label: 'min';
		            state: false;
		            labelClickable: true;
		            whenChangedDo: [ self updateObservation ];
		            yourself.
	showsMax := self newCheckBox
		            labelOnRight;
		            label: 'max';
		            state: false;
		            labelClickable: true;
		            whenChangedDo: [ self updateObservation ];
		            yourself.
	showsMean := self newCheckBox
		             labelOnRight;
		             label: 'mean';
		             state: true;
		             labelClickable: true;
		             whenChangedDo: [ self updateObservation ];
		             yourself.
	showsSd := self newCheckBox
		           labelOnRight;
		           label: 'mean ± σ';
		           state: false;
		           labelClickable: true;
		           whenChangedDo: [ self updateObservation ];
		           yourself.
	showsTotal := self newCheckBox
		              labelOnRight;
		              label: 'total';
		              state: false;
		              labelClickable: true;
		              whenChangedDo: [ self updateObservation ];
		              yourself.

	self whenBuiltDo: [ self updateImage ]
]

{ #category : #updating }
RMDTimeSeriesInspector >> newLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: showsMin;
				   add: showsMax;
				   add: showsMean;
				   add: showsSd;
				   add: showsTotal)
		  height: self class buttonHeight;
		  yourself
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateImage [

	self layout ifNotNil: [ 
		chartPresenters ifNil: [ self updateLayout ].
		self attributeValuesDo: [ :attributeValues | 
			attributeValues attributesDo: [ :attributeDef :vals :stats | 
				(visibleAttributes includes: attributeDef identifier) ifTrue: [ 
					chartPresenters
						at: attributeDef identifier
						ifPresent: [ :presenter | 
							attributeTimeSeries
								at: attributeDef identifier
								ifPresent: [ :timeSeries | 
									| form |
									form := self chartWith: attributeDef timeSeries: timeSeries.
									presenter image: form ] ] ] ] ] ]
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateLayout [

	self layout ifNotNil: [ 
		| newLayout |
		chartPresenters := Dictionary new.
		newLayout := self newLayout.
		self attributeValuesDo: [ :attributeValues | 
			attributeValues attributesDo: [ :attributeDef :vals :stats | 
				(visibleAttributes includes: attributeDef identifier)
					ifTrue: [ 
						| form presenter |
						newLayout
							add: (self collapseButtonFor: attributeDef)
							expand: false.
						form := self
							        chartWith: attributeDef
							        timeSeries: (attributeTimeSeries
									         at: attributeDef identifier
									         ifAbsent: [ Dictionary new ]).
						presenter := self newImage.
						presenter image: form.
						chartPresenters at: attributeDef identifier put: presenter.
						newLayout add: presenter height: form height ]
					ifFalse: [ 
					newLayout add: (self expandButtonFor: attributeDef) expand: false ] ] ].
		newLayout presenters ifEmpty: [ newLayout add: '' asPresenter ].
		self layout: newLayout ]
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateObservation [

	self updateTimeSeries.
	self updateImage.
	self changed
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateTimeSeries [

	chartPresenters ifNil: [ self updateLayout ].
	self attributeValuesDo: [ :attributeValues | 
		attributeValues attributesDo: [ :attributeDef :vals :stats | 
			(visibleAttributes includes: attributeDef identifier) ifTrue: [ 
				(attributeTimeSeries
					 at: attributeDef identifier
					 ifAbsentPut: [ Dictionary new ]) at: interpreter time put: stats ] ] ]
]
