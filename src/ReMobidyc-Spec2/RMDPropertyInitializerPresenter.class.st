Class {
	#name : #RMDPropertyInitializerPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'identifierField',
		'expressionField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDPropertyInitializerPresenter class >> defaultSpec [

	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: '     ' expand: false;
				   add: #identifierField width: 100;
				   add: ' = ' expand: false;
				   add: #expressionField;
				   yourself)
		  height: self inputTextHeight
]

{ #category : #api }
RMDPropertyInitializerPresenter >> disableIdentifier [
	identifierField disable
]

{ #category : #api }
RMDPropertyInitializerPresenter >> enableIdentifier [
	identifierField enable
]

{ #category : #accessing }
RMDPropertyInitializerPresenter >> expressionField [
	^ expressionField
]

{ #category : #api }
RMDPropertyInitializerPresenter >> identifierEnabled [
	^ identifierField enabled
]

{ #category : #accessing }
RMDPropertyInitializerPresenter >> identifierField [
	^ identifierField
]

{ #category : #initialization }
RMDPropertyInitializerPresenter >> initializePresenters [
	super initializePresenters.
	identifierField := self newSyntaxNodeTextInput
		beIdentifier;
		autoAccept: true;
		whenLastValidSyntaxNodeChangedDo: [ node
				ifNotNil: [ identifierField text asString trim
						ifNotEmpty: [ :id | node identifier: id ] ] ];
		yourself.
	expressionField := self newSyntaxNodeTextInput
		beExpression;
		autoAccept: true;
		whenLastValidSyntaxNodeChangedDo: [ :expr | node ifNotNil: [ node expression: expr ] ];
		yourself
]

{ #category : #accessing }
RMDPropertyInitializerPresenter >> nodeChanged [
	self
		updateIdentifierField;
		updateExpressionField
]

{ #category : #accessing }
RMDPropertyInitializerPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #updating }
RMDPropertyInitializerPresenter >> updateExpressionField [
	expressionField text: node expression printString
]

{ #category : #updating }
RMDPropertyInitializerPresenter >> updateIdentifierField [
	identifierField text: node identifier
]

{ #category : #'api-events' }
RMDPropertyInitializerPresenter >> whenIdentifierEnabledChangedDo: aBlock [
	identifierField whenEnabledChangedDo: aBlock
]
