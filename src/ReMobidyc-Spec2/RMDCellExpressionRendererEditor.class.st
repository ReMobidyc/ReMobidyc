Class {
	#name : #RMDCellExpressionRendererEditor,
	#superclass : #RMDRendererEditor,
	#instVars : [
		'expressionField',
		'minField',
		'maxField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDCellExpressionRendererEditor >> initializeWidgets [
	super initializeWidgets.
	expressionField := self newExpressionTextInput
		autoAccept: true;
		whenLastValidExpressionChangedDo: [ :expression | renderer expression: expression ].
	minField := self newExpressionTextInput
		autoAccept: true;
		isLiteralOnly: true;
		whenLastValidExpressionChangedDo: [ :literal | renderer min: literal ].
	maxField := self newExpressionTextInput
		autoAccept: true;
		isLiteralOnly: true;
		whenLastValidExpressionChangedDo: [ :literal | renderer max: literal ]
]

{ #category : #accessing }
RMDCellExpressionRendererEditor >> rendererChanged [
	super rendererChanged.
	self
		updateExpressionField;
		updateMinField;
		updateMaxField
]

{ #category : #updating }
RMDCellExpressionRendererEditor >> updateExpressionField [
	renderer
		ifNotNil: [ expressionField expression: renderer expression ]
]

{ #category : #updating }
RMDCellExpressionRendererEditor >> updateMaxField [
	renderer ifNotNil: [ maxField expression: renderer max ]
]

{ #category : #updating }
RMDCellExpressionRendererEditor >> updateMinField [
	renderer ifNotNil: [ minField expression: renderer min ]
]
