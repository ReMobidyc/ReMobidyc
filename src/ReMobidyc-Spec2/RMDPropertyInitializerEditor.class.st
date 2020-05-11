Class {
	#name : #RMDPropertyInitializerEditor,
	#superclass : #RMDSyntaxNodeEditor,
	#instVars : [
		'identifierField',
		'expressionField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDPropertyInitializerEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: '     ' expand: false;
				add: #identifierField width: 100;
				add: ' = ' expand: false;
				add: #expressionField;
				yourself)
		height: self inputTextHeight
]

{ #category : #api }
RMDPropertyInitializerEditor >> disableIdentifier [
	identifierField disable
]

{ #category : #api }
RMDPropertyInitializerEditor >> enableIdentifier [
	identifierField enable
]

{ #category : #accessing }
RMDPropertyInitializerEditor >> expressionField [
	^ expressionField
]

{ #category : #api }
RMDPropertyInitializerEditor >> identifierEnabled [
	^ identifierField enabled
]

{ #category : #accessing }
RMDPropertyInitializerEditor >> identifierField [
	^ identifierField
]

{ #category : #initialization }
RMDPropertyInitializerEditor >> initializeWidgets [
	super initializeWidgets.
	identifierField := self newTextInput
		beText;
		autoAccept: true;
		whenTextIsAcceptedDo: [ node
				ifNotNil: [ node identifier: identifierField text asString trim ] ];
		yourself.
	expressionField := self newExpressionTextInput
		beText;
		autoAccept: true;
		whenLastValidExpressionChangedDo: [ :expr | node ifNotNil: [ node expression: expr ] ];
		yourself
]

{ #category : #accessing }
RMDPropertyInitializerEditor >> nodeChanged [
	self
		updateIdentifierField;
		updateExpressionField
]

{ #category : #updating }
RMDPropertyInitializerEditor >> updateExpressionField [
	expressionField text: node expression printString
]

{ #category : #updating }
RMDPropertyInitializerEditor >> updateIdentifierField [
	identifierField text: node identifier
]

{ #category : #'api-events' }
RMDPropertyInitializerEditor >> whenIdentifierEnabledChangedDo: aBlock [
	identifierField whenEnabledChangedDo: aBlock
]
