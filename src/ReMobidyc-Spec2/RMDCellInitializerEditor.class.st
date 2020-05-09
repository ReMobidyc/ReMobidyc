Class {
	#name : #RMDCellInitializerEditor,
	#superclass : #RMDSpeciesInitializerEditor,
	#instVars : [
		'xDivisionsField',
		'yDivisionsField',
		'sizeField'
	],
	#category : #'ReMobidyc-Spec2'
}

{ #category : #specs }
RMDCellInitializerEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 10;
		spacing: 10;
		add:
			(SpBoxLayout newHorizontal
				add: #xDivisionsField expand: false;
				add:
					(SpBoxLayout newVertical
						addLast: ' x ' expand: false;
						yourself)
					width: 16;
				add: #yDivisionsField expand: false;
				add:
					(SpBoxLayout newVertical
						addLast: ' of ' expand: false;
						yourself)
					width: 25;
				add: #sizeField expand: false;
				add:
					(SpBoxLayout newVertical
						addLast: ' Cells' expand: false;
						yourself)
					width: 30;
				yourself)
			expand: false;
		yourself
]

{ #category : #initialization }
RMDCellInitializerEditor >> initializeWidgets [
	super initializeWidgets.
	xDivisionsField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenTextIsAcceptedDo: [ :text | 
			self
				fromString: text asString trim
				ifIntegerDo: [ :int | 
					| nat |
					nat := int max: 1.
					node ifNotNil: [ node xDivisions: nat ].
					xDivisionsField
						text: nat printString;
						color: self okColor ]
				ifError: [ xDivisionsField color: self errorColor ] ];
		yourself.
	yDivisionsField := self newNumberInput
		beInteger;
		autoAccept: true;
		whenTextIsAcceptedDo: [ :text | 
			self
				fromString: text asString trim
				ifIntegerDo: [ :int | 
					| nat |
					nat := int max: 1.
					node ifNotNil: [ node yDivisions: nat ].
					yDivisionsField
						text: nat printString;
						color: self okColor ]
				ifError: [ yDivisionsField color: self errorColor ] ];
		yourself.
	sizeField := self newExpressionTextInput
		beText;
		autoAccept: true;
		whenLastValidExpressionChangedDo: [ :expr | node ifNotNil: [ node size: expr ] ];
		yourself
]

{ #category : #accessing }
RMDCellInitializerEditor >> nodeChanged [
	super nodeChanged.
	self
		updateXDivisionsField;
		updateYDivisionsField;
		updateSizeField
]

{ #category : #updating }
RMDCellInitializerEditor >> updateSizeField [
	node ifNotNil: [ sizeField text: node size printString ]
]

{ #category : #updating }
RMDCellInitializerEditor >> updateXDivisionsField [
	node ifNotNil: [ xDivisionsField text: node xDivisions printString ]
]

{ #category : #updating }
RMDCellInitializerEditor >> updateYDivisionsField [
	node ifNotNil: [ yDivisionsField text: node yDivisions printString ]
]
