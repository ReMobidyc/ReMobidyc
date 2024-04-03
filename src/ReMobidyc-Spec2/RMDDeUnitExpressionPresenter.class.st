Class {
	#name : #RMDDeUnitExpressionPresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'unitPresenter',
		'expressionPresenter'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDDeUnitExpressionPresenter >> expressionChanged [

	unitPresenter label: '(' , expression unit printString , ')'.
	expressionPresenter := expression expression asPresenter.
	super expressionChanged
]

{ #category : #initialization }
RMDDeUnitExpressionPresenter >> initializePresenters [

	super initializePresenters.
	unitPresenter := self newLabel
		                 label: '(-)';
		                 displayBold: [ true ];
		                 yourself.
	expressionPresenter := self newLabel
		                       label: '';
		                       yourself
]

{ #category : #layouting }
RMDDeUnitExpressionPresenter >> layout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 2;
				   vAlignCenter;
				   add: unitPresenter expand: false;
				   add: expressionPresenter expand: false;
				   yourself)
		  expand: false;
		  yourself
]
