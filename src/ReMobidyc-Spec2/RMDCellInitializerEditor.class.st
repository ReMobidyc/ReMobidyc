Class {
	#name : #RMDCellInitializerEditor,
	#superclass : #RMDSpeciesInitializerEditor,
	#instVars : [
		'xDivisionsField',
		'yDivisionsField',
		'sizeField',
		'sizeUnitDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDCellInitializerEditor class >> defaultSpec [
	<spec>
	^ super defaultSpec
		add:
			(SpBoxLayout newHorizontal
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
RMDCellInitializerEditor >> initializeWidgets [
	super initializeWidgets.
	xDivisionsField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :int | 
			| nat |
			nat := int max: 1.
			xDivisionsField text: nat printString.
			node ifNotNil: [ node xDivisions: nat ] ];
		yourself.
	yDivisionsField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :int | 
			| nat |
			nat := int max: 1.
			yDivisionsField text: nat printString.
			node ifNotNil: [ node yDivisions: nat ] ];
		yourself.
	sizeField := self newNumberInput
		beFloat;
		autoAccept: true;
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
								type: newUnit).
					self updateSizeField ] ];
		yourself
]

{ #category : #accessing }
RMDCellInitializerEditor >> nodeChanged [
	super nodeChanged.
	self
		updateXDivisionsField;
		updateYDivisionsField;
		updateSizeField;
		updateSizeUnitField
]

{ #category : #accessing }
RMDCellInitializerEditor >> sizeField [
	^ sizeField
]

{ #category : #accessing }
RMDCellInitializerEditor >> sizeUnitDropList [
	^ sizeUnitDropList
]

{ #category : #updating }
RMDCellInitializerEditor >> updateSizeField [
	node ifNotNil: [ sizeField text: node size literal ]
]

{ #category : #updating }
RMDCellInitializerEditor >> updateSizeUnitField [
	node ifNotNil: [ sizeUnitDropList selectItem: node size type ]
]

{ #category : #updating }
RMDCellInitializerEditor >> updateXDivisionsField [
	node ifNotNil: [ xDivisionsField text: node xDivisions printString ]
]

{ #category : #updating }
RMDCellInitializerEditor >> updateYDivisionsField [
	node ifNotNil: [ yDivisionsField text: node yDivisions printString ]
]

{ #category : #accessing }
RMDCellInitializerEditor >> xDivisionsField [
	^ xDivisionsField
]

{ #category : #accessing }
RMDCellInitializerEditor >> yDivisionsField [
	^ yDivisionsField
]
