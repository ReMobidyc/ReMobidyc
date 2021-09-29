Class {
	#name : #RMDAnimatInitializerPresenter,
	#superclass : #RMDSpeciesInitializerPresenter,
	#instVars : [
		'populationField',
		'animatField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAnimatInitializerPresenter class >> defaultSpec [
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
RMDAnimatInitializerPresenter >> animatEnabled: aBoolean [
	animatField enabled: aBoolean = true
]

{ #category : #accessing }
RMDAnimatInitializerPresenter >> animatField [
	^ animatField
]

{ #category : #api }
RMDAnimatInitializerPresenter >> disableAnimat [
	animatField disable
]

{ #category : #api }
RMDAnimatInitializerPresenter >> enableAnimat [
	animatField enable
]

{ #category : #initialization }
RMDAnimatInitializerPresenter >> initializePresenters [
	super initializePresenters.
	populationField := self newNumberInput
		beInteger;
		whenLastValidNumberChangedDo: [ :int | 
			| nat |
			nat := int max: 1.
			node ifNotNil: [ node population: nat ].
			populationField text: nat printString ];
		yourself.
	animatField := self newAnimatInput
		whenLastValidTextChangedDo: [ :text | node animat: text asString ];
		yourself
]

{ #category : #accessing }
RMDAnimatInitializerPresenter >> nodeChanged [
	super nodeChanged.
	self
		updatePopulationField;
		updateAnimatField
]

{ #category : #accessing }
RMDAnimatInitializerPresenter >> populationField [
	^ populationField
]

{ #category : #accessing }
RMDAnimatInitializerPresenter >> preferredHeight [
	^ (node propertyInitializers size + 1) * self class inputTextHeight
]

{ #category : #updating }
RMDAnimatInitializerPresenter >> updateAnimatField [
	node ifNotNil: [ animatField text: node animat ]
]

{ #category : #updating }
RMDAnimatInitializerPresenter >> updatePopulationField [
	node ifNotNil: [ populationField text: node population printString ]
]

{ #category : #'api-events' }
RMDAnimatInitializerPresenter >> whenAnimatEnabledChangedDo: aBlock [
	animatField whenEnabledChangedDo: aBlock
]
