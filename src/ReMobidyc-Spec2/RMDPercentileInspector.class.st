Class {
	#name : #RMDPercentileInspector,
	#superclass : #RMDAgentInspector,
	#instVars : [
		'showsPercentiles',
		'showsMin',
		'showsMax',
		'showsMean',
		'showsSd',
		'chartPresenters',
		'visibleAttributes',
		'spawnedPresenters'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #layout }
RMDPercentileInspector class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: #showsPercentiles;
				   add: #showsMin;
				   add: #showsMax;
				   add: #showsMean;
				   add: #showsSd)
		  height: self buttonHeight;
		  add: SpBoxLayout newVertical
]

{ #category : #accessing }
RMDPercentileInspector >> agentName [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDPercentileInspector >> chartHeight [
	^ 200
]

{ #category : #accessing }
RMDPercentileInspector >> chartWidth [
	^ 760
]

{ #category : #accessing }
RMDPercentileInspector >> chartWith: attributeDef values: vals stats: stats [

	| chartWidth chartHeight font fontHeight form canvas values resolution min max |
	chartWidth := self chartWidth.
	chartHeight := self chartHeight.
	font := TextStyle defaultFont.
	fontHeight := font height.
	form := Form
		        extent: chartWidth @ (chartHeight + fontHeight)
		        depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color white.
	values := vals asSortedCollection.
	showsPercentiles state ifTrue: [ 
		canvas
			line: form width // 4 @ 0
			to: form width // 4 @ chartHeight
			width: 1
			color: Color lightGray;
			line: form width // 2 @ 0
			to: form width // 2 @ chartHeight
			width: 1
			color: Color lightGray;
			line: form width * 3 // 4 @ 0
			to: form width * 3 // 4 @ chartHeight
			width: 1
			color: Color lightGray.

		canvas
			drawString: '0'
			at: 0 @ chartHeight
			font: font
			color: Color darkGray;
			drawString: '25'
			at:
				form width // 4 - ((font widthOfString: '25') // 2) @ chartHeight
			font: font
			color: Color darkGray;
			drawString: '50'
			at: form width - (font widthOfString: '50') // 2 @ chartHeight
			font: font
			color: Color darkGray;
			drawString: '75'
			at:
				form width * 3 // 4 - ((font widthOfString: '75') // 2)
				@ chartHeight
			font: font
			color: Color darkGray;
			drawString: '100'
			at: form width - (font widthOfString: '100') @ chartHeight
			font: font
			color: Color darkGray ].

	resolution := values size min: chartWidth.
	min := stats at: #min ifAbsent: [ nil ].
	max := stats at: #max ifAbsent: [ nil ].
	min = max
		ifTrue: [ 
			canvas
				line: 0 @ (chartHeight // 2)
				to: chartWidth @ (chartHeight // 2)
				width: 1
				color: Color black.
			(showsMin state or: [ showsMax state or: [ showsMean state ] ]) 
				ifTrue: [ 
					canvas
						drawString: ((stats at: #mean ifAbsent: [ nil ])
								 ifNotNil: [ :v | v printShowingDecimalPlaces: 2 ]
								 ifNil: [ 'N/A' ])
						at: 10 @ (chartHeight // 2 + 2)
						font: font
						color: Color black ] ]
		ifFalse: [ 
			| vmean ymean vsd ysd |
			showsMin state ifTrue: [ 
				canvas
					drawString:
					'min=' , ((stats at: #min) printShowingDecimalPlaces: 2)
					at: 10 @ (chartHeight - fontHeight)
					font: font
					color: Color black ].
			showsMax state ifTrue: [ 
				canvas
					drawString:
					'max=' , ((stats at: #max) printShowingDecimalPlaces: 2)
					at: 10 @ 0
					font: font
					color: Color black ].
			vmean := stats at: #mean.
			ymean := vmean - min * chartHeight / (min - max) asFloat
			         + chartHeight.
			(showsMean state or: [ showsSd state ]) ifTrue: [ 
				canvas
					line: 0 @ ymean
					to: chartWidth @ ymean
					width: 1
					color: Color black ].
			showsMean state ifTrue: [ 
				canvas
					drawString:
					'mean=' , ((stats at: #mean) printShowingDecimalPlaces: 2)
					at: 10 @ (ymean + 2)
					font: font
					color: Color black ].
			showsSd state ifTrue: [ 
				vsd := vmean + (stats at: #sd).
				ysd := vsd - min * chartHeight / (min - max) asFloat + chartHeight.
				canvas
					drawString:
					'sigma=' , ((stats at: #sd) printShowingDecimalPlaces: 2)
					at: 20 @ (ymean + ysd * 0.5 - (fontHeight * 0.5))
					font: font
					color: Color black.
				canvas
					line: 0 @ ysd
					to: chartWidth @ ysd
					width: 1
					color: Color lightGray;
					line: 10 @ ysd
					to: 5 @ (ysd + 5)
					width: 1
					color: Color lightGray;
					line: 10 @ ysd
					to: 15 @ (ysd + 5)
					width: 1
					color: Color lightGray;
					line: 10 @ ymean
					to: 5 @ (ymean - 5)
					width: 1
					color: Color lightGray;
					line: 10 @ ymean
					to: 15 @ (ymean - 5)
					width: 1
					color: Color lightGray;
					line: 10 @ ymean
					to: 10 @ ysd
					width: 1
					color: Color lightGray.
				vsd := vmean - (stats at: #sd).
				ysd := vsd - min * chartHeight / (min - max) asFloat + chartHeight.
				canvas
					line: 0 @ ysd
					to: chartWidth @ ysd
					width: 1
					color: Color lightGray ].
			0 to: resolution - 1 do: [ :i | 
				| value0 value1 |
				value0 := values at:
					          (i * (values size - 1) / resolution asFloat) rounded
					          + 1.
				value1 := values at:
					          (i + 1 * (values size - 1) / resolution asFloat)
						          rounded + 1.
				canvas
					line: i * chartWidth / resolution asFloat
						@
						(value0 - min * chartHeight / (min - max) asFloat + chartHeight)
					to: i + 1 * chartWidth / resolution asFloat
						@
						(value1 - min * chartHeight / (min - max) asFloat + chartHeight)
					width: 1
					color: Color blue darker ] ].
	^ form
]

{ #category : #private }
RMDPercentileInspector >> collapseButtonFor: attributeDef [

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
RMDPercentileInspector >> expandButtonFor: attributeDef [

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
RMDPercentileInspector >> initializePresenters [

	super initializePresenters.
	visibleAttributes := Set new.
	spawnedPresenters := Dictionary new.
	showsPercentiles := self newCheckBox
		                    labelOnRight;
		                    label: 'percentiles';
		                    state: true;
		                    labelClickable: true;
		                    whenChangedDo: [ self updateObservation ];
		                    yourself.
	showsMin := self newCheckBox
		            labelOnRight;
		            label: 'min';
		            state: true;
		            labelClickable: true;
		            whenChangedDo: [ self updateObservation ];
		            yourself.
	showsMax := self newCheckBox
		            labelOnRight;
		            label: 'max';
		            state: true;
		            labelClickable: true;
		            whenChangedDo: [ self updateObservation ];
		            yourself.
	showsMean := self newCheckBox
		             labelOnRight;
		             label: 'mean';
		             state: false;
		             labelClickable: true;
		             whenChangedDo: [ self updateObservation ];
		             yourself.
	showsSd := self newCheckBox
		           labelOnRight;
		           label: 'sigma';
		           state: false;
		           labelClickable: true;
		           whenChangedDo: [ self updateObservation ];
		           yourself.
	self whenBuiltDo: [ self updateImage ]
]

{ #category : #accessing }
RMDPercentileInspector >> newLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: showsPercentiles;
				   add: showsMin;
				   add: showsMax;
				   add: showsMean;
				   add: showsSd)
		  height: self class buttonHeight;
		  yourself
]

{ #category : #private }
RMDPercentileInspector >> spawnButtonFor: attributeDef [

	^ self newButton
		  icon: self spawnIcon;
		  action: [ 
			  chartPresenters
				  at: attributeDef identifier
				  ifPresent: [ :presenter | 
					  | spawnedPresenter |
					  spawnedPresenter := presenter image asPresenter
						                      autoScale: true;
						                      yourself.
					  spawnedPresenter open title:
						  'Percentile chart of ' , self agentName , '''s '
						  , attributeDef printString.
					  (spawnedPresenters
						   at: attributeDef identifier
						   ifAbsentPut: [ OrderedCollection new ]) add: spawnedPresenter ] ]
]

{ #category : #updating }
RMDPercentileInspector >> updateImage [

	self layout ifNotNil: [ 
		chartPresenters ifNil: [ self updateLayout ].
		self attributeValuesDo: [ :attributeValues | 
			attributeValues attributesDo: [ :attributeDef :vals :stats | 
				(visibleAttributes includes: attributeDef identifier) ifTrue: [ 
					chartPresenters
						at: attributeDef identifier
						ifPresent: [ :presenter | 
							| form |
							form := self chartWith: attributeDef values: vals stats: stats.
							presenter image: form ].
					spawnedPresenters
						at: attributeDef identifier
						ifPresent: [ :presenters | 
							presenters copy do: [ :presenter | 
								presenter window isClosed
									ifTrue: [ presenters remove: presenter ifAbsent: [  ] ]
									ifFalse: [ 
										| form |
										form := self
											        chartWith: attributeDef
											        values: vals
											        stats: stats.
										presenter image: form ] ] ] ] ] ] ]
]

{ #category : #updating }
RMDPercentileInspector >> updateLayout [

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
							add: (SpBoxLayout newHorizontal
									 add: (self collapseButtonFor: attributeDef);
									 add: (self spawnButtonFor: attributeDef) expand: false)
							expand: false.
						form := self chartWith: attributeDef values: vals stats: stats.
						presenter := self newImage.
						presenter image: form.
						chartPresenters at: attributeDef identifier put: presenter.
						newLayout add: presenter height: form height ]
					ifFalse: [ 
					newLayout add: (self expandButtonFor: attributeDef) expand: false ] ] ].
		self layout: newLayout ]
]

{ #category : #updating }
RMDPercentileInspector >> updateObservation [
	self updateImage.
	self changed
]
