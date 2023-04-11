Class {
	#name : #RMDAnimatShapeRendererPresenter,
	#superclass : #RMDAnimatRendererPresenter,
	#instVars : [
		'shapeSizeField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #testing }
RMDAnimatShapeRendererPresenter class >> isAbstract [

	^ self == RMDAnimatShapeRendererPresenter
]

{ #category : #initialization }
RMDAnimatShapeRendererPresenter >> initializePresenters [

	super initializePresenters.
	shapeSizeField := self newNumberInput
		                 beInteger;
		                 minimum: 1;
		                 maximum: 40;
		                 whenLastValidNumberChangedDo: [ :diameter | 
			                 renderer shapeSize: diameter.
			                 self valueChanged ];
		                 yourself
]

{ #category : #accessing }
RMDAnimatShapeRendererPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #accessing }
RMDAnimatShapeRendererPresenter >> rendererChanged [
	super rendererChanged.
	self updateShapeSizeField
]

{ #category : #updating }
RMDAnimatShapeRendererPresenter >> updateShapeSizeField [

	renderer ifNotNil: [ shapeSizeField number: renderer shapeSize ]
]
