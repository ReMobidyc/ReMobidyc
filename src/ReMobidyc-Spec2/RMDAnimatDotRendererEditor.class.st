Class {
	#name : #RMDAnimatDotRendererEditor,
	#superclass : #RMDAnimatRendererEditor,
	#instVars : [
		'diameterField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAnimatDotRendererEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '' width: 20;
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
RMDAnimatDotRendererEditor >> initializeWidgets [
	super initializeWidgets.
	diameterField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :diameter | renderer diameter: diameter ]
]

{ #category : #accessing }
RMDAnimatDotRendererEditor >> rendererChanged [
	super rendererChanged.
	self updateDiameterField
]

{ #category : #updating }
RMDAnimatDotRendererEditor >> updateDiameterField [
	renderer ifNotNil: [ diameterField number: renderer diameter x ]
]
