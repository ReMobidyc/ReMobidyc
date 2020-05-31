Class {
	#name : #RMDCellExpressionRendererPresenter,
	#superclass : #RMDRendererPresenter,
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
RMDCellExpressionRendererPresenter >> initializePresenters [
	super initializePresenters.
	borderColorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | 
			color
				ifNotNil: [ renderer borderColor: color.
					self valueChanged ] ];
		yourself.
	borderWidthField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :width | 
			renderer borderWidth: width.
			self valueChanged ].
	expressionField := self newExpressionTextInput
		autoAccept: true;
		whenLastValidExpressionChangedDo: [ :expression | 
			renderer expression: expression.
			self valueChanged ]
]

{ #category : #accessing }
RMDCellExpressionRendererPresenter >> preferredHeight [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
RMDCellExpressionRendererPresenter >> rendererChanged [
	super rendererChanged.
	self
		updateExpressionField;
		updateBorderColorDropList;
		updateBorderWidthField
]

{ #category : #updating }
RMDCellExpressionRendererPresenter >> updateBorderColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer borderColor.
			colors := borderColorDropList listItems.
			(colors includes: color)
				ifFalse: [ borderColorDropList items: (colors copyWith: color) ].
			borderColorDropList selectItem: color ]
]

{ #category : #updating }
RMDCellExpressionRendererPresenter >> updateBorderWidthField [
	renderer ifNotNil: [ borderWidthField number: renderer borderWidth ]
]

{ #category : #updating }
RMDCellExpressionRendererPresenter >> updateExpressionField [
	renderer
		ifNotNil: [ expressionField expression: renderer expression ]
]
