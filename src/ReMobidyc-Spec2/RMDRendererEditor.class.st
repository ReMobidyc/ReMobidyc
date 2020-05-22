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
	colorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | color ifNotNil: [ renderer color: color ] ];
		yourself.
	self
		whenBuiltDo: [ self
				withWidgetDo: [ :w | 
					w
						update: #color: with: {Color white};
						update: #borderColor: with: {Color darkGray};
						update: #borderWidth: with: {1} ] ]
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
