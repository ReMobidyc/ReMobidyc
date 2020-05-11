Class {
	#name : #RMDAnimatDotRendererEditor,
	#superclass : #RMDAnimatRendererEditor,
	#instVars : [
		'colorDropList',
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
				add: (SpBoxLayout newVertical addLast: ' → ' expand: false)
					width: 16;
				add: #colorDropList width: 60;
				add: (SpBoxLayout newVertical addLast: ' dot of ' expand: false)
					width: 50;
				add: #diameterField width: 40;
				add: (SpBoxLayout newVertical addLast: ' pixels' expand: false)
					width: 50;
				yourself)
		height: self inputTextHeight
]

{ #category : #initialization }
RMDAnimatDotRendererEditor >> initializeWidgets [
	super initializeWidgets.
	colorDropList := self newColor
		whenSelectedItemChangedDo: [ :color | color ifNotNil: [ renderer color: color ] ];
		yourself.
	diameterField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :diameter | renderer diameter: diameter ]
]

{ #category : #accessing }
RMDAnimatDotRendererEditor >> rendererChanged [
	super rendererChanged.
	self
		updateColorDropList;
		updateDiameterField
]

{ #category : #updating }
RMDAnimatDotRendererEditor >> updateColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer color.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: renderer color ]
]

{ #category : #updating }
RMDAnimatDotRendererEditor >> updateDiameterField [
	renderer ifNotNil: [ diameterField number: renderer diameter x ]
]
