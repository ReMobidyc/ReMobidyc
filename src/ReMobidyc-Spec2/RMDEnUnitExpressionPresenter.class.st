Class {
	#name : 'RMDEnUnitExpressionPresenter',
	#superclass : 'RMDExpressionPresenter',
	#instVars : [
		'unitPresenter',
		'expressionPresenter'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDEnUnitExpressionPresenter >> expressionChanged [

	unitPresenter label: '[' , expression unit printString , ']'.
	expressionPresenter := expression expression asPresenter.
	super expressionChanged
]

{ #category : 'initialization' }
RMDEnUnitExpressionPresenter >> initializePresenters [

	super initializePresenters.
	unitPresenter := self newLabel
		                 label: '(-)';
		                 displayBold: [ true ];
		                 yourself.
	expressionPresenter := self newLabel
		                       label: '';
		                       yourself
]

{ #category : 'layouting' }
RMDEnUnitExpressionPresenter >> layout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 2;
				   vAlignCenter;
				   add: expressionPresenter expand: false;
				   add: unitPresenter expand: false;
				   yourself)
		  expand: false;
		  yourself
]
