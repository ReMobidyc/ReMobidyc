Class {
	#name : #RMDCellColorRangeRendererEditor,
	#superclass : #RMDCellExpressionRendererEditor,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDCellColorRangeRendererEditor >> initializeWidgets [
	super initializeWidgets.
	minField := self newExpressionTextInput
		autoAccept: true;
		isLiteralOnly: true;
		whenLastValidExpressionChangedDo: [ :literal | renderer min: literal ].
	maxField := self newExpressionTextInput
		autoAccept: true;
		isLiteralOnly: true;
		whenLastValidExpressionChangedDo: [ :literal | renderer max: literal ]
]

{ #category : #updating }
RMDCellColorRangeRendererEditor >> rendererChanged [
	super rendererChanged.
	self
		updateMinField;
		updateMaxField
]

{ #category : #updating }
RMDCellColorRangeRendererEditor >> updateMaxField [
	renderer ifNotNil: [ maxField expression: renderer max ]
]

{ #category : #updating }
RMDCellColorRangeRendererEditor >> updateMinField [
	renderer ifNotNil: [ minField expression: renderer min ]
]
