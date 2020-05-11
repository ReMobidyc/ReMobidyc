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
	animatField := self newAnimatInput
		autoAccept: true;
		whenLastValidTextChangedDo: [ :animat | renderer animat: animat ]
]

{ #category : #accessing }
RMDAnimatRendererEditor >> rendererChanged [
	self updateAnimatField
]

{ #category : #updating }
RMDAnimatRendererEditor >> updateAnimatField [
	animatField text: renderer animat
]
