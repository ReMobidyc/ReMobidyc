Class {
	#name : #RMDPercentileInspector,
	#superclass : #RMDSpeciesObservatory,
	#instVars : [
		'image',
		'visibleProperties',
		'showsPercentiles',
		'showsMin',
		'showsMax',
		'showsMean',
		'showsSd'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDPercentileInspector class >> defaultSpec [

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

{ #category : #private }
RMDPercentileInspector >> collapsedIcon [
	^ Smalltalk ui theme 	treeUnexpandedForm
]

{ #category : #private }
RMDPercentileInspector >> expandedIcon [
	^ Smalltalk ui theme 	treeExpandedForm
]

{ #category : #accessing }
RMDPercentileInspector >> image [
	^ image
]

{ #category : #initialization }
RMDPercentileInspector >> initializePresenters [

	super initializePresenters.
	visibleProperties := Set new.
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
	self whenBuiltDo: [self updateImage]
]

{ #category : #private }
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
RMDPercentileInspector >> updateImage [

	self layout ifNotNil: [ :theLayout | 
		| box font fontHeight chartHeight chartWidth |
		box := self newLayout.
		font := TextStyle defaultFont.
		fontHeight := font height.
		chartHeight := 200.
		chartWidth := 300.
		self withWidgetDo: [ :w | chartWidth := w extent x ].
		self propertyValuesDo: [ :propertyValues | 
			propertyValues propertiesDo: [ :propertyDef :vals :stats | 
				(visibleProperties includes: propertyDef identifier)
					ifTrue: [ 
						| form canvas values resolution min max |
						box
							add: (self newButton
									 label: propertyDef printString;
									 icon: self expandedIcon;
									 action: [ 
										 visibleProperties
											 remove: propertyDef identifier
											 ifAbsent: [  ].
										 self updateObservation ])
							expand: false.

						form := Form
							        extent: chartWidth @ (chartHeight + fontHeight)
							        depth: 32.
						canvas := form getCanvas.
						canvas fillColor: Color white.
						values := vals asSortedCollection.
						showsPercentiles state ifTrue: [ 
							canvas
								line: form width // 4 @ 0
								to: form width // 4 @ (form height - fontHeight)
								width: 1
								color: Color lightGray;
								line: form width // 2 @ 0
								to: form width // 2 @ (form height - fontHeight)
								width: 1
								color: Color lightGray;
								line: form width * 3 // 4 @ 0
								to: form width * 3 // 4 @ (form height - fontHeight)
								width: 1
								color: Color lightGray ].

						resolution := values size min: chartWidth.
						min := stats at: #min.
						max := stats at: #max.
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
											drawString:
											((stats at: #mean) printShowingDecimalPlaces: 2)
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
									ysd := vsd - min * chartHeight / (min - max) asFloat
									       + chartHeight.
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
									ysd := vsd - min * chartHeight / (min - max) asFloat
									       + chartHeight.
									canvas
										line: 0 @ ysd
										to: chartWidth @ ysd
										width: 1
										color: Color lightGray ].
								0 to: resolution - 1 do: [ :i | 
									| value0 value1 |
									value0 := values at:
										          (i * (values size - 1) / resolution asFloat)
											          rounded + 1.
									value1 := values at:
										          (i + 1 * (values size - 1) / resolution asFloat)
											          rounded + 1.
									canvas
										line: i * chartWidth / resolution asFloat
											@
											(value0 - min * chartHeight / (min - max) asFloat
											 + chartHeight)
										to: i + 1 * chartWidth / resolution asFloat
											@
											(value1 - min * chartHeight / (min - max) asFloat
											 + chartHeight)
										width: 1
										color: Color blue darker ] ].
						canvas
							fillRectangle:
							(0 @ chartHeight extent: chartWidth @ fontHeight)
							color: (Color gray: 0.9).
						box add: form asPresenter height: form height ]
					ifFalse: [ 
						box
							add: (self newButton
									 label: propertyDef printString;
									 icon: self collapsedIcon;
									 borderWidth: 0;
									 borderColor: Color transparent;
									 action: [ 
										 visibleProperties add: propertyDef identifier.
										 self updateObservation ])
							expand: false ] ] ].
		showsPercentiles state ifTrue: [ 
			| form canvas |
			form := Form extent: chartWidth @ fontHeight depth: 32.
			canvas := form getCanvas.
			canvas fillColor: Color white.
			canvas
				drawString: '0'
				at: 0 @ (form height - fontHeight)
				font: font
				color: Color darkGray;
				drawString: '25'
				at: form width // 4 - ((font widthOfString: '25') // 2)
					@ (form height - fontHeight)
				font: font
				color: Color darkGray;
				drawString: '50'
				at: form width - (font widthOfString: '50') // 2
					@ (form height - fontHeight)
				font: font
				color: Color darkGray;
				drawString: '75'
				at: form width * 3 // 4 - ((font widthOfString: '75') // 2)
					@ (form height - fontHeight)
				font: font
				color: Color darkGray;
				drawString: '100'
				at:
					form width - (font widthOfString: '100')
					@ (form height - fontHeight)
				font: font
				color: Color darkGray.
			box add: form asPresenter height: form height ].
		self layout: box ]
]

{ #category : #private }
RMDPercentileInspector >> updateObservation [
	self updateImage.
	self changed
]
