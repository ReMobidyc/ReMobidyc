Class {
	#name : #RMDTimeSeriesInspector,
	#superclass : #RMDSpeciesInspector,
	#instVars : [
		'chartPresenters',
		'propertyTimeSeries',
		'visibleProperties',
		'showsMin',
		'showsMax',
		'showsMean',
		'showsSd',
		'showsTotal'
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

{ #category : #specs }
RMDTimeSeriesInspector class >> defaultSpec [

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
RMDTimeSeriesInspector >> chartWith: propertyDefinition timeSeries: aDictionaryOfStats [

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
	min := (aDictionaryOfStats collect: [ :dict | dict at: #min ])
		       ifNotEmpty: #min
		       ifEmpty: [ 0.0 ].
	max := (aDictionaryOfStats collect: [ :dict | dict at: #max ])
		       ifNotEmpty: #max
		       ifEmpty: [ 0.0 ].
	showsTotal state ifTrue: [ 
		max := max max:
			       ((aDictionaryOfStats collect: [ :dict | dict at: #total ])
				        ifNotEmpty: #max
				        ifEmpty: [ 0.0 ]) ].
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
			min1 := stats1 at: #min.
			max1 := stats1 at: #max.
			sd1 := stats1 at: #sd.
			mean1 := stats1 at: #mean.
			total1 := stats1 at: #total.
			min2 := stats2 at: #min.
			max2 := stats2 at: #max.
			sd2 := stats2 at: #sd.
			mean2 := stats2 at: #mean.
			total2 := stats2 at: #total.
			curves := OrderedCollection new: 4.
			showsMean state ifTrue: [ 
				curves add: { 
						mean1.
						mean2.
						1.
						Color black } ].
			showsMin state ifTrue: [ 
				curves add: { 
						min1.
						min2.
						1.
						Color black } ].
			showsMax state ifTrue: [ 
				curves add: { 
						max1.
						max2.
						1.
						Color black } ].
			showsSd state ifTrue: [ 
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
			showsTotal state ifTrue: [ 
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
RMDTimeSeriesInspector >> collapseButtonFor: propertyDef [

	^ self newButton
		  label: propertyDef printString;
		  icon: self expandedIcon;
		  action: [ 
			  visibleProperties remove: propertyDef identifier ifAbsent: [  ].
			  self
				  updateLayout;
				  updateObservation ]
]

{ #category : #private }
RMDTimeSeriesInspector >> expandButtonFor: propertyDef [

	^ self newButton
		  label: propertyDef printString;
		  icon: self collapsedIcon;
		  borderWidth: 0;
		  borderColor: Color transparent;
		  action: [ 
			  visibleProperties add: propertyDef identifier.
			  self
				  updateLayout;
				  updateObservation ]
]

{ #category : #initialization }
RMDTimeSeriesInspector >> initializePresenters [

	super initializePresenters.
	visibleProperties := Set new.
	propertyTimeSeries := Dictionary new.
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
		self propertyValuesDo: [ :propertyValues | 
			propertyValues propertiesDo: [ :propertyDef :vals :stats | 
				(visibleProperties includes: propertyDef identifier) ifTrue: [ 
					chartPresenters
						at: propertyDef identifier
						ifPresent: [ :presenter | 
							propertyTimeSeries
								at: propertyDef identifier
								ifPresent: [ :timeSeries | 
									| form |
									form := self chartWith: propertyDef timeSeries: timeSeries.
									presenter image: form ] ] ] ] ] ]
]

{ #category : #updating }
RMDTimeSeriesInspector >> updateLayout [

	self layout ifNotNil: [ 
		| newLayout |
		chartPresenters := Dictionary new.
		newLayout := self newLayout.
		self propertyValuesDo: [ :propertyValues | 
			propertyValues propertiesDo: [ :propertyDef :vals :stats | 
				(visibleProperties includes: propertyDef identifier)
					ifTrue: [ 
						| form presenter |
						newLayout
							add: (self collapseButtonFor: propertyDef)
							expand: false.
						form := self
							        chartWith: propertyDef
							        timeSeries: (propertyTimeSeries
									         at: propertyDef identifier
									         ifAbsent: [ Dictionary new ]).
						presenter := self newImage.
						presenter image: form.
						chartPresenters at: propertyDef identifier put: presenter.
						newLayout add: presenter height: form height ]
					ifFalse: [ 
					newLayout add: (self expandButtonFor: propertyDef) expand: false ] ] ].
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
	self propertyValuesDo: [ :propertyValues | 
		propertyValues propertiesDo: [ :propertyDef :vals :stats | 
			(visibleProperties includes: propertyDef identifier) ifTrue: [ 
				(propertyTimeSeries
					 at: propertyDef identifier
					 ifAbsentPut: [ Dictionary new ]) at: interpreter time put: stats ] ] ]
]
