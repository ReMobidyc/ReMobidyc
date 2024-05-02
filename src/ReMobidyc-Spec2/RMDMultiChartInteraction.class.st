Class {
	#name : 'RMDMultiChartInteraction',
	#superclass : 'RSKeyNavigationCanvasInteraction',
	#instVars : [
		'currentShapeIndex'
	],
	#category : 'ReMobidyc-Spec2-Tabulars',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Tabulars'
}

{ #category : 'initialization' }
RMDMultiChartInteraction >> initialize [
	super initialize.
	currentShapeIndex :=1
]

{ #category : 'events' }
RMDMultiChartInteraction >> moveFrom: fromShape to: toShape [
	| canvas camera oldPosition newPosition |
	canvas := toShape canvas.
	camera := canvas camera.
	oldPosition := camera position.
	canvas camera 
		zoomToFit:  (canvas extent * 0.9)
		rectangle: toShape encompassingRectangle.
	newPosition := camera position.

	canvas newAnimation
		duration: 500 milliSeconds;
		easing: RSEasingInterpolator backOut;
		from: oldPosition;
		to: newPosition;
		onStepDo: [ :aPosition |
			camera translateTo: aPosition.
			canvas signalUpdate
		]
	
	
]

{ #category : 'events' }
RMDMultiChartInteraction >> onShape: aCanvas [
	super onShape: aCanvas.
	aCanvas when: RSExtentChangedEvent send: #zoomToFit to: aCanvas.
]

{ #category : 'events' }
RMDMultiChartInteraction >> processKeyDown: evt [
	| keyName |
	keyName := evt keyName.
	keyName = #I ifTrue: [ ^ self zoomIn: evt canvas ].
	keyName = #O ifTrue: [ ^ self zoomOut: evt canvas ].
	
	evt shiftKeyPressed ifTrue: [ ^ self processKeyDownWithShift: evt  ].
	
	self configuration hasHorizontalScrolling ifTrue: [
		keyName = #LEFT ifTrue: [ steps add: -1@0 ].
		keyName = #RIGHT ifTrue: [ steps add: 1@0 ].
	].
	self configuration hasVerticalScrolling ifTrue: [ 
		keyName = #UP ifTrue: [ steps add: 0@ -1 ].
		keyName = #DOWN ifTrue: [ steps add: 0@ 1 ].
	].
	
	speedMult := evt shiftKeyPressed
		ifTrue: [ 4 ] 
		ifFalse: [ 1 ].
	animation ifNotNil: [ ^ self ].
	steps ifEmpty: [ ^ self ].
	self processStepsOn: evt canvas
]

{ #category : 'events' }
RMDMultiChartInteraction >> processKeyDownWithShift: evt [
	| newIndex keyName shapes |
	newIndex := nil.
	keyName := evt keyName.
	shapes := evt canvas shapes.
	keyName = #LEFT ifTrue: [ 
		newIndex := 1 max: currentShapeIndex - 1.
	].
	keyName = #RIGHT ifTrue: [ 
		newIndex := shapes size min: currentShapeIndex + 1.
	].
	newIndex ifNil: [ ^ self ].
	self moveFrom: (shapes at: currentShapeIndex) to: (shapes at: newIndex). 
	currentShapeIndex := newIndex.
]
