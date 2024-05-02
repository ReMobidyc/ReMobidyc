Class {
	#name : 'RMDBinaryCombinatorPresenter',
	#superclass : 'RMDConditionPresenter',
	#instVars : [
		'conditionPresenters'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'accessing' }
RMDBinaryCombinatorPresenter >> conditionChanged [

	conditionPresenters := condition conditions collect: #asPresenter.
	super conditionChanged
]

{ #category : 'initialization' }
RMDBinaryCombinatorPresenter >> initializePresenters [

	super initializePresenters.
	conditionPresenters := {  }.
	self whenBuiltDo: [
		self withAdapterDo: [ :a |
			a widgetDo: [ :w |
				w
					borderColor: self borderColor;
					borderWidth: 2 ] ] ]
]

{ #category : 'accessing' }
RMDBinaryCombinatorPresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newVertical.
	newLayout borderWidth: 2.
	newLayout add: conditionPresenters first expand: false.
	conditionPresenters allButFirst do: [ :presenter |
		newLayout add: (SpBoxLayout newHorizontal
				 vAlignCenter;
				 add: (condition operator asPresenter displayBold: [ true ])
				 expand: false;
				 add: ' ' asPresenter expand: false;
				 add: presenter expand: false) ].
	^ newLayout
]
