Class {
	#name : #RMDDistributionInspector,
	#superclass : #RMDSpeciesObservatory,
	#instVars : [
		'image',
		'showsPercentiles',
		'showsMin',
		'showsMax',
		'showsMean',
		'showsSd'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDDistributionInspector class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #showsPercentiles;
				add: #showsMin;
				add: #showsMax;
				add: #showsMean;
				add: #showsSd)
			height: self buttonHeight;
		add: (SpScrollableLayout with: #image)
		"	expand: true
			fill: false
			padding: 0"
]

{ #category : #accessing }
RMDDistributionInspector >> image [
	^ image
]

{ #category : #initialization }
RMDDistributionInspector >> initializePresenters [
	super initializePresenters.
	"image := self newImage
		autoScale: false;
		yourself."
	image := self newComponentList.
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
	self updateImage
]

{ #category : #private }
RMDDistributionInspector >> updateImage [
	image ifNil: [ ^ self ].
	image
		items:
			(Array
				streamContents: [ :stream | 
					| font fontHeight chartHeight chartWidth |
					font := TextStyle defaultFont.
					fontHeight := font height.
					chartHeight := 200.
					chartWidth := 300.
					self withWidgetDo: [ :w | chartWidth := w extent x - 50 ].
					self
						propertyValuesDo: [ :propertyValues | 
							showsPercentiles state
								ifTrue: [ | form canvas |
									form := Form extent: chartWidth @ fontHeight depth: 32.
									canvas := form getCanvas.
									canvas fillColor: Color white.
									canvas
										drawString: '0'
											at: 0 @ (form height - fontHeight)
											font: font
											color: Color darkGray;
										drawString: '25'
											at:
											(form width // 4 - ((font widthOfString: '25') // 2))
													@ (form height - fontHeight)
											font: font
											color: Color darkGray;
										drawString: '50'
											at:
											((form width - (font widthOfString: '50')) // 2)
													@ (form height - fontHeight)
											font: font
											color: Color darkGray;
										drawString: '75'
											at:
											(form width * 3 // 4 - ((font widthOfString: '75') // 2))
													@ (form height - fontHeight)
											font: font
											color: Color darkGray;
										drawString: '100'
											at:
											(form width - (font widthOfString: '100'))
													@ (form height - fontHeight)
											font: font
											color: Color darkGray.
									stream nextPut: form ].
							propertyValues
								propertiesDo: [ :propertyDef :vals :stats | 
									| form canvas values resolution min max |
									form := Form
										extent: chartWidth @ (chartHeight + fontHeight + fontHeight)
										depth: 32.
									canvas := form getCanvas.
									canvas fillColor: Color white.
									values := vals asSortedCollection.
									showsPercentiles state
										ifTrue: [ canvas
												line: (form width // 4) @ 0
													to: (form width // 4) @ (form height - fontHeight)
													width: 1
													color: Color lightGray;
												line: (form width // 2) @ 0
													to: (form width // 2) @ (form height - fontHeight)
													width: 1
													color: Color lightGray;
												line: (form width * 3 // 4) @ 0
													to: (form width * 3 // 4) @ (form height - fontHeight)
													width: 1
													color: Color lightGray ].
									canvas
										fillRectangle: (0 @ 0 extent: chartWidth @ fontHeight)
											color: (Color gray: 0.9);
										drawString: propertyDef printString
											at: 0 @ 0
											font: font
											color: Color black.
									resolution := values size min: chartWidth.
									min := stats at: #min.
									max := stats at: #max.
									min = max
										ifTrue: [ canvas
												line: 0 @ (chartHeight // 2 + fontHeight)
												to: chartWidth @ (chartHeight // 2 + fontHeight)
												width: 1
												color: Color black.
											(showsMin state or: [ showsMax state or: [ showsMean state ] ])
												ifTrue: [ canvas
														drawString: ((stats at: #mean) printShowingDecimalPlaces: 2)
														at: 10 @ (chartHeight // 2 + fontHeight + 2)
														font: font
														color: Color black ] ]
										ifFalse: [ | vmean ymean vsd ysd |
											showsMin state
												ifTrue: [ canvas
														drawString: 'min=' , ((stats at: #min) printShowingDecimalPlaces: 2)
														at: 10 @ chartHeight
														font: font
														color: Color black ].
											showsMax state
												ifTrue: [ canvas
														drawString: 'max=' , ((stats at: #max) printShowingDecimalPlaces: 2)
														at: 10 @ fontHeight
														font: font
														color: Color black ].
											vmean := stats at: #mean.
											ymean := (vmean - min) * chartHeight / (min - max) asFloat
												+ fontHeight + chartHeight.
											(showsMean state or: [ showsSd state ])
												ifTrue: [ canvas
														line: 0 @ ymean
														to: chartWidth @ ymean
														width: 1
														color: Color black ].
											showsMean state
												ifTrue: [ canvas
														drawString: 'mean=' , ((stats at: #mean) printShowingDecimalPlaces: 2)
														at: 10 @ (ymean + 2)
														font: font
														color: Color black ].
											showsSd state
												ifTrue: [ vsd := vmean + (stats at: #sd).
													ysd := (vsd - min) * chartHeight / (min - max) asFloat
														+ fontHeight + chartHeight.
													canvas
														drawString: 'sigma=' , ((stats at: #sd) printShowingDecimalPlaces: 2)
														at: 20 @ ((ymean + ysd) * 0.5 - (fontHeight * 0.5))
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
													ysd := (vsd - min) * chartHeight / (min - max) asFloat
														+ fontHeight + chartHeight.
													canvas
														line: 0 @ ysd
														to: chartWidth @ ysd
														width: 1
														color: Color lightGray ].
											0 to: resolution - 1 do: [ :i | 
												| value0 value1 |
												value0 := values
													at: (i * (values size - 1) / resolution asFloat) rounded + 1.
												value1 := values
													at: ((i + 1) * (values size - 1) / resolution asFloat) rounded + 1.
												canvas
													line:
														(i * chartWidth / resolution asFloat)
															@
																((value0 - min) * chartHeight / (min - max) asFloat + fontHeight
																	+ chartHeight)
													to:
														((i + 1) * chartWidth / resolution asFloat)
															@
																((value1 - min) * chartHeight / (min - max) asFloat + fontHeight
																	+ chartHeight)
													width: 1
													color: Color blue darker ] ].
									canvas
										fillRectangle: (0 @ (chartHeight + fontHeight) extent: chartWidth @ fontHeight)
										color: (Color gray: 0.9).
									stream nextPut: form ] ] ])
]

{ #category : #private }
RMDDistributionInspector >> updateObservation [
	self updateImage
]
