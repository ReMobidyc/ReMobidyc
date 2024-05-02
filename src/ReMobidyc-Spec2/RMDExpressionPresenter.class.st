Class {
	#name : 'RMDExpressionPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'expression'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'instance creation' }
RMDExpressionPresenter class >> on: aRMDExpressionNode [

	^ self new
		  expression: aRMDExpressionNode;
		  yourself
]

{ #category : 'accessing' }
RMDExpressionPresenter >> borderColor [

	^ Color lightGray
]

{ #category : 'accessing' }
RMDExpressionPresenter >> expression [

	^ expression
]

{ #category : 'accessing' }
RMDExpressionPresenter >> expression: aRMDExpressionNode [

	expression := aRMDExpressionNode.
	self expressionChanged
]

{ #category : 'accessing' }
RMDExpressionPresenter >> expressionChanged [

	self layout: self layout
]

{ #category : 'initialization' }
RMDExpressionPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter addButton: 'Ok' do: [ :presenter |
		presenter triggerOkAction.
		presenter close ]
]

{ #category : 'initialization' }
RMDExpressionPresenter >> initializePresenters [

	super initializePresenters.
	self whenBuiltDo: [ self withWidgetDo: [ :w | w color: Color white ] ]
]

{ #category : 'initialization' }
RMDExpressionPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 600 @ 400
]
