Class {
	#name : #RMDCellColorRangeRendererPresenter,
	#superclass : #RMDCellExpressionRendererPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #initialization }
RMDCellColorRangeRendererPresenter >> initializePresenters [
	super initializePresenters.
	minField := self newSyntaxNodeTextInput
		beLiteral;
		whenLastValidSyntaxNodeChangedDo: [ :literal | 
			renderer min: literal.
			self valueChanged ].
	maxField := self newSyntaxNodeTextInput
		beLiteral;
		whenLastValidSyntaxNodeChangedDo: [ :literal | 
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
	renderer ifNotNil: [ maxField syntaxNode: renderer max ]
]

{ #category : #updating }
RMDCellColorRangeRendererPresenter >> updateMinField [
	renderer ifNotNil: [ minField syntaxNode: renderer min ]
]
