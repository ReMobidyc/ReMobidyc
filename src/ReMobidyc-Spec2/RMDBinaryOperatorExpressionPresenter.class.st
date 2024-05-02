Class {
	#name : 'RMDBinaryOperatorExpressionPresenter',
	#superclass : 'RMDExpressionPresenter',
	#instVars : [
		'operatorLabel',
		'argumentPresenter1',
		'argumentPresenter2'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDBinaryOperatorExpressionPresenter >> expressionChanged [

	operatorLabel label: expression operator.
	argumentPresenter1 := expression expression1 asPresenter.
	argumentPresenter2 := expression expression2 asPresenter.
	super expressionChanged
]

{ #category : 'initialization' }
RMDBinaryOperatorExpressionPresenter >> initializePresenters [

	super initializePresenters.
	operatorLabel := self newLabel
		                 displayBold: [ true ];
		                 label: '-';
		                 yourself.
	argumentPresenter1 := self newLabel
		                      label: '';
		                      yourself.
	argumentPresenter2 := self newLabel
		                      label: '';
		                      yourself.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : 'layouting' }
RMDBinaryOperatorExpressionPresenter >> layout [

	^ SpBoxLayout newVertical
		  borderWidth: 2;
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 2;
				   vAlignCenter;
				   add: argumentPresenter1 expand: false;
				   add: operatorLabel expand: false;
				   add: argumentPresenter2 expand: false;
				   yourself)
		  expand: false;
		  yourself
]
