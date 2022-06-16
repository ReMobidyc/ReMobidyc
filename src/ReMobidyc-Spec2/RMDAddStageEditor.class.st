Class {
	#name : #RMDAddStageEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'nameField',
		'action',
		'createButton'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDAddStageEditor class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: 'New stage name' expand: false;
				   add: #nameField
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

{ #category : #accessing }
RMDAddStageEditor >> action [

	^ action
]

{ #category : #accessing }
RMDAddStageEditor >> action: aBlock [

	action := aBlock
]

{ #category : #'api - focus' }
RMDAddStageEditor >> defaultKeyboardFocus [

	^ nameField
]

{ #category : #initialization }
RMDAddStageEditor >> initializePresenters [

	super initializePresenters.
	nameField := self newAnimatInput.
	createButton := self newButton
		                icon: Smalltalk ui icons add;
		                action: [ 
			                action value: nameField text asString trim ];
		                help: 'Add a new stage of this species';
		                yourself.
	action := [ :text |  ].
	self focusOrder: { 
			nameField.
			createButton } asOrderedCollection
]

{ #category : #enumerating }
RMDAddStageEditor >> whenActionChangedDo: aBlock [

	self property: #action whenChangedDo: aBlock
]
