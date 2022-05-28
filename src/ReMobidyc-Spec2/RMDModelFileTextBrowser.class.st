Class {
	#name : #RMDModelFileTextBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'#fileList',
		'#sourceText',
		'#modelFileReference => ObservableSlot',
		'#editingTexts'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDModelFileTextBrowser class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: #fileList;
		  add: #sourceText;
		  positionOfSlider: 0.3;
		  yourself
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
	browser := RMDRepositoryModelsBrowser new forSave.
	browser openDialog okAction: [ (self on: browser file) open ]
]

{ #category : #menus }
RMDModelFileTextBrowser class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #TextBrowser)
		parent: 'ReMobidyc';
		label: 'Text Model Browser';
		action: [ RMDModelFileTextBrowser openFromRepository ];
		help: 'Open a text-based browser on a local repository'
]

{ #category : #updating }
RMDModelFileTextBrowser >> acceptSourceText [

	fileList selectedItem ifNotNil: [ :ref | 
		self acceptSourceTextAt: ref ]
]

{ #category : #updating }
RMDModelFileTextBrowser >> acceptSourceTextAt: fileReference [

	editingTexts at: fileReference ifPresent: [ :text | 
		fileReference
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: text asString ].
		editingTexts removeKey: fileReference ifAbsent: [  ].
		fileList
			items: fileList items;
			selectItem: fileReference ]
]

{ #category : #parsers }
RMDModelFileTextBrowser >> actionsFileParser [

	^ RMDGrammar new actionsFile end
]

{ #category : #parsers }
RMDModelFileTextBrowser >> agentsFileParser [

	^ RMDGrammar new agentsFile end
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
	fileList := self newList
		            display: [ :ref | ref basenameWithoutExtension: 'rmd' ];
		            displayIcon: [ :ref | 
			            (editingTexts includesKey: ref) ifTrue: [ 
					            self editIcon ] ];
		            whenSelectionChangedDo: [ self updateSourceText ];
		            yourself.
	sourceText := (self newSourceWith: self freeTextParser)
		              whenTextChangedDo: [ self updateEditingText ];
		              whenSubmitDo: [:text | self acceptSourceText ];
		              yourself.
	(self observablePropertyNamed: #modelFileReference) whenChangedDo: [ 
		self updateFileList ]
]

{ #category : #initialization }
RMDModelFileTextBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Model Editor'
		,
		(modelFileReference
			 ifNotNil: [ :ref | ' (', ref printString, ')' ]
			 ifNil: [ '' ])
]

{ #category : #accessing }
RMDModelFileTextBrowser >> modelFileReference [

	^ modelFileReference
]

{ #category : #accessing }
RMDModelFileTextBrowser >> modelFileReference: aFileReference [

	modelFileReference := aFileReference
]

{ #category : #parsers }
RMDModelFileTextBrowser >> simulationFileParser [

	^ RMDGrammar new simulationFile end
]

{ #category : #parsers }
RMDModelFileTextBrowser >> tasksFileParser [

	^ RMDGrammar new tasksFile end
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

	(modelFileReference isNil or: [ modelFileReference isDirectory not]) 
		ifTrue: [ 
			fileList items: #(  ).
			^ self ].
	fileList items:
		(#( 'actions' 'agents' 'simulation' 'tasks' 'visualization' ) 
			 collect: [ :basename | 
				 (modelFileReference / basename withExtension: 'rmd')
					 ensureCreateFile ])
]

{ #category : #updating }
RMDModelFileTextBrowser >> updateParser [

	fileList selectedItem ifNotNil: [ :ref | 
		| basename |
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

{ #category : #parsers }
RMDModelFileTextBrowser >> visualizationFileParser [

	^ RMDGrammar new visualizationFile end
]
