Class {
	#name : 'RMDBinaryRelationPresenter',
	#superclass : 'RMDConditionPresenter',
	#instVars : [
		'expressionPresenters'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDBinaryRelationPresenter >> conditionChanged [

	expressionPresenters := condition expressions collect: #asPresenter.
	super conditionChanged
]

{ #category : 'initialization' }
RMDBinaryRelationPresenter >> initializePresenters [

	super initializePresenters.
	expressionPresenters := {  }.
	self whenBuiltDo: [
		self withWidgetDo: [ :w |
			w
				borderColor: self borderColor;
				borderWidth: 2 ] ]
]

{ #category : 'accessing' }
RMDBinaryRelationPresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newHorizontal.
	newLayout
		vAlignCenter;
		borderWidth: 2.
	expressionPresenters
		do: [ :presenter | newLayout add: presenter expand: false ]
		separatedBy: [
			newLayout
				add:
				((' ' , condition operator , ' ') asPresenter displayBold: [ true ])
				expand: false ].
	^ newLayout
]
