Class {
	#name : #RMDAnimatInitializerPresenter,
	#superclass : #RMDAgentInitializerPresenter,
	#instVars : [
		'populationField',
		'animatField',
		'removeButton',
		'removeButtonAction'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDAnimatInitializerPresenter class >> defaultLayout [

	<spec>
	^ super defaultSpec
		  add: (SpBoxLayout newHorizontal
				   add: #populationField expand: false;
				   add: ' ' expand: false;
				   add: #animatField width: 300;
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
		               whenLastValidTextChangedDo: [ :text | 
			               node animat: text asString ];
		               yourself.
	removeButton := self newButton
		                label: '';
		                icon: self removeIcon;
		                color: Color white;
		                borderWidth: 0;
		                action: [ removeButtonAction cull: node ];
		                yourself.
	removeButtonAction := [ :n |  ].
	self color: Color white
]

{ #category : #layouting }
RMDAnimatInitializerPresenter >> newLayout [

	| newLayout |
	newLayout := SpBoxLayout newVertical
		             borderWidth: 0;
		             spacing: 0;
		             add: (SpBoxLayout newHorizontal
				              vAlignCenter;
				              add: populationField expand: false;
				              add: ' ' asPresenter expand: false;
				              add: animatField width: 200;
				              add: ' with' asPresenter expand: false;
				              yourself)
		             height: self class inputTextHeight;
		             yourself.
	self attributesAndUtilitiesToNewLayout: newLayout.
	newLayout add:
		(SpBoxLayout newHorizontal add: removeButton width: 30).
	^ newLayout
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

	^ node attributeInitializers size + 1 * self class inputTextHeight
	  + self class buttonHeight
]

{ #category : #api }
RMDAnimatInitializerPresenter >> removeButtonAction [
	^ removeButtonAction
]

{ #category : #api }
RMDAnimatInitializerPresenter >> removeButtonAction: aBlock [

	removeButtonAction := aBlock
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
