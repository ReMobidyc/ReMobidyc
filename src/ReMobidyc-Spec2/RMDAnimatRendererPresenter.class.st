Class {
	#name : #RMDAnimatRendererPresenter,
	#superclass : #RMDRendererPresenter,
	#instVars : [
		'animatField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDAnimatRendererPresenter >> initializePresenters [
	super initializePresenters.
	animatField := self newAnimatInput
		autoAccept: true;
		whenLastValidTextChangedDo: [ :animat | 
			renderer animat: animat.
			self valueChanged ]
]

{ #category : #accessing }
RMDAnimatRendererPresenter >> rendererChanged [
	super rendererChanged.
	self updateAnimatField
]

{ #category : #updating }
RMDAnimatRendererPresenter >> updateAnimatField [
	animatField text: renderer animat
]
