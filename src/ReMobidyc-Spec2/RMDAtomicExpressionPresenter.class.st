Class {
	#name : 'RMDAtomicExpressionPresenter',
	#superclass : 'RMDExpressionPresenter',
	#instVars : [
		'label'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDAtomicExpressionPresenter >> expressionChanged [

	label label: expression printString.
	super expressionChanged
]

{ #category : 'initialization' }
RMDAtomicExpressionPresenter >> initializePresenters [

	super initializePresenters.
	label := self newLabel
		         label: '-';
		         yourself
]

{ #category : 'layouting' }
RMDAtomicExpressionPresenter >> layout [

	^ SpBoxLayout newHorizontal
		  add: label;
		  yourself
]
