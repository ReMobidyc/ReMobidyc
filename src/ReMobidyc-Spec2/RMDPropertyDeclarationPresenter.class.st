Class {
	#name : #RMDPropertyDeclarationPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'identifierField',
		'unitField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDPropertyDeclarationPresenter class >> defaultSpec [
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
RMDPropertyDeclarationPresenter >> initializePresenters [
	super initializePresenters.
	identifierField := self newTextInput
		beText;
		autoAccept: true;
		placeholder: 'identifier';
		whenTextIsAcceptedDo: [ node
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
RMDPropertyDeclarationPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 400 @ (self class buttonHeight * 3.5)
]

{ #category : #accessing }
RMDPropertyDeclarationPresenter >> nodeChanged [
	self
		updateIdentifier;
		updateUnit
]

{ #category : #accessing }
RMDPropertyDeclarationPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #updating }
RMDPropertyDeclarationPresenter >> updateIdentifier [
	node ifNotNil: [ identifierField text: node identifier ]
]

{ #category : #updating }
RMDPropertyDeclarationPresenter >> updateUnit [
	node
		ifNotNil: [ | unit |
			unit := node unit.
			unitField
				text:
					(unit hasDimension
						ifTrue: [ unit printString ]
						ifFalse: [ '' ]) ]
]
