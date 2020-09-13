Class {
	#name : #RMDCellColorMapEntryPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'association',
		'minValueField',
		'colorDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDCellColorMapEntryPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		borderWidth: 5;
		spacing: 5;
		add: '        ' expand: false;
		add: #colorDropList width: 60;
		add: ' if  ' expand: false;
		add: #minValueField width: 100;
		add: ' or above' expand: false;
		yourself
]

{ #category : #'instance creation' }
RMDCellColorMapEntryPresenter class >> on: anAssociation [
	^ self new
		association: anAssociation;
		yourself
]

{ #category : #accessing }
RMDCellColorMapEntryPresenter >> association: anAssociation [
	association := anAssociation.
	self associationChanged
]

{ #category : #accessing }
RMDCellColorMapEntryPresenter >> associationChanged [
	self updateColorDropList.
	self updateMinValueField
]

{ #category : #initialization }
RMDCellColorMapEntryPresenter >> initializePresenters [
	super initializePresenters.
	colorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | 
			color
				ifNotNil: [ association value: color.
					self valueChanged ] ];
		yourself.
	minValueField := self newSyntaxNodeTextInput
		autoAccept: true;
		beLiteral;
		whenLastValidSyntaxNodeChangedDo: [ :expression | 
			association key: expression.
			self valueChanged ];
		yourself
]

{ #category : #accessing }
RMDCellColorMapEntryPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #accessing }
RMDCellColorMapEntryPresenter >> updateColorDropList [
	association
		ifNotNil: [ | color colors |
			color := association value.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: color ]
]

{ #category : #accessing }
RMDCellColorMapEntryPresenter >> updateMinValueField [
	association ifNotNil: [ minValueField syntaxNode: association key ]
]
