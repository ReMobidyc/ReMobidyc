Class {
	#name : 'RMDChancePresenter',
	#superclass : 'RMDConditionPresenter',
	#instVars : [
		'expressionPresenter'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDChancePresenter >> conditionChanged [

	expressionPresenter := condition probability asPresenter.
	super conditionChanged
]

{ #category : 'initialization' }
RMDChancePresenter >> initializePresenters [

	super initializePresenters.
	expressionPresenter := self newLabel label: '-'
]

{ #category : 'accessing' }
RMDChancePresenter >> layout [

	^ SpBoxLayout newVertical
		  borderWidth: 2;
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: expressionPresenter expand: false;
				   add: (' chance' asPresenter displayBold: [ true ])
				   expand: false)
		  expand: false;
		  yourself
]
