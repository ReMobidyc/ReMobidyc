Class {
	#name : #RMDAtomicDirectivePresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'directiveLabel'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDAtomicDirectivePresenter >> expressionChanged [

	directiveLabel label: expression printString.
	super expressionChanged
]

{ #category : #initialization }
RMDAtomicDirectivePresenter >> initializePresenters [

	super initializePresenters.
	directiveLabel := self newLabel
		                  displayBold: [ true ];
		                  label: '-';
		                  yourself
]

{ #category : #layouting }
RMDAtomicDirectivePresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newHorizontal.
	newLayout add: directiveLabel expand: false.
	^ newLayout
]
