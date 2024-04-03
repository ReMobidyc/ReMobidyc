Class {
	#name : #RMDBinaryDistributionPresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'distributionLabel',
		'parameterLabel',
		'parameter1Presenter',
		'parameter2Presenter'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDBinaryDistributionPresenter >> expressionChanged [

	distributionLabel label: expression distributionName.
	parameter1Presenter := expression parameter1Expression asPresenter.
	parameterLabel label: expression parameterName.
	parameter2Presenter := expression parameter2Expression asPresenter.
	super expressionChanged
]

{ #category : #initialization }
RMDBinaryDistributionPresenter >> initializePresenters [

	super initializePresenters.
	distributionLabel := self newLabel
		                     displayBold: [ true ];
		                     label: 'random';
		                     yourself.
	parameter1Presenter := self newLabel
		                       label: '^';
		                       yourself.
	parameterLabel := self newLabel
		                  displayBold: [ true ];
		                  label: '';
		                  yourself.
	parameter2Presenter := self newLabel
		                       label: '';
		                       yourself.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : #layouting }
RMDBinaryDistributionPresenter >> layout [

	^ SpBoxLayout newVertical
		  vAlignCenter;
		  borderWidth: 2;
		  add: distributionLabel expand: false;
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: '    ' expand: false;
				   add: parameter1Presenter expand: false)
		  expand: false;
		  add: parameterLabel expand: false;
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: '    ' expand: false;
				   add: parameter2Presenter expand: false)
		  expand: false;
		  yourself
]
