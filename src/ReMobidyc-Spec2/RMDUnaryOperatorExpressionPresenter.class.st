Class {
	#name : #RMDUnaryOperatorExpressionPresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'operatorLabel',
		'argumentPresenter'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDUnaryOperatorExpressionPresenter >> expressionChanged [

	operatorLabel label: expression operator.
	argumentPresenter := expression expression asPresenter.
	super expressionChanged
]

{ #category : #initialization }
RMDUnaryOperatorExpressionPresenter >> initializePresenters [

	super initializePresenters.
	operatorLabel := self newLabel
		                 displayBold: [ true ];
		                 label: '-';
		                 yourself.
	argumentPresenter := self newLabel
		                     label: '';
		                     yourself.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : #layouting }
RMDUnaryOperatorExpressionPresenter >> layout [

	^ SpBoxLayout newVertical
		  borderWidth: 2;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 2;
				   vAlignCenter;
				   add: operatorLabel expand: false;
				   add: argumentPresenter expand: false;
				   yourself)
		  expand: false;
		  yourself
]
