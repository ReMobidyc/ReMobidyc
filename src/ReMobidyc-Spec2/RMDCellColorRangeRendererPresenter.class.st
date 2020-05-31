Class {
	#name : #RMDCellColorRangeRendererPresenter,
	#superclass : #RMDCellExpressionRendererPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDCellColorRangeRendererPresenter >> initializePresenters [
	super initializePresenters.
	minField := self newExpressionTextInput
		autoAccept: true;
		isLiteralOnly: true;
		whenLastValidExpressionChangedDo: [ :literal | 
			renderer min: literal.
			self valueChanged ].
	maxField := self newExpressionTextInput
		autoAccept: true;
		isLiteralOnly: true;
		whenLastValidExpressionChangedDo: [ :literal | 
			renderer max: literal.
			self valueChanged ]
]

{ #category : #updating }
RMDCellColorRangeRendererPresenter >> rendererChanged [
	super rendererChanged.
	self
		updateMinField;
		updateMaxField
]

{ #category : #updating }
RMDCellColorRangeRendererPresenter >> updateMaxField [
	renderer ifNotNil: [ maxField expression: renderer max ]
]

{ #category : #updating }
RMDCellColorRangeRendererPresenter >> updateMinField [
	renderer ifNotNil: [ minField expression: renderer min ]
]
