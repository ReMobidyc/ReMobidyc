Class {
	#name : 'RMDAddSpeciesEditor',
	#superclass : 'RMDPresenter',
	#instVars : [
		'speciesField',
		'stageField',
		'action',
		'createButton'
	],
	#category : 'ReMobidyc-Spec2-Components',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Components'
}

{ #category : 'layout' }
RMDAddSpeciesEditor class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: 'New species name' expand: false;
				   add: #speciesField
				   expand: true
				   fill: true
				   padding: 20;
				   add: 'stage name' expand: false;
				   add: #stageField
				   expand: true
				   fill: true
				   padding: 20;
				   add: #createButton expand: false;
				   yourself)
		  expand: false
		  fill: true
		  padding: 10;
		  yourself
]

{ #category : 'accessing' }
RMDAddSpeciesEditor >> action [

	^ action
]

{ #category : 'accessing' }
RMDAddSpeciesEditor >> action: aBlock [

	action := aBlock
]

{ #category : 'api - focus' }
RMDAddSpeciesEditor >> defaultKeyboardFocus [

	^ speciesField
]

{ #category : 'initialization' }
RMDAddSpeciesEditor >> initializePresenters [

	super initializePresenters.
	speciesField := self newAnimatInput.
	stageField := self newAnimatInput.
	createButton := self newButton
		                icon: Smalltalk ui icons add;
		                action: [ 
			                action
				                value: speciesField text asString trim
				                value: stageField text asString trim ];
		                help:
			                'Add a new animat that represent the given stage of the given species'
				                yourself.
	action := [ :text |  ].
	self focusOrder: { 
			speciesField.
			stageField.
			createButton } asOrderedCollection
]

{ #category : 'enumerating' }
RMDAddSpeciesEditor >> whenActionChangedDo: aBlock [

	self property: #action whenChangedDo: aBlock
]
