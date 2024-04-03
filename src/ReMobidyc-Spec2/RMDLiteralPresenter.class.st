Class {
	#name : #RMDLiteralPresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'unitPresenter',
		'numberPresenter'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDLiteralPresenter >> expressionChanged [

	unitPresenter label: (expression unit hasDimension
			 ifTrue: [ '[' , expression unit printString , ']' ]
			 ifFalse: [ '' ]).
	numberPresenter := expression literal asPresenter.
	super expressionChanged
]

{ #category : #initialization }
RMDLiteralPresenter >> initializePresenters [

	super initializePresenters.
	unitPresenter := self newLabel
		                 label: '';
		                 displayBold: [ true ];
		                 yourself.
	numberPresenter := self newLabel
		                       label: '';
		                       yourself
]

{ #category : #layouting }
RMDLiteralPresenter >> layout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 2;
				   vAlignCenter;
				   add: numberPresenter expand: false;
				   add: unitPresenter expand: false;
				   yourself)
		  expand: false;
		  yourself
]
