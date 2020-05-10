Class {
	#name : #RMDPropertyInitializerEditor,
	#superclass : #RMDSyntaxNodeEditor,
	#instVars : [
		'identifierField',
		'expressionField'
	],
	#category : #'ReMobidyc-Spec2'
}

{ #category : #specs }
RMDPropertyInitializerEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newHorizontal
		add: '' width: 20;
		add: #identifierField width: 100;
		add: (SpBoxLayout newVertical addLast: ' = ' expand: false)
			width: 16;
		add: #expressionField;
		yourself
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
