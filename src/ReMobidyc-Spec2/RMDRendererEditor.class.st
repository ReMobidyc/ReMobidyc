Class {
	#name : #RMDRendererEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'renderer',
		'colorDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #'instance creation' }
RMDRendererEditor class >> on: aRMDRenderer [
	^ self new
		renderer: aRMDRenderer;
		yourself
]

{ #category : #initialization }
RMDRendererEditor >> initializeWidgets [
	super initializeWidgets.
	colorDropList := self newColor
		whenSelectedItemChangedDo: [ :color | color ifNotNil: [ renderer color: color ] ];
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
	self updateColorDropList
]

{ #category : #updating }
RMDRendererEditor >> updateColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer color.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: renderer color ]
]
