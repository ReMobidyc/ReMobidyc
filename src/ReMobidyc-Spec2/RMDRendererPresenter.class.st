Class {
	#name : #RMDRendererPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'renderer',
		'colorDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #'instance creation' }
RMDRendererPresenter class >> on: aRMDRenderer [
	^ self new
		renderer: aRMDRenderer;
		yourself
]

{ #category : #initialization }
RMDRendererPresenter >> initializePresenters [
	super initializePresenters.
	colorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | 
			color
				ifNotNil: [ renderer color: color.
					self valueChanged ] ];
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
RMDRendererPresenter >> renderer [
	^ renderer
]

{ #category : #accessing }
RMDRendererPresenter >> renderer: aRMDRenderer [
	renderer := aRMDRenderer.
	self rendererChanged
]

{ #category : #accessing }
RMDRendererPresenter >> rendererChanged [
	self updateColorDropList
]

{ #category : #updating }
RMDRendererPresenter >> updateColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer color.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: renderer color ]
]
