Class {
	#name : #RMDPatchExpressionRendererPresenter,
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

{ #category : #api }
RMDPatchExpressionRendererPresenter >> disableAgentFields [
	
]

{ #category : #api }
RMDPatchExpressionRendererPresenter >> enableAgentFields [
	
]

{ #category : #initialization }
RMDPatchExpressionRendererPresenter >> initializePresenters [
	super initializePresenters.
	borderColorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | 
			color
				ifNotNil: [ renderer borderColor: color.
					self valueChanged ] ];
		yourself.
	borderWidthField := self newNumberInput
		beInteger;
		whenLastValidNumberChangedDo: [ :width | 
			renderer borderWidth: width.
			self valueChanged ].
	expressionField := self newSyntaxNodeTextInput
		beExpression;
		whenLastValidSyntaxNodeChangedDo: [ :expression | 
			renderer expression: expression.
			self valueChanged ]
]

{ #category : #accessing }
RMDPatchExpressionRendererPresenter >> preferredHeight [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
RMDPatchExpressionRendererPresenter >> rendererChanged [
	super rendererChanged.
	self
		updateExpressionField;
		updateBorderColorDropList;
		updateBorderWidthField
]

{ #category : #updating }
RMDPatchExpressionRendererPresenter >> updateBorderColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer borderColor.
			colors := borderColorDropList listItems.
			(colors includes: color)
				ifFalse: [ borderColorDropList items: (colors copyWith: color) ].
			borderColorDropList selectItem: color ]
]

{ #category : #updating }
RMDPatchExpressionRendererPresenter >> updateBorderWidthField [
	renderer ifNotNil: [ borderWidthField number: renderer borderWidth ]
]

{ #category : #updating }
RMDPatchExpressionRendererPresenter >> updateExpressionField [
	renderer ifNotNil: [ expressionField syntaxNode: renderer expression ]
]
