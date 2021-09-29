Class {
	#name : #RMDAnimatRendererPresenter,
	#superclass : #RMDRendererPresenter,
	#instVars : [
		'animatField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #api }
RMDAnimatRendererPresenter >> disableAgentFields [
	animatField enabled: false
]

{ #category : #api }
RMDAnimatRendererPresenter >> enableAgentFields [
	animatField enabled: true
]

{ #category : #initialization }
RMDAnimatRendererPresenter >> initializePresenters [
	super initializePresenters.
	animatField := self newAnimatInput
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
