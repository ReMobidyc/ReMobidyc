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

{ #category : #updating }
RMDAnimatInitializerEditor >> updateAnimatField [
	node ifNotNil: [ animatField text: node animat ]
]

{ #category : #updating }
RMDAnimatInitializerEditor >> updatePopulationField [
	node ifNotNil: [ populationField text: node population printString ]
]
