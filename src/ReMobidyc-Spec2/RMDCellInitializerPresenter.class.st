Class {
	#name : #RMDCellInitializerPresenter,
	#superclass : #RMDSpeciesInitializerPresenter,
	#instVars : [
		'xDivisionsField',
		'yDivisionsField',
		'sizeField',
		'sizeUnitDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDCellInitializerPresenter class >> defaultSpec [

	<spec>
	^ super defaultSpec
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: #xDivisionsField expand: false;
				   add: ' x ' expand: false;
				   add: #yDivisionsField expand: false;
				   add: ' of ' expand: false;
				   add: #sizeField width: 80;
				   add: #sizeUnitDropList width: 80;
				   add: ' Cell with' expand: false;
				   yourself)
		  height: self inputTextHeight;
		  yourself
]

{ #category : #initialization }
RMDCellInitializerPresenter >> initializePresenters [
	super initializePresenters.
	xDivisionsField := self newNumberInput
		beInteger;
		whenLastValidNumberChangedDo: [ :int | 
			| nat |
			nat := int max: 1.
			xDivisionsField text: nat printString.
			node ifNotNil: [ node xDivisions: nat ] ];
		yourself.
	yDivisionsField := self newNumberInput
		beInteger;
		whenLastValidNumberChangedDo: [ :int | 
			| nat |
			nat := int max: 1.
			yDivisionsField text: nat printString.
			node ifNotNil: [ node yDivisions: nat ] ];
		yourself.
	sizeField := self newNumberInput
		beFloat;
		whenLastValidNumberChangedDo:
				[ :val | node ifNotNil: [ node size literal: val printString ] ];
		yourself.
	sizeUnitDropList := self newDropList
		items:
			{(RMDUnit at: 'm').
			(RMDUnit at: 'km').
			(RMDUnit at: 'mile').
			(RMDUnit at: 'yd').
			((RMDUnit at: 'm') ** 2).
			((RMDUnit at: 'km') ** 2).
			(RMDUnit at: 'ac').
			(RMDUnit at: 'a').
			(RMDUnit at: 'ha')};
		selectIndex: 1;
		whenSelectedItemChangedDo: [ :newUnit | 
			node
				ifNotNil: [ | numeric |
					numeric := node length.
					newUnit siUnit = (RMDUnit at: 'm')
						ifFalse: [ numeric := numeric squared ].
					node
						size:
							(RMDLiteralNode
								literal: (newUnit fromSI: numeric) printString
								unit: newUnit).
					self updateSizeField ] ];
		yourself
]

{ #category : #'instance creation' }
RMDCellInitializerPresenter >> newLayout [

	| newLayout |
	newLayout := SpBoxLayout newVertical
		             borderWidth: 0;
		             spacing: 0;
		             add: (SpBoxLayout newHorizontal
				              vAlignCenter;
				              add: xDivisionsField expand: false;
				              add: ' x ' asPresenter expand: false;
				              add: yDivisionsField expand: false;
				              add: ' of ' asPresenter expand: false;
				              add: sizeField width: 80;
				              add: sizeUnitDropList width: 80;
				              add: ' Cell with' asPresenter expand: false;
				              yourself)
		             height: self class inputTextHeight;
		             yourself.

	node ifNotNil: [ 
		node propertyInitializers do: [ :initializer | 
			newLayout
				add: (initializer asPresenter
						 disableIdentifier;
						 yourself)
				expand: false ] ].
	^ newLayout
]

{ #category : #accessing }
RMDCellInitializerPresenter >> nodeChanged [
	super nodeChanged.
	self
		updateXDivisionsField;
		updateYDivisionsField;
		updateSizeField;
		updateSizeUnitField
]

{ #category : #accessing }
RMDCellInitializerPresenter >> preferredHeight [
	^ (node propertyInitializers size + 1) * self class inputTextHeight
]

{ #category : #accessing }
RMDCellInitializerPresenter >> sizeField [
	^ sizeField
]

{ #category : #accessing }
RMDCellInitializerPresenter >> sizeUnitDropList [
	^ sizeUnitDropList
]

{ #category : #updating }
RMDCellInitializerPresenter >> updateSizeField [
	node ifNotNil: [ sizeField text: node size literal ]
]

{ #category : #updating }
RMDCellInitializerPresenter >> updateSizeUnitField [
	node ifNotNil: [ sizeUnitDropList selectItem: node size unit ]
]

{ #category : #updating }
RMDCellInitializerPresenter >> updateXDivisionsField [
	node ifNotNil: [ xDivisionsField text: node xDivisions printString ]
]

{ #category : #updating }
RMDCellInitializerPresenter >> updateYDivisionsField [
	node ifNotNil: [ yDivisionsField text: node yDivisions printString ]
]

{ #category : #accessing }
RMDCellInitializerPresenter >> xDivisionsField [
	^ xDivisionsField
]

{ #category : #accessing }
RMDCellInitializerPresenter >> yDivisionsField [
	^ yDivisionsField
]
