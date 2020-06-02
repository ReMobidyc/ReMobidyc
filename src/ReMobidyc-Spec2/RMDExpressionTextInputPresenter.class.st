Class {
	#name : #RMDExpressionTextInputPresenter,
	#superclass : #SpTextInputFieldPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#expression => SpObservableSlot',
		'#lastValidExpression => SpObservableSlot',
		'#isLiteralOnly => SpObservableSlot',
		'#parser'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDExpressionTextInputPresenter >> acceptExpression: aRMDExpression [
	expression := aRMDExpression.
	((aRMDExpression isKindOf: RMDExpressionNode)
		and: [ isLiteralOnly not or: [ aRMDExpression isLiteralNode ] ])
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
	((aRMDExpression isKindOf: RMDExpressionNode)
		and: [ isLiteralOnly not or: [ aRMDExpression isLiteralNode ] ])
		ifTrue: [ self beOk.
			lastValidExpression := aRMDExpression ]
		ifFalse: [ self beError ].
	text := aRMDExpression printString
]

{ #category : #initialization }
RMDExpressionTextInputPresenter >> initialize [
	super initialize.
	isLiteralOnly := false.
	parser := RMDGrammar new expression
]

{ #category : #api }
RMDExpressionTextInputPresenter >> isLiteralOnly [
	^ isLiteralOnly
]

{ #category : #api }
RMDExpressionTextInputPresenter >> isLiteralOnly: aBoolean [
	isLiteralOnly := aBoolean = true
]

{ #category : #api }
RMDExpressionTextInputPresenter >> lastValidExpression [
	^ lastValidExpression
]

{ #category : #api }
RMDExpressionTextInputPresenter >> text: aString [
	| newText node |
	newText := aString asText.
	node := parser end parse: aString asString.
	node isPetit2Failure
		ifTrue: [ | node2 |
			node2 := parser parse: aString asString.
			node2 isPetit2Failure
				ifTrue: [ node := node2 ].
			newText makeColor: Color red from: node position to: aString size.
			self beError.
			expression := nil ]
		ifFalse: [ (isLiteralOnly and: [ node isLiteralNode not ])
				ifTrue: [ self beError.
					expression := nil ]
				ifFalse: [ self beOk.
					expression := node.
					lastValidExpression := node ] ].
	^ super text: newText
]

{ #category : #'api-events' }
RMDExpressionTextInputPresenter >> whenExpressionChangedDo: aBlock [
	self property: #expression whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDExpressionTextInputPresenter >> whenIsLiteralOnlyChangedDo: aBlock [
	self property: #lastValidExpression whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDExpressionTextInputPresenter >> whenLastValidExpressionChangedDo: aBlock [
	self property: #lastValidExpression whenChangedDo: aBlock
]
