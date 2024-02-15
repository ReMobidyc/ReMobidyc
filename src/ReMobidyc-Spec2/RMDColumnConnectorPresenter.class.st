Class {
	#name : #RMDColumnConnectorPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'columnDropList',
		'attributeField',
		'unitField',
		'interpolationDropList',
		'leftIcon'
	],
	#category : #'ReMobidyc-Spec2-DataSource'
}

{ #category : #layout }
RMDColumnConnectorPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignEnd;
				   add: #columnDropList width: 150;
				   add: #leftIcon width: self buttonHeight;
				   add: #attributeField width: 150;
				   add: ' [' expand: false;
				   add: #unitField width: 60;
				   add: '] ' expand: false;
				   add: #interpolationDropList width: 100;
				   yourself)
		  height: self buttonHeight;
		  yourself
]

{ #category : #'instance creation' }
RMDColumnConnectorPresenter class >> openDialogWithColumns: anArrayOfString connector: aRMDAttributeColumnConnector onAccept: aBlock [

	| presenter |
	presenter := self withColumns: anArrayOfString.
	presenter columnConnector: aRMDAttributeColumnConnector.
	presenter openDialog okAction: [
		aBlock cull: presenter columnConnector ].
	^ presenter
]

{ #category : #'instance creation' }
RMDColumnConnectorPresenter class >> openDialogWithColumns: anArrayOfString onAccept: aBlock [

	| presenter |
	presenter := self withColumns: anArrayOfString.
	presenter openDialog okAction: [
		aBlock cull: presenter columnConnector ].
	^ presenter
]

{ #category : #'instance creation' }
RMDColumnConnectorPresenter class >> withColumns: anArrayOfColumns [

	^ self new
		  columns: anArrayOfColumns;
		  yourself
]

{ #category : #accessing }
RMDColumnConnectorPresenter >> attribute: aString [

	attributeField text: aString
]

{ #category : #accessing }
RMDColumnConnectorPresenter >> column: aString [

	columnDropList selectItem: aString
]

{ #category : #accessing }
RMDColumnConnectorPresenter >> columnConnector [

	| column attribute unit interpolation |
	column := columnDropList selectedItem ifNil: [ ^ nil ].
	attribute := attributeField syntaxNode ifNil: [ ^ nil ].
	unit := unitField syntaxNode ifNil: [ RMDUnit noDimension ].
	interpolation := interpolationDropList selectedItem ifNil: [
		                 RMDDataInterpolation default ].
	^ RMDAttributeColumnConnector
		  columnName: column
		  attribute: attribute
		  unit: unit
		  interpolation: interpolation
]

{ #category : #accessing }
RMDColumnConnectorPresenter >> columnConnector: aRMDAttributeColumnConnector [

	self column: aRMDAttributeColumnConnector columnName.
	self attribute: aRMDAttributeColumnConnector attribute.
	self unit: aRMDAttributeColumnConnector unit.
	self interpolation: aRMDAttributeColumnConnector interpolation
]

{ #category : #accessing }
RMDColumnConnectorPresenter >> columns: anArrayOfString [

	columnDropList items: anArrayOfString
]

{ #category : #initialization }
RMDColumnConnectorPresenter >> initializePresenters [

	super initializePresenters.
	columnDropList := self newDropList.
	attributeField := self newSyntaxNodeTextInput
		                  parser: RMDGrammar current identifier end;
		                  placeholder: 'attribute';
		                  autoAccept: true;
		                  yourself.
	unitField := self newSyntaxNodeTextInput
		             parser: RMDGrammar current unit;
		             placeholder: 'unit';
		             autoAccept: true;
		             yourself.
	interpolationDropList := self newDropList
		                         items: RMDDataInterpolation choices;
		                         selectItem: RMDLinearInterpolation current;
		                         yourself.
	leftIcon := self newImage
		            autoScale: false;
		            image: self leftIcon;
		            yourself
]

{ #category : #initialization }
RMDColumnConnectorPresenter >> initializeWindow: aSpWindow [

	super initializeWindow: aSpWindow.
	aSpWindow initialExtent: 550 @ 150
]

{ #category : #accessing }
RMDColumnConnectorPresenter >> interpolation: aRMDDataInterpolation [

	interpolationDropList selectItem: aRMDDataInterpolation
]

{ #category : #initialization }
RMDColumnConnectorPresenter >> leftIcon [

	^ Smalltalk ui iconNamed: #smallForward
]

{ #category : #accessing }
RMDColumnConnectorPresenter >> unit: aRMDUnit [

	unitField syntaxNode: aRMDUnit
]
