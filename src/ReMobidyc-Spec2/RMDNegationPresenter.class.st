Class {
	#name : #RMDNegationPresenter,
	#superclass : #RMDConditionPresenter,
	#instVars : [
		'conditionPresenter'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDNegationPresenter >> conditionChanged [

	conditionPresenter := condition condition asPresenter.
	super conditionChanged
]

{ #category : #initialization }
RMDNegationPresenter >> initializePresenters [

	super initializePresenters.
	conditionPresenter := self newLabel label: '-'.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : #accessing }
RMDNegationPresenter >> layout [

	^ SpBoxLayout newVertical
		  borderWidth: 2;
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: ('not ' asPresenter displayBold: [ true ]) expand: false;
				   add: conditionPresenter expand: false;
				   yourself)
		  expand: false;
		  yourself
]
