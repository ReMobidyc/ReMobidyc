Class {
	#name : #RMDAttributeInitializerPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'identifierField',
		'expressionField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDAttributeInitializerPresenter class >> defaultLayout [

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
RMDAttributeInitializerPresenter >> disableIdentifier [
	identifierField disable
]

{ #category : #api }
RMDAttributeInitializerPresenter >> enableIdentifier [
	identifierField enable
]

{ #category : #accessing }
RMDAttributeInitializerPresenter >> expressionField [
	^ expressionField
]

{ #category : #api }
RMDAttributeInitializerPresenter >> identifierEnabled [
	^ identifierField enabled
]

{ #category : #accessing }
RMDAttributeInitializerPresenter >> identifierField [
	^ identifierField
]

{ #category : #initialization }
RMDAttributeInitializerPresenter >> initializePresenters [
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
RMDAttributeInitializerPresenter >> nodeChanged [
	self
		updateIdentifierField;
		updateExpressionField
]

{ #category : #accessing }
RMDAttributeInitializerPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #updating }
RMDAttributeInitializerPresenter >> updateExpressionField [
	expressionField text: node expression printString
]

{ #category : #updating }
RMDAttributeInitializerPresenter >> updateIdentifierField [
	identifierField text: node identifier
]

{ #category : #'api-events' }
RMDAttributeInitializerPresenter >> whenIdentifierEnabledChangedDo: aBlock [
	identifierField whenEnabledChangedDo: aBlock
]
