Class {
	#name : #RMDAnimatDotRendererPresenter,
	#superclass : #RMDAnimatRendererPresenter,
	#instVars : [
		'diameterField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDAnimatDotRendererPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: #colorDropList width: 60;
				add: ' dot of ' expand: false;
				add: #diameterField width: 40;
				add: ' pixels' expand: false;
				yourself)
		height: self inputTextHeight
]

{ #category : #initialization }
RMDAnimatDotRendererPresenter >> initializePresenters [

	super initializePresenters.
	diameterField := self newNumberInput
		                 beInteger;
		                 whenLastValidNumberChangedDo: [ :diameter | 
			                 renderer diameter: diameter.
			                 self valueChanged ];
		                 yourself
]

{ #category : #accessing }
RMDAnimatDotRendererPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #accessing }
RMDAnimatDotRendererPresenter >> rendererChanged [
	super rendererChanged.
	self updateDiameterField
]

{ #category : #updating }
RMDAnimatDotRendererPresenter >> updateDiameterField [
	renderer ifNotNil: [ diameterField number: renderer diameter x ]
]
