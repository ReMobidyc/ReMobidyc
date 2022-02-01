Class {
	#name : #RMDAttributeDeclarationPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'identifierField',
		'unitField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAttributeDeclarationPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: '     ' expand: false;
				add: #identifierField width: 180;
				add: ' [' expand: false;
				add: #unitField width: 50;
				add: '] ' expand: false;
				yourself)
		height: self inputTextHeight
]

{ #category : #initialization }
RMDAttributeDeclarationPresenter >> initializePresenters [
	super initializePresenters.
	identifierField := self newTextInput
		beText;
		autoAccept: true;
		placeholder: 'identifier';
		whenTextChangedDo: [ node
				ifNotNil: [ node identifier: identifierField text asString trim ] ];
		yourself.
	unitField := self newValidatedTextInput
		placeholder: 'unit';
		validation: [ :text | 
			(RMDGrammar new unit optional end parse: text asString trim)
				isPetit2Failure not ];
		autoAccept: true;
		whenLastValidTextChangedDo: [ :text | 
			node
				unit:
					((RMDGrammar new unit optional end parse: text asString trim)
						ifNil: [ RMDUnit noDimension ]) ];
		yourself.
	self
		focusOrder:
			{identifierField.
			unitField} asOrderedCollection
]

{ #category : #initialization }
RMDAttributeDeclarationPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 400 @ (self class buttonHeight * 3.5)
]

{ #category : #accessing }
RMDAttributeDeclarationPresenter >> nodeChanged [
	self
		updateIdentifier;
		updateUnit
]

{ #category : #accessing }
RMDAttributeDeclarationPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #updating }
RMDAttributeDeclarationPresenter >> updateIdentifier [
	node ifNotNil: [ identifierField text: node identifier ]
]

{ #category : #updating }
RMDAttributeDeclarationPresenter >> updateUnit [
	node
		ifNotNil: [ | unit |
			unit := node unit.
			unitField
				text:
					(unit hasDimension
						ifTrue: [ unit printString ]
						ifFalse: [ '' ]) ]
]
