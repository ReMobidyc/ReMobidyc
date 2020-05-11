Class {
	#name : #RMDExpressionTextInputPresenter,
	#superclass : #SpTextInputFieldPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#expression => SpObservableSlot',
		'#lastValidExpression => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDExpressionTextInputPresenter >> acceptExpression: aRMDExpression [
	expression := aRMDExpression.
	(aRMDExpression isKindOf: RMDExpressionNode)
		ifTrue: [ self beOk.
			lastValidExpression := aRMDExpression ]
		ifFalse: [ self beError ].
	self accept: aRMDExpression printString
]

{ #category : #api }
RMDExpressionTextInputPresenter >> expression [
	^ expression
]

{ #category : #api }
RMDExpressionTextInputPresenter >> expression: aRMDExpression [
	expression := aRMDExpression.
	(aRMDExpression isKindOf: RMDExpressionNode)
		ifTrue: [ self beOk.
			lastValidExpression := aRMDExpression ]
		ifFalse: [ self beError ].
	text := aRMDExpression printString
]

{ #category : #api }
RMDExpressionTextInputPresenter >> lastValidExpression [
	^ lastValidExpression
]

{ #category : #api }
RMDExpressionTextInputPresenter >> text: aString [
	aString
		asRMDExpressionDo: [ :node | 
			self beOk.
			expression := node.
			lastValidExpression := node ]
		ifError: [ self beError.
			expression := nil ].
	^ super text: aString
]

{ #category : #'api-events' }
RMDExpressionTextInputPresenter >> whenExpressionChangedDo: aBlock [
	self property: #expression whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDExpressionTextInputPresenter >> whenLastValidExpressionChangedDo: aBlock [
	self property: #lastValidExpression whenChangedDo: aBlock
]
