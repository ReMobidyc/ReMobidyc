Class {
	#name : 'RMDGuardedChoicePresenter',
	#superclass : 'RMDExpressionPresenter',
	#instVars : [
		'choicePresenters'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDGuardedChoicePresenter >> expressionChanged [

	choicePresenters := expression guardsAndChoices collect: [ :assoc |
		                    | guard choice |
		                    guard := assoc key.
		                    choice := assoc value.
		                    guard = true
			                    ifTrue: [ { choice asPresenter } ]
			                    ifFalse: [
				                    {
					                    choice asPresenter.
					                    (' if ' asPresenter displayBold: [ true ]).
					                    guard asPresenter.
					                    (',' asPresenter displayBold: [ true ]) } ] ].
	super expressionChanged
]

{ #category : 'initialization' }
RMDGuardedChoicePresenter >> initializePresenters [

	super initializePresenters.
	choicePresenters := Array new.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : 'layouting' }
RMDGuardedChoicePresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newVertical.
	newLayout borderWidth: 2.
	choicePresenters do: [ :presenters |
		| choice |
		choice := SpBoxLayout newHorizontal vAlignCenter.
		presenters do: [ :presenter | choice add: presenter expand: false ].
		newLayout add: choice expand: false ].
	^ newLayout
]
