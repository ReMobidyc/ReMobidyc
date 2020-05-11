Class {
	#name : #RMDAnimatRendererEditor,
	#superclass : #RMDRendererEditor,
	#instVars : [
		'animatField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDAnimatRendererEditor >> initializeWidgets [
	super initializeWidgets.
	animatField := self newAnimatInput
		autoAccept: true;
		whenLastValidTextChangedDo: [ :animat | renderer animat: animat ]
]

{ #category : #accessing }
RMDAnimatRendererEditor >> rendererChanged [
	super rendererChanged.
	self updateAnimatField
]

{ #category : #updating }
RMDAnimatRendererEditor >> updateAnimatField [
	animatField text: renderer animat
]
