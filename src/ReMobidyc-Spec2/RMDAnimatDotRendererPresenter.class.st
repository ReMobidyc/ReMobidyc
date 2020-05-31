Class {
	#name : #RMDAnimatDotRendererPresenter,
	#superclass : #RMDAnimatRendererPresenter,
	#instVars : [
		'diameterField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAnimatDotRendererPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: #animatField width: 100;
				add: ' → ' expand: false;
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
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :diameter | 
			renderer diameter: diameter.
			self valueChanged ]
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
