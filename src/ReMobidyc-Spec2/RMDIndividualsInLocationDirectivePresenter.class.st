Class {
	#name : 'RMDIndividualsInLocationDirectivePresenter',
	#superclass : 'RMDExpressionPresenter',
	#instVars : [
		'directiveLabel',
		'animatLabel',
		'locationLabel'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDIndividualsInLocationDirectivePresenter >> expressionChanged [

	directiveLabel label: expression directiveName , ' '.
	animatLabel label: expression animatName.
	locationLabel label: ' ' , expression locationName.
	super expressionChanged
]

{ #category : 'initialization' }
RMDIndividualsInLocationDirectivePresenter >> initializePresenters [

	super initializePresenters.
	directiveLabel := self newLabel
		                  displayBold: [ true ];
		                  label: 'direction neighbor''s ';
		                  yourself.
	animatLabel := self newLabel
		               label: '-';
		               yourself.
	locationLabel := self newLabel
		                 displayBold: [ true ];
		                 label: 'somewhere';
		                 yourself
]

{ #category : 'layouting' }
RMDIndividualsInLocationDirectivePresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newHorizontal.
	newLayout add: directiveLabel expand: false.
	newLayout add: animatLabel expand: false.
	newLayout add: locationLabel expand: false.
	^ newLayout
]
