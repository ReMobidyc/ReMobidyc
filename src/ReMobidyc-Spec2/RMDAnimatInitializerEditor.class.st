Class {
	#name : #RMDAnimatInitializerEditor,
	#superclass : #RMDSpeciesInitializerEditor,
	#instVars : [
		'populationField',
		'animatField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
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
				add: ' with' expand: false;
				yourself)
			height: self inputTextHeight;
		yourself
]

{ #category : #api }
RMDAnimatInitializerEditor >> animatEnabled: aBoolean [
	animatField enabled: aBoolean = true
]

{ #category : #accessing }
RMDAnimatInitializerEditor >> animatField [
	^ animatField
]

{ #category : #api }
RMDAnimatInitializerEditor >> disableAnimat [
	animatField disable
]

{ #category : #api }
RMDAnimatInitializerEditor >> enableAnimat [
	animatField enable
]

{ #category : #initialization }
RMDAnimatInitializerEditor >> initializeWidgets [
	super initializeWidgets.
	populationField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :int | 
			| nat |
			nat := int max: 1.
			node ifNotNil: [ node population: nat ].
			populationField text: nat printString ];
		yourself.
	animatField := self newAnimatInput
		autoAccept: true;
		whenLastValidTextChangedDo: [ :text | node animat: text asString ];
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

{ #category : #accessing }
RMDAnimatInitializerEditor >> preferredHeight [
	^ (node propertyInitializers size + 1) * self class inputTextHeight
]

{ #category : #updating }
RMDAnimatInitializerEditor >> updateAnimatField [
	node ifNotNil: [ animatField text: node animat ]
]

{ #category : #updating }
RMDAnimatInitializerEditor >> updatePopulationField [
	node ifNotNil: [ populationField text: node population printString ]
]

{ #category : #'api-events' }
RMDAnimatInitializerEditor >> whenAnimatEnabledChangedDo: aBlock [
	animatField whenEnabledChangedDo: aBlock
]
