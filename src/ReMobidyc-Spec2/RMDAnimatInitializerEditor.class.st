Class {
	#name : #RMDAnimatInitializerEditor,
	#superclass : #RMDSpeciesInitializerEditor,
	#instVars : [
		'populationField',
		'animatField'
	],
	#category : #'ReMobidyc-Spec2'
}

{ #category : #specs }
RMDAnimatInitializerEditor class >> defaultSpec [
	<spec>
	^ super defaultSpec
		add:
			(SpBoxLayout newHorizontal
				add: #populationField expand: false;
				add: ' ' expand: false;
				add: #animatField expand: false;
				add:
					(SpBoxLayout newVertical
						addLast: ' with' expand: false;
						yourself)
					width: 32;
				yourself)
			expand: false;
		yourself
]

{ #category : #accessing }
RMDAnimatInitializerEditor >> animatField [
	^ animatField
]

{ #category : #initialization }
RMDAnimatInitializerEditor >> initializeWidgets [
	super initializeWidgets.
	populationField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenTextIsAcceptedDo: [ :text | 
			self
				fromString: text asString trim
				ifIntegerDo: [ :int | 
					| nat |
					nat := int max: 1.
					node ifNotNil: [ node population: nat ].
					populationField
						text: nat printString;
						color: self okColor ]
				ifError: [ populationField color: self errorColor ] ];
		yourself.
	animatField := self newTextInput
		autoAccept: true;
		whenTextIsAcceptedDo: [ :text | 
			text trimmed
				ifEmpty: [ animatField color: self errorColor ]
				ifNotEmpty: [ :name | 
					(name contains: #isSeparator)
						ifTrue: [ animatField color: self errorColor ]
						ifFalse: [ node animat: name ] ] ];
		yourself
]

{ #category : #accessing }
RMDAnimatInitializerEditor >> nodeChanged [
	super nodeChanged.
	self
		updatePopulationField;
		updateAnimatField
]

{ #category : #accessing }
RMDAnimatInitializerEditor >> populationField [
	^ populationField
]

{ #category : #updating }
RMDAnimatInitializerEditor >> updateAnimatField [
	node ifNotNil: [ animatField text: node animat ]
]

{ #category : #updating }
RMDAnimatInitializerEditor >> updatePopulationField [
	node ifNotNil: [ populationField text: node population printString ]
]
