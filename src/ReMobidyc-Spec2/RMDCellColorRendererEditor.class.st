Class {
	#name : #RMDCellColorRendererEditor,
	#superclass : #RMDCellExpressionRendererEditor,
	#instVars : [
		'borderColorDropList',
		'borderWidthField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDCellColorRendererEditor >> initializeWidgets [
	super initializeWidgets.
	borderColorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | color ifNotNil: [ renderer borderColor: color ] ];
		yourself.
	borderWidthField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :width | renderer borderWidth: width ]
]

{ #category : #accessing }
RMDCellColorRendererEditor >> rendererChanged [
	super rendererChanged.
	self
		updateBorderColorDropList;
		updateBorderWidthField
]

{ #category : #updating }
RMDCellColorRendererEditor >> updateBorderColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer borderColor.
			colors := borderColorDropList listItems.
			(colors includes: color)
				ifFalse: [ borderColorDropList items: (colors copyWith: color) ].
			borderColorDropList selectItem: color ]
]

{ #category : #updating }
RMDCellColorRendererEditor >> updateBorderWidthField [
	renderer ifNotNil: [ borderWidthField number: renderer borderWidth ]
]
