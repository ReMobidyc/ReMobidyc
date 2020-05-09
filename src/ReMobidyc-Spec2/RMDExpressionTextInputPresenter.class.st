Class {
	#name : #RMDExpressionTextInputPresenter,
	#superclass : #SpTextInputFieldPresenter,
	#instVars : [
		'#expression => SpObservableSlot',
		'#lastValidExpression => SpObservableSlot',
		'#parseFailureColor => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2'
}

{ #category : #accessing }
RMDExpressionTextInputPresenter >> acceptExpression: aRMDExpression [
	expression := aRMDExpression.
	(aRMDExpression isKindOf: RMDExpressionNode)
		ifTrue: [ self beOk.
			lastValidExpression := aRMDExpression ]
		ifFalse: [ self beParseFailure ].
	self accept: aRMDExpression printString
]

{ #category : #private }
RMDExpressionTextInputPresenter >> beOk [
	self color: self theme backgroundColor
]

{ #category : #private }
RMDExpressionTextInputPresenter >> beParseFailure [
	self color: parseFailureColor
]

{ #category : #accessing }
RMDExpressionTextInputPresenter >> expression [
	^ expression
]

{ #category : #accessing }
RMDExpressionTextInputPresenter >> expression: aRMDExpression [
	expression := aRMDExpression.
	(aRMDExpression isKindOf: RMDExpressionNode)
		ifTrue: [ self beOk.
			lastValidExpression := aRMDExpression ]
		ifFalse: [ self beParseFailure ].
	text := aRMDExpression printString
]

{ #category : #initialization }
RMDExpressionTextInputPresenter >> initialize [
	super initialize.
	parseFailureColor := self theme backgroundColor mixed: 0.9 with: Color red
]

{ #category : #accessing }
RMDExpressionTextInputPresenter >> lastValidExpression [
	^ lastValidExpression
]

{ #category : #accessing }
RMDExpressionTextInputPresenter >> text: aString [
	aString
		asRMDExpressionDo: [ :node | 
			self beOk.
			expression := node.
			lastValidExpression := node ]
		ifError: [ self beParseFailure.
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
