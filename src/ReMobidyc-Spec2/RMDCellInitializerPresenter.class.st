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
			{
			(RMDUnit at: 'microm').
			(RMDUnit at: 'mm').
			(RMDUnit at: 'cm').
			(RMDUnit at: 'dm').
			(RMDUnit at: 'm').
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
