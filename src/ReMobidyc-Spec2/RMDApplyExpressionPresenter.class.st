Class {
	#name : #RMDApplyExpressionPresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'functionLabel',
		'argumentPresenters'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDApplyExpressionPresenter >> expressionChanged [

	functionLabel label: expression function , '('.
	argumentPresenters := expression arguments collect: #asPresenter.
	super expressionChanged
]

{ #category : #initialization }
RMDApplyExpressionPresenter >> initializePresenters [

	super initializePresenters.
	functionLabel := self newLabel
		                 displayBold: [ true ];
		                 label: '-';
		                 yourself.
	argumentPresenters := Array new.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : #layouting }
RMDApplyExpressionPresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newVertical.
	newLayout borderWidth: 2.
	newLayout add: functionLabel expand: false.
	argumentPresenters
		do: [ :presenter |
			newLayout
				add: (SpBoxLayout newHorizontal
						 add: '    ' asPresenter expand: false;
						 add: presenter expand: false)
				expand: false ]
		separatedBy: [ newLayout add: ',' asPresenter expand: false ].
	newLayout add: ')' asPresenter expand: false.
	^ newLayout
]
