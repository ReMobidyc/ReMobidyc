Class {
	#name : #RMDPowerExpressionPresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'operatorLabel',
		'argumentPresenter1',
		'argumentPresenter2'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDPowerExpressionPresenter >> expressionChanged [

	operatorLabel label: expression operator.
	argumentPresenter1 := expression expression asPresenter.
	argumentPresenter2 := expression order asPresenter.
	super expressionChanged
]

{ #category : #initialization }
RMDPowerExpressionPresenter >> initializePresenters [

	super initializePresenters.
	operatorLabel := self newLabel
		                 label: '^';
		                 displayBold: [ true ];
		                 yourself.
	argumentPresenter1 := self newLabel
		                      label: '';
		                      yourself.
	argumentPresenter2 := self newLabel
		                      label: '';
		                      displayBold: [ true ];
		                      yourself.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : #layouting }
RMDPowerExpressionPresenter >> layout [

	^ SpBoxLayout newVertical
		  vAlignCenter;
		  borderWidth: 2;
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: argumentPresenter1 expand: false;
				   add: operatorLabel expand: false;
				   add: (SpBoxLayout newVertical
						    borderWidth: 8;
						    add: argumentPresenter2 expand: false)
				   expand: false;
				   yourself)
		  expand: false;
		  yourself
]
