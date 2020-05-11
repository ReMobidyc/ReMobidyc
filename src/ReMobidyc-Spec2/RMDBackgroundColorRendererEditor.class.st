Class {
	#name : #RMDBackgroundColorRendererEditor,
	#superclass : #RMDRendererEditor,
	#instVars : [
		'colorDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDBackgroundColorRendererEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '' width: 20;
				add: (SpBoxLayout newVertical addLast: 'Background' expand: false)
					width: 50;
				add: #colorDropList width: 60)
		height: self inputTextHeight
]

{ #category : #initialization }
RMDBackgroundColorRendererEditor >> initializeWidgets [
	super initializeWidgets.
	colorDropList := self newColor
		whenSelectedItemChangedDo: [ :color | color ifNotNil: [ renderer color: color ] ];
		yourself
]

{ #category : #accessing }
RMDBackgroundColorRendererEditor >> rendererChanged [
	self updateColorDropList
]

{ #category : #updating }
RMDBackgroundColorRendererEditor >> updateColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer color.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: renderer color ]
]
