Class {
	#name : 'RMDReorderingListPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'list',
		'moveUpButton',
		'moveDownButton'
	],
	#category : 'ReMobidyc-Spec2-Components',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Components'
}

{ #category : 'utilities' }
RMDReorderingListPresenter class >> withAll: anArray display: aBlock onAccept: acceptBlock [

	| list |
	list := self new.
	list
		items: anArray;
		display: aBlock.
	list asModalWindow
		okAction: [ acceptBlock cull: list items cull: list ];
		open
]

{ #category : 'layout' }
RMDReorderingListPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: list expand: true;
		  add: (SpBoxLayout newHorizontal
				   add: moveUpButton width: self class buttonHeight;
				   add: moveDownButton width: self class buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'api' }
RMDReorderingListPresenter >> display [

	^ list display
]

{ #category : 'api' }
RMDReorderingListPresenter >> display: aBlock [

	list display: aBlock
]

{ #category : 'initialization' }
RMDReorderingListPresenter >> initializePresenters [

	list := self newList
		        beSingleSelection;
		        whenSelectedItemChangedDo: [ self selectedItemChanged ];
		        yourself.
	moveUpButton := self newButton
		                icon: self upIcon;
		                action: [ self moveUp ];
		                yourself.
	moveDownButton := self newButton
		                  icon: self downIcon;
		                  action: [ self moveDown ];
		                  yourself
]

{ #category : 'api' }
RMDReorderingListPresenter >> items [

	^ list items
]

{ #category : 'api' }
RMDReorderingListPresenter >> items: anArray [

	list items: anArray
]

{ #category : 'operations' }
RMDReorderingListPresenter >> moveDown [

	| index items |
	index := list selection selectedIndex.
	items := list items.
	(index between: 1 and: items size - 1) ifTrue: [
		| value |
		value := items at: index.
		items at: index put: (items at: index + 1).
		items at: index + 1 put: value.
		list
			items: items;
			selectIndex: index + 1 ]
]

{ #category : 'operations' }
RMDReorderingListPresenter >> moveUp [

	| index items |
	index := list selection selectedIndex.
	items := list items.
	(index between: 2 and: items size) ifTrue: [
		| value |
		value := items at: index.
		items at: index put: (items at: index - 1).
		items at: index - 1 put: value.
		list
			items: items;
			selectIndex: index - 1 ]
]

{ #category : 'updating' }
RMDReorderingListPresenter >> selectedItemChanged [

	self updateButtons
]

{ #category : 'updating' }
RMDReorderingListPresenter >> updateButtons [

	| index size |
	index := list selection selectedIndex.
	size := list items size.
	moveUpButton enabled: (index between: 2 and: size).
	moveDownButton enabled: (index between: 1 and: size - 1)
]
