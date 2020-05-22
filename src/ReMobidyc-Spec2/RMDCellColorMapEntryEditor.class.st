Class {
	#name : #RMDCellColorMapEntryEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'association',
		'minValueField',
		'colorDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDCellColorMapEntryEditor class >> defaultSpec [
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
RMDCellColorMapEntryEditor class >> on: anAssociation [
	^ self new
		association: anAssociation;
		yourself
]

{ #category : #accessing }
RMDCellColorMapEntryEditor >> association: anAssociation [
	association := anAssociation.
	self associationChanged
]

{ #category : #accessing }
RMDCellColorMapEntryEditor >> associationChanged [
	self updateColorDropList.
	self updateMinValueField
]

{ #category : #initialization }
RMDCellColorMapEntryEditor >> initializeWidgets [
	super initializeWidgets.
	colorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | color ifNotNil: [ association value: color ] ];
		yourself.
	minValueField := self newExpressionTextInput
		autoAccept: true;
		isLiteralOnly: true;
		whenLastValidExpressionChangedDo: [ :expression | association key: expression ];
		yourself
]

{ #category : #accessing }
RMDCellColorMapEntryEditor >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #accessing }
RMDCellColorMapEntryEditor >> updateColorDropList [
	association
		ifNotNil: [ | color colors |
			color := association value.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: color ]
]

{ #category : #accessing }
RMDCellColorMapEntryEditor >> updateMinValueField [
	association ifNotNil: [ minValueField expression: association key ]
]
