Class {
	#name : #RMDModelFileTextBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'#runOnMemoryButton',
		'#runOnFileButton',
		'#fileList',
		'#sourceText',
		'#modelFileReference => ObservableSlot',
		'#editingTexts',
		'#menuBar',
		'#runOnDryMemoryButton',
		'#openModelerButton',
		'#saveButton',
		'#exportButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDModelFileTextBrowser class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #menuBar height: self toolbarHeight;
		  add: (SpBoxLayout newHorizontal
				   add: #saveButton width: self buttonHeight;
				   add: #exportButton width: self buttonHeight;
				   add: '  ' expand: false;
				   add: #openModelerButton width: self buttonHeight;
				   yourself)
		  height: self buttonHeight;
		  add: (SpPanedLayout newHorizontal
				   add: #fileList;
				   add: #sourceText;
				   positionOfSlider: 0.3;
				   yourself)
]

{ #category : #'instance creation' }
RMDModelFileTextBrowser class >> on: aFileReference [

	^ self new
		  modelFileReference: aFileReference;
		  yourself
]

{ #category : #utilities }
RMDModelFileTextBrowser class >> openFromRepository [

	<script: 'RMDModelFileTextBrowser openFromRepository'>
	| browser |
	browser := RMDRepositoryModelsBrowser new forLoad.
	browser openDialog okAction: [ (self on: browser file) open ]
]

{ #category : #menus }
RMDModelFileTextBrowser class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #TextBrowser)
		parent: 'ReMobidyc';
		order: 2;
		label: 'Modeler (text)';
		action: [ RMDModelFileTextBrowser openFromRepository ];
		help: 'Open a text-based browser on a local repository'
]

{ #category : #operations }
RMDModelFileTextBrowser >> acceptSourceText [

	fileList selectedItem ifNotNil: [ :ref | 
		self acceptSourceTextAt: ref ]
]

{ #category : #operations }
RMDModelFileTextBrowser >> acceptSourceTextAt: fileReference [

	editingTexts at: fileReference ifPresent: [ :text | 
		fileReference
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: text asString ].
		editingTexts removeKey: fileReference ifAbsent: [  ].
		fileList
			items: fileList items;
			selectItem: fileReference ].
	self updateMetadata
]

{ #category : #parsers }
RMDModelFileTextBrowser >> actionsFileParser [

	^ RMDGrammar new actionsFile end
]

{ #category : #parsers }
RMDModelFileTextBrowser >> agentsFileParser [

	^ RMDGrammar new agentsFile end
]

{ #category : #menu }
RMDModelFileTextBrowser >> fileMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Open...';
						  action: [ 
							  RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
									  self modelFileReference: repBrowser file ] ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Save';
					  enabled: [ 
						  modelFileReference notNil and: [ editingTexts notEmpty ] ];
					  action: [ 
						  self simulationModel
							  updateMetadata;
							  exportModel: modelFileReference ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Save As...';
					  action: [ 
						  RMDRepositoryModelsBrowser
							  openForSave: (self simulationModel
									   updateMetadata;
									   yourself)
							  do: [ :model :repBrowser | 
							  self modelFileReference: repBrowser file ] ] ] ];
		  yourself
]

{ #category : #updating }
RMDModelFileTextBrowser >> forgetEditingTextAt: ref [

	editingTexts removeKey: ref ifAbsent: [  ]
]

{ #category : #parsers }
RMDModelFileTextBrowser >> freeTextParser [

	^ #any asPParser star flatten end
]

{ #category : #initialization }
RMDModelFileTextBrowser >> initialize [
	super initialize.
	editingTexts := Dictionary new
]

{ #category : #initialization }
RMDModelFileTextBrowser >> initializePresenters [

	super initializePresenters.
	menuBar := self newMenuBar
		           addGroup: [ :group | 
			           group addItem: [ :item | 
					           item
						           name: 'File';
						           subMenu: self fileMenu ] ];
		           yourself.
	saveButton := self newButton
			icon: self saveIcon;
			action: [ self saveAll ];
			help: 'Save the files.';
			yourself.
	exportButton := self newButton
			icon: self exportIcon;
			action: [ self export ];
			help: 'Export the model into repository.';
			yourself.
	openModelerButton := self newButton 
			icon: self modelerIcon ;
			action: [ self openInModeler ];
			help: 'Open the model in modeler.';
			yourself.
	fileList := self newList
		            display: [ :ref | ref basenameWithoutExtension ];
		            displayIcon: [ :ref | 
			            (editingTexts includesKey: ref) ifTrue: [ 
					            self editIcon ] ];
		            whenSelectionChangedDo: [ self updateSourceText ];
		            yourself.
	sourceText := (self newSourceWith: self freeTextParser)
		              contextMenu: [ self sourceTextContextMenu ];
		              whenTextChangedDo: [ self updateEditingText ];
		              whenSubmitDo: [ :text | self acceptSourceText ];
		              yourself.
	(self observablePropertyNamed: #modelFileReference) whenChangedDo: [ 
		self updateFileList ]
]

{ #category : #initialization }
RMDModelFileTextBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 800 @ 600
]

{ #category : #parsers }
RMDModelFileTextBrowser >> jsonParser [

	^ nil
]

{ #category : #accessing }
RMDModelFileTextBrowser >> modelFileReference [

	^ modelFileReference
]

{ #category : #accessing }
RMDModelFileTextBrowser >> modelFileReference: aFileReference [

	editingTexts removeAll.
	modelFileReference := aFileReference.
	self updateWindowTitle
]

{ #category : #operations }
RMDModelFileTextBrowser >> openInModeler [

	self simulationModel ifNotNil: [ :model | 
		model openInModeler modelFileReference: self modelFileReference ]
]

{ #category : #operations }
RMDModelFileTextBrowser >> saveAll [

	editingTexts keysAndValuesDo: [ :ref :text | 
		ref writeStreamDo: [ :stream | stream nextPutAll: text asString ] ].
	self updateMetadata.
	editingTexts removeAll
]

{ #category : #parsers }
RMDModelFileTextBrowser >> simulationFileParser [

	^ RMDGrammar new simulationFile end
]

{ #category : #accessing }
RMDModelFileTextBrowser >> simulationModel [

	^ RMDSimulationModel importModel: modelFileReference ifError: [ nil ]
]

{ #category : #menu }
RMDModelFileTextBrowser >> sourceTextContextMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Templates...';
						  subMenu: sourceText templateMenu ] ];
		  addGroup: [ :group | 
			  group addItem: [ :item | 
				  item
					  name: 'Accept';
					  shortcut: $s command;
					  action: [ self acceptSourceText ] ] ];
		  yourself
]

{ #category : #parsers }
RMDModelFileTextBrowser >> tasksFileParser [

	^ RMDGrammar new tasksFile end
]

{ #category : #private }
RMDModelFileTextBrowser >> title [

	^ 'Modeler' , (modelFileReference
		   ifNil: [ '' ]
		   ifNotNil: [ ' @ ' , modelFileReference basename ])
]

{ #category : #updating }
RMDModelFileTextBrowser >> updateEditingText [

	fileList selectedItem ifNotNil: [ :ref | 
		editingTexts
			at: ref
			ifPresent: [ editingTexts at: ref put: sourceText text ]
			ifAbsent: [ 
				| old new |
				old := ref contents.
				new := sourceText text asString.
				old ~= new ifTrue: [ editingTexts at: ref put: new ] ].
		fileList
			items: fileList items;
			selectItem: ref ]
]

{ #category : #updating }
RMDModelFileTextBrowser >> updateFileList [

	(modelFileReference isNil or: [ modelFileReference isDirectory not ]) 
		ifTrue: [ 
			fileList items: #(  ).
			^ self ].
	fileList items:
		(#( 'metadata.json' 'actions.rmd' 'agents.rmd' 'simulation.rmd'
		    'tasks.rmd' 'visualization.rmd' ) collect: [ :basename | 
			 (modelFileReference / basename) ensureCreateFile ])
]

{ #category : #operations }
RMDModelFileTextBrowser >> updateMetadata [

	| metadataRef metadata |
	metadataRef := modelFileReference / 'metadata.json'.
	metadata := [ 
	            metadataRef readStreamDo: [ :readStream | 
		            RMDMetadata fromJsonStream: readStream ] ]
		            on: Error
		            do: [ :ex | ^ nil ].
	metadata
		ensureCurrentAuthor;
		updateDate.
	[ 
	metadataRef ensureDelete lfWriteStreamDo: [ :stream | 
		metadata printJsonOn: stream ] ]
		on: Error
		do: [ :ex | ^ nil ].
	fileList selectedItem = metadataRef ifTrue: [ self updateSourceText ]
]

{ #category : #updating }
RMDModelFileTextBrowser >> updateParser [

	fileList selectedItem ifNotNil: [ :ref | 
		| basename |
		ref basename = 'metadata.json' ifTrue: [ 
			sourceText parser: self jsonParser.
			^ self ].
		basename := ref basenameWithoutExtension: 'rmd'.
		basename = 'actions' ifTrue: [ 
			sourceText parser: self actionsFileParser.
			^ self ].
		basename = 'agents' ifTrue: [ 
			sourceText parser: self agentsFileParser.
			^ self ].
		basename = 'simulation' ifTrue: [ 
			sourceText parser: self simulationFileParser.
			^ self ].
		basename = 'tasks' ifTrue: [ 
			sourceText parser: self tasksFileParser.
			^ self ].
		basename = 'visualization' ifTrue: [ 
			sourceText parser: self visualizationFileParser.
			^ self ] ].
	sourceText parser: self freeTextParser
]

{ #category : #updating }
RMDModelFileTextBrowser >> updateSourceText [

	self updateParser.
	fileList selectedItem ifNotNil: [ :item | 
		sourceText text: (editingTexts at: item ifAbsent: [ item contents ]) ]
]

{ #category : #private }
RMDModelFileTextBrowser >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self title ]
]

{ #category : #parsers }
RMDModelFileTextBrowser >> visualizationFileParser [

	^ RMDGrammar new visualizationFile end
]
