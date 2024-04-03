Class {
	#name : #RMDIndividualsInRadiusDirectivePresenter,
	#superclass : #RMDIndividualsInLocationDirectivePresenter,
	#instVars : [
		'radiusPresenter'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDIndividualsInRadiusDirectivePresenter >> expressionChanged [

	radiusPresenter := expression radius asPresenter.
	super expressionChanged
]

{ #category : #initialization }
RMDIndividualsInRadiusDirectivePresenter >> initializePresenters [

	super initializePresenters.
	radiusPresenter := self newLabel
		                   displayBold: [ true ];
		                   label: 'some';
		                   yourself
]

{ #category : #layouting }
RMDIndividualsInRadiusDirectivePresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newHorizontal.
	newLayout add: directiveLabel expand: false.
	newLayout add: animatLabel expand: false.
	newLayout
		add: (' in ' asPresenter displayBold: [ true ])
		expand: false.
	newLayout add: radiusPresenter expand: false.
	newLayout add: locationLabel expand: false.
	^ newLayout
]
