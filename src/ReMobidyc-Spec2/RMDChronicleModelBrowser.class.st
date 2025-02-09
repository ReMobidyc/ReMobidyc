Class {
	#name : 'RMDChronicleModelBrowser',
	#superclass : 'RMDPresenter',
	#instVars : [
		'modelList',
		'nameField',
		'authorField',
		'dateField',
		'descriptionField',
		'searchField',
		'modelerButton',
		'updateButton'
	],
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'layout' }
RMDChronicleModelBrowser class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.4;
		  add: (SpBoxLayout newVertical
				   add: 'Metadata' asPresenter expand: false;
				   add: (SpGridLayout new
						    borderWidth: 0;
						    add: '    name' asPresenter at: 1 @ 1;
						    add: #nameField at: 2 @ 1;
						    add: '    author' asPresenter at: 1 @ 2;
						    add: #authorField at: 2 @ 2;
						    add: '    timestamp' asPresenter at: 1 @ 3;
						    add: #dateField at: 2 @ 3;
						    add: '    description' asPresenter at: 1 @ 4;
						    add: #descriptionField at: 2 @ 4;
						    columnHomogeneous: false;
						    column: 1 expand: false;
						    column: 2 expand: true;
						    yourself)
				   height: self buttonHeight * 4 + 5;
				   add: 'Full text search' asPresenter expand: false;
				   add: #searchField expand: false;
				   yourself);
		  add: (SpBoxLayout newVertical
				   add: #modelList;
				   add: (SpBoxLayout newHorizontal
						    add: #updateButton width: self buttonHeight;
						    add: ' ' asPresenter expand: false;
						    add: #modelerButton width: self buttonHeight;
						    yourself)
				   expand: false;
				   yourself);
		  yourself
]

{ #category : 'instance creation' }
RMDChronicleModelBrowser class >> open [

	<script: 'RMDChronicleModelBrowser open'>
	^ self new open
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> authorFieldChanged [

	self updateModelList
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> dateFieldChanged [

	self updateModelList
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> descriptionFieldChanged [

	self updateModelList
]

{ #category : 'initialization' }
RMDChronicleModelBrowser >> initializePresenters [

	super initializePresenters.
	modelList := self newTable
		             beResizable;
		             beSingleSelection;
		             addColumn: (SpStringTableColumn
				              title: 'name'
				              evaluated: [ :chronicleModel |
					              chronicleModel name ifNil: [ '' ] ]);
		             addColumn: (SpStringTableColumn
				              title: 'timestamp'
				              evaluated: [ :chronicleModel |
					              chronicleModel timestamp ifNil: [ '' ] ]);
		             addColumn: (SpStringTableColumn
				              title: 'description'
				              evaluated: [ :chronicleModel |
					              chronicleModel description
						              ifNotNil: [ :desc |
							              desc lines ifNotEmpty: #first ifEmpty: [ desc ] ]
						              ifNil: [ '' ] ]);
		             whenSelectedItemChangedDo: [ self selectedModelChanged ].
	nameField := self newTextInput whenSubmitDo: [ :s |
		             self nameFieldChanged ].
	authorField := self newTextInput whenSubmitDo: [ :s |
		               self authorFieldChanged ].
	dateField := self newTextInput whenSubmitDo: [ :s |
		             self dateFieldChanged ].
	descriptionField := self newTextInput whenSubmitDo: [ :s |
		                    self descriptionFieldChanged ].
	searchField := self newTextInput whenSubmitDo: [ :s |
		               self searchFieldChanged ].
	updateButton := self newButton
		                icon: self updateIcon;
		                action: [ self updateModelList ];
		                yourself.
	modelerButton := self newButton
		                 icon: self editIcon;
		                 action: [ self openInModeler ];
		                 disable;
		                 yourself.
	self updateModelList
]

{ #category : 'initialization' }
RMDChronicleModelBrowser >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		initialExtent: 1200 @ 600;
		title: 'Chronicle (models)'
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> nameFieldChanged [

	self updateModelList
]

{ #category : 'operations' }
RMDChronicleModelBrowser >> openInModeler [

	modelList selectedItem ifNotNil: [ :payload |
		(payload
			 load;
			 simulationModel) openInModeler ]
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> searchFieldChanged [

	self updateModelList
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> selectedModelChanged [

	modelList selectedItem ifNotNil: [ :chronicleModel |
		self updateButtons ]
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> updateButtons [

	modelList selectedItem
		ifNotNil: [ modelerButton enable ]
		ifNil: [ modelerButton disable ]
]

{ #category : 'updates' }
RMDChronicleModelBrowser >> updateModelList [

	| models |
	models := RMDChronicleStore chronicleRawModels.
	nameField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m name asLowercase includesSubstring: str ] ].
	authorField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m authors anySatisfy: [ :a |
				          a asLowercase includesSubstring: str ] ] ].
	dateField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m timestamp asLowercase includesSubstring: str ] ].
	descriptionField text asString trim asLowercase ifNotEmpty: [ :str |
		models := models select: [ :m |
			          m description asLowercase includesSubstring: str ] ].
	searchField text asString trim ifNotEmpty: [ :str |
		models := models select: [ :m | m includesSubstring: str ] ].
	modelList items: models.
	self updateButtons
]
