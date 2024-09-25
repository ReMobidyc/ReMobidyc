Class {
	#name : 'RMDPatchColorRangeRendererPresenter',
	#superclass : 'RMDPatchExpressionRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'testing' }
RMDPatchColorRangeRendererPresenter class >> isAbstract [

	^ self == RMDPatchColorRangeRendererPresenter
]

{ #category : 'initialization' }
RMDPatchColorRangeRendererPresenter >> initializePresenters [
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

{ #category : 'updating' }
RMDPatchColorRangeRendererPresenter >> rendererChanged [
	super rendererChanged.
	self
		updateMinField;
		updateMaxField
]

{ #category : 'updating' }
RMDPatchColorRangeRendererPresenter >> updateMaxField [
	renderer ifNotNil: [ maxField syntaxNode: renderer max ]
]

{ #category : 'updating' }
RMDPatchColorRangeRendererPresenter >> updateMinField [
	renderer ifNotNil: [ minField syntaxNode: renderer min ]
]
