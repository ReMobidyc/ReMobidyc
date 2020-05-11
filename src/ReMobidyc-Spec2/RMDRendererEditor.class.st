Class {
	#name : #RMDRendererEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'renderer'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #'instance creation' }
RMDRendererEditor class >> on: aRMDRenderer [
	^ self new
		renderer: aRMDRenderer;
		yourself
]

{ #category : #accessing }
RMDRendererEditor >> renderer [
	^ renderer
]

{ #category : #accessing }
RMDRendererEditor >> renderer: aRMDRenderer [
	renderer := aRMDRenderer.
	self rendererChanged
]

{ #category : #accessing }
RMDRendererEditor >> rendererChanged [
	^ self subclassResponsibility
]
