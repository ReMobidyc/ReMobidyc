Class {
	#name : 'RMDListEditPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'list',
		'addButton',
		'removeButton'
	],
	#category : 'ReMobidyc-Spec2-Widgets',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Widgets'
}

{ #category : 'layout' }
RMDListEditPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #list;
		  add: (SpBoxLayout newHorizontal
				   add: #addButton width: self buttonHeight;
				   add: #removeButton width: self buttonHeight)
		  expand: false;
		  yourself
]

{ #category : 'api' }
RMDListEditPresenter >> addAction: aBlock [

	addButton action: aBlock
]

{ #category : 'accessing' }
RMDListEditPresenter >> addButton [

	^ addButton
]

{ #category : 'api' }
RMDListEditPresenter >> display: aBlock [

	list display: aBlock
]

{ #category : 'initialization' }
RMDListEditPresenter >> initializePresenters [

	super initializePresenters.
	list := self newList
		        whenSelectedItemChangedDo: [ self selectionChanged ];
		        yourself.
	addButton := self newButton
		             icon: self addIcon;
		             yourself.
	removeButton := self newButton
		                icon: self removeIcon;
		                disable;
		                yourself
]

{ #category : 'api' }
RMDListEditPresenter >> items [

	^ list items
]

{ #category : 'api' }
RMDListEditPresenter >> items: aCollection [

	list items: aCollection
]

{ #category : 'accessing' }
RMDListEditPresenter >> list [

	^ list
]

{ #category : 'api' }
RMDListEditPresenter >> removeAction: aBlock [

	removeButton action: aBlock
]

{ #category : 'accessing' }
RMDListEditPresenter >> removeButton [

	^ removeButton
]

{ #category : 'accessing' }
RMDListEditPresenter >> selectedItem [

	^ list selectedItem
]

{ #category : 'updating' }
RMDListEditPresenter >> selectionChanged [

	self updateButtons
]

{ #category : 'updating' }
RMDListEditPresenter >> updateButtons [

	list selectedItem
		ifNotNil: [ removeButton enable ]
		ifNil: [ removeButton disable ]
]
