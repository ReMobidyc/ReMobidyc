Class {
	#name : 'RMDConditionPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'condition'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'instance creation' }
RMDConditionPresenter class >> on: aRMDConditionNode [

	^ self new
		  condition: aRMDConditionNode;
		  yourself
]

{ #category : 'accessing' }
RMDConditionPresenter >> borderColor [

	^ Color lightGray
]

{ #category : 'accessing' }
RMDConditionPresenter >> condition [

	^ condition
]

{ #category : 'accessing' }
RMDConditionPresenter >> condition: aRMDConditionNode [

	condition := aRMDConditionNode.
	self conditionChanged
]

{ #category : 'accessing' }
RMDConditionPresenter >> conditionChanged [

	self layout: self layout
]

{ #category : 'initialization' }
RMDConditionPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter addButton: 'Ok' do: [ :presenter |
		presenter triggerOkAction.
		presenter close ]
]

{ #category : 'initialization' }
RMDConditionPresenter >> initializePresenters [

	super initializePresenters.
	self whenBuiltDo: [ self withWidgetDo: [ :w | w color: Color white ] ]
]

{ #category : 'initialization' }
RMDConditionPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 600 @ 400
]
