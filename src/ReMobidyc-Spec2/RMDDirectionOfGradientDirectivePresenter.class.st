Class {
	#name : 'RMDDirectionOfGradientDirectivePresenter',
	#superclass : 'RMDExpressionPresenter',
	#instVars : [
		'directiveLabel',
		'attributeLabel'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDDirectionOfGradientDirectivePresenter >> expressionChanged [

	attributeLabel label: expression patchAttributeVariable identifier.
	super expressionChanged
]

{ #category : 'initialization' }
RMDDirectionOfGradientDirectivePresenter >> initializePresenters [

	super initializePresenters.
	directiveLabel := self newLabel
		                  displayBold: [ true ];
		                  label: 'direction neighbor''s ';
		                  yourself.
	attributeLabel := self newLabel
		                  label: '-';
		                  yourself
]

{ #category : 'layouting' }
RMDDirectionOfGradientDirectivePresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newHorizontal.
	newLayout add: directiveLabel expand: false.
	newLayout add: attributeLabel expand: false.
	^ newLayout
]
