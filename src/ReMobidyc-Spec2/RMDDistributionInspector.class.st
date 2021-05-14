Class {
	#name : #RMDDistributionInspector,
	#superclass : #RMDSpeciesObservatory,
	#instVars : [
		'image'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDDistributionInspector class >> defaultSpec [

	^ SpBoxLayout newVertical add: #image
]

{ #category : #accessing }
RMDDistributionInspector >> image [
	^ image
]

{ #category : #initialization }
RMDDistributionInspector >> initializePresenters [
	super initializePresenters.
	image := self newImage.
	self updateImage
]

{ #category : #private }
RMDDistributionInspector >> updateImage [
	image ifNil: [ ^ self ].
	self
		speciesDefinitionDo: [ :def | 
			((interpreter numberOfIndivisualsOf: def) > 0
				and: [ def propertyDeclarations notEmpty ])
				ifTrue:
					[ | valuesArray individualIndex font fontHeight chartHeight chartWidth form canvas |
					valuesArray := (1 to: def propertyDeclarations size)
						collect: [ :i | Array new: (interpreter numberOfIndivisualsOf: def) ].
					individualIndex := 1.
					interpreter
						individualsOf: def
						do: [ :id | 
							interpreter
								withObserverContextWithSubject: id
								species: def
								do: [ def propertyDeclarations
										doWithIndex: [ :propertyDef :propertyIndex | 
											(valuesArray at: propertyIndex)
												at: individualIndex
												put:
													(propertyDef unit
														fromSI:
															(interpreter
																readVariable: propertyDef identifier
																agent: nil
																ifAbsent: [ nil ])) ] ].
							individualIndex := individualIndex + 1 ].
					font := TextStyle defaultFont.
					fontHeight := font height.
					chartHeight := 100.
					chartWidth := 300.
					self withWidgetDo: [ :w | chartWidth := w extent x ].
					form := Form
						extent:
							chartWidth
								@ ((chartHeight + fontHeight) * valuesArray size + fontHeight).
					canvas := form getCanvas.
					canvas
						drawString: '0'
							at: 0 @ (form height - fontHeight)
							font: font
							color: Color darkGray;
						drawString: '25'
							at: (form width // 4) @ (form height - fontHeight)
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
							(form width * 3 // 4 - (font widthOfString: '75'))
									@ (form height - fontHeight)
							font: font
							color: Color darkGray;
						drawString: '100'
							at:
							(form width - (font widthOfString: '100'))
									@ (form height - fontHeight)
							font: font
							color: Color darkGray.
					valuesArray
						doWithIndex: [ :vs :chartIndex | 
							| values yOffset propertyDef resolution min max |
							values := vs asSortedCollection.
							yOffset := (chartIndex - 1) * (chartHeight + fontHeight).
							propertyDef := def propertyDeclarations at: chartIndex.
							canvas
								drawString: propertyDef identifier , ' [' , propertyDef unit printString , ']'
								at: 0 @ yOffset
								font: font
								color: Color black.
							resolution := values size min: chartWidth.
							min := values min.
							max := values max.
							min = max
								ifTrue: [ canvas
										line: 0 @ (chartHeight // 2 + fontHeight + yOffset)
										to: chartWidth @ (chartHeight // 2 + fontHeight + yOffset)
										width: 1
										color: Color black ]
								ifFalse: [ 0 to: resolution - 1 do: [ :i | 
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
															+ chartHeight + yOffset)
											to:
												((i + 1) * chartWidth / resolution asFloat)
													@
														((value1 - min) * chartHeight / (min - max) asFloat + fontHeight
															+ chartHeight + yOffset)
											width: 1
											color: Color black ] ] ].
					image image: form ] ]
]

{ #category : #private }
RMDDistributionInspector >> updateObservation [
	self updateImage
]
