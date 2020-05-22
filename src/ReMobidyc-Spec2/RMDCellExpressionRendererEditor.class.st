Class {
	#name : #RMDCellExpressionRendererEditor,
	#superclass : #RMDRendererEditor,
	#instVars : [
		'expressionField',
		'minField',
		'maxField',
		'borderWidthField',
		'borderColorDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDCellExpressionRendererEditor >> initializeWidgets [
	super initializeWidgets.
	borderColorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | color ifNotNil: [ renderer borderColor: color ] ];
		yourself.
	borderWidthField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :width | renderer borderWidth: width ].
	expressionField := self newExpressionTextInput
		autoAccept: true;
		whenLastValidExpressionChangedDo: [ :expression | renderer expression: expression ].

]

{ #category : #accessing }
RMDCellExpressionRendererEditor >> preferredHeight [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
RMDCellExpressionRendererEditor >> rendererChanged [
	super rendererChanged.
	self
		updateExpressionField;
		updateBorderColorDropList;
		updateBorderWidthField
]

{ #category : #updating }
RMDCellExpressionRendererEditor >> updateBorderColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer borderColor.
			colors := borderColorDropList listItems.
			(colors includes: color)
				ifFalse: [ borderColorDropList items: (colors copyWith: color) ].
			borderColorDropList selectItem: color ]
]

{ #category : #updating }
RMDCellExpressionRendererEditor >> updateBorderWidthField [
	renderer ifNotNil: [ borderWidthField number: renderer borderWidth ]
]

{ #category : #updating }
RMDCellExpressionRendererEditor >> updateExpressionField [
	renderer
		ifNotNil: [ expressionField expression: renderer expression ]
]
