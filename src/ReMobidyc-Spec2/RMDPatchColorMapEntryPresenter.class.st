Class {
	#name : 'RMDPatchColorMapEntryPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'association',
		'minValueField',
		'colorDropList'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'specs' }
RMDPatchColorMapEntryPresenter class >> defaultLayout [
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

{ #category : 'instance creation' }
RMDPatchColorMapEntryPresenter class >> on: anAssociation [
	^ self new
		association: anAssociation;
		yourself
]

{ #category : 'accessing' }
RMDPatchColorMapEntryPresenter >> association: anAssociation [
	association := anAssociation.
	self associationChanged
]

{ #category : 'accessing' }
RMDPatchColorMapEntryPresenter >> associationChanged [
	self updateColorDropList.
	self updateMinValueField
]

{ #category : 'initialization' }
RMDPatchColorMapEntryPresenter >> initializePresenters [
	super initializePresenters.
	colorDropList := self newColorDropList
		whenSelectedItemChangedDo: [ :color | 
			color
				ifNotNil: [ association value: color.
					self valueChanged ] ];
		yourself.
	minValueField := self newSyntaxNodeTextInput
		beLiteral;
		whenLastValidSyntaxNodeChangedDo: [ :expression | 
			association key: expression.
			self valueChanged ];
		yourself
]

{ #category : 'accessing' }
RMDPatchColorMapEntryPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : 'accessing' }
RMDPatchColorMapEntryPresenter >> updateColorDropList [
	association
		ifNotNil: [ | color colors |
			color := association value.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: color ]
]

{ #category : 'accessing' }
RMDPatchColorMapEntryPresenter >> updateMinValueField [
	association ifNotNil: [ minValueField syntaxNode: association key ]
]
