Class {
	#name : #RMDHistogramInspector,
	#superclass : #RMDSpeciesInspector,
	#instVars : [
		'chartPresenters',
		'visibleAttributes',
		'spawnedPresenters'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #layout }
RMDHistogramInspector class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: '';
		  yourself
]

{ #category : #accessing }
RMDHistogramInspector >> chartHeight [
	^ 200
]

{ #category : #accessing }
RMDHistogramInspector >> chartWidth [
	^ 760
]

{ #category : #accessing }
RMDHistogramInspector >> chartWith: attributeDef values: values min: min max: max divisions: divisions [

	^ self
		  chartWith: attributeDef
		  values: values
		  min: min
		  max: max
		  divisions: divisions
		  extent: self chartWidth @ self chartHeight
]

{ #category : #accessing }
RMDHistogramInspector >> chartWith: attributeDef values: values min: min max: max divisions: divisions extent: aPoint [

	| counts maxCount font fontHeight chartWidth chartHeight form canvas xScale yScale minString maxString |
	counts := Array new: divisions + 2 withAll: 0.
	values do: [ :value | 
		| index |
		index := value - min * divisions // (max - min) + 2
			         min: divisions + 2
			         max: 1.
		counts at: index put: (counts at: index) + 1 ].
	maxCount := counts max.
	chartWidth := aPoint x.
	chartHeight := aPoint y.
	font := TextStyle defaultFont.
	fontHeight := font height.
	form := Form
		        extent: chartWidth @ (chartHeight + fontHeight)
		        depth: 32.
	canvas := form getCanvas.
	canvas fillColor: Color white.
	xScale := chartWidth asFloat / counts size.
	yScale := maxCount > 0 ifTrue: [(chartHeight - fontHeight) asFloat / (maxCount * 1.1)] ifFalse: [1.0].
	minString := (min printShowingDecimalPlaces: 2) , ' ['
	             , attributeDef unit printString , ']'.
	maxString := (max printShowingDecimalPlaces: 2) , ' ['
	             , attributeDef unit printString , ']'.
	1 to: counts size do: [ :index | 
		| count left right top bottom countString |
		count := counts at: index.
		left := (index - 1 * xScale) rounded.
		right := (index * xScale) rounded.
		top := chartHeight - (count * yScale) rounded min: chartHeight - 1.
		bottom := chartHeight.
		countString := count printString.
		canvas
			frameAndFillRectangle: (left @ top corner: right @ bottom)
			fillColor: Color lightGray
			borderWidth: 1
			borderColor: Color black;
			drawString: countString
			at: left + right - (font widthOfString: countString) // 2
				@ (top - fontHeight)
			font: font
			color: Color black ].
	canvas
		drawString: minString
		at:
			((xScale - ((font widthOfString: minString) // 2)) rounded max: 0)
			@ chartHeight
		font: font
		color: Color black;
		drawString: maxString
		at:
			((xScale * (divisions + 1) - ((font widthOfString: maxString) // 2))
				 rounded min: chartWidth - (font widthOfString: maxString))
			@ chartHeight
		font: font
		color: Color black.


	^ form
]

{ #category : #private }
RMDHistogramInspector >> collapseButtonFor: attributeDef [

	^ self newButton
		  label: attributeDef printString;
		  icon: self expandedIcon;
		  action: [ 
			  visibleAttributes
				  removeKey: attributeDef identifier
				  ifAbsent: [  ].
			  self
				  updateLayout;
				  updateObservation ]
]

{ #category : #private }
RMDHistogramInspector >> expandButtonFor: attributeDef values: values [

	^ self newButton
		  label: attributeDef printString;
		  icon: self collapsedIcon;
		  borderWidth: 0;
		  borderColor: Color transparent;
		  action: [ 
			  (self requestMinMaxDivisionsFor: attributeDef values: values) 
				  ifNotNil: [ :triple | 
					  visibleAttributes at: attributeDef identifier put: triple.
					  self
						  updateLayout;
						  updateObservation ] ]
]

{ #category : #initialization }
RMDHistogramInspector >> initializePresenters [

	super initializePresenters.
	visibleAttributes := Dictionary new.
	spawnedPresenters := Dictionary new
]

{ #category : #accessing }
RMDHistogramInspector >> newLayout [

	^ SpBoxLayout newVertical
]

{ #category : #private }
RMDHistogramInspector >> requestMinMaxDivisionsFor: attributeDef values: values [

	| min max divisions |
	min := values ifNotEmpty: #min ifEmpty: [ 0.0 ].
	max := values ifNotEmpty: #max ifEmpty: [ 0.0 ].
	(UIManager default
		 request: 'min [' , attributeDef unit printString , ']'
		 initialAnswer: min printString)
		ifNotNil: [ :str | min := Number readFrom: str ifFail: [ ^ nil ] ]
		ifNil: [ ^ nil ].
	(UIManager default
		 request: 'max [' , attributeDef unit printString , ']'
		 initialAnswer: max printString)
		ifNotNil: [ :str | max := Number readFrom: str ifFail: [ ^ nil ] ]
		ifNil: [ ^ nil ].
	min < max ifFalse: [ 
		UIManager default alert: 'max should be greater than min'.
		^ nil ].
	(UIManager default request: 'divisions' initialAnswer: '10')
		ifNotNil: [ :str | 
		divisions := Integer readFrom: str ifFail: [ ^ nil ] ]
		ifNil: [ ^ nil ].
	divisions > 0 ifFalse: [ 
		UIManager default alert: 'divisions should be greater than 0'.
		^ nil ].
	^ { 
		  min.
		  max.
		  divisions }
]

{ #category : #private }
RMDHistogramInspector >> spawnButtonFor: attributeDef [

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
						  'Histgram of ' , self speciesName , '''s '
						  , attributeDef printString.
					  (spawnedPresenters
						   at: attributeDef identifier
						   ifAbsentPut: [ OrderedCollection new ]) add: spawnedPresenter ] ]
]

{ #category : #accessing }
RMDHistogramInspector >> speciesName [

	^ self subclassResponsibility
]

{ #category : #updating }
RMDHistogramInspector >> updateImage [

	self layout ifNotNil: [ 
		chartPresenters ifNil: [ self updateLayout ].
		self attributeValuesDo: [ :attributeValues | 
			attributeValues attributesDo: [ :attributeDef :vals :stats | 
				visibleAttributes
					at: attributeDef identifier
					ifPresent: [ :triple | 
						chartPresenters
							at: attributeDef identifier
							ifPresent: [ :presenter | 
								| form |
								form := self
									        chartWith: attributeDef
									        values: vals
									        min: triple first
									        max: triple second
									        divisions: triple third.
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
												        min: triple first
												        max: triple second
												        divisions: triple third
												        extent: 0 @ -20 + presenter adapter widget extent.
											presenter image: form ] ] ] ] ] ] ]
]

{ #category : #updating }
RMDHistogramInspector >> updateLayout [

	self layout ifNotNil: [ 
		| newLayout |
		chartPresenters := Dictionary new.
		newLayout := self newLayout.
		self attributeValuesDo: [ :attributeValues | 
			attributeValues attributesDo: [ :attributeDef :vals :stats | 
				visibleAttributes
					at: attributeDef identifier
					ifPresent: [ :triple | 
						| form presenter |
						newLayout
							add: (SpBoxLayout newHorizontal
									 add: (self collapseButtonFor: attributeDef);
									 add: (self spawnButtonFor: attributeDef) expand: false)
							expand: false.
						form := self
							        chartWith: attributeDef
							        values: vals
							        min: triple first
							        max: triple second
							        divisions: triple third.
						presenter := self newImage.
						presenter image: form.
						chartPresenters at: attributeDef identifier put: presenter.
						newLayout add: presenter height: form height ]
					ifAbsent: [ 
						newLayout
							add: (self expandButtonFor: attributeDef values: vals)
							expand: false ] ] ].
		self layout: newLayout ]
]

{ #category : #updating }
RMDHistogramInspector >> updateObservation [
	self updateImage.
	self changed
]
